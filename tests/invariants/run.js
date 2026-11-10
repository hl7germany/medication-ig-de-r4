// Tabellengetriebene Tests für die FHIRPath-Invarianten des IG.
//
// Die Ausdrücke werden direkt aus den FSH-Dateien gelesen und mit fhirpath.js ausgewertet,
// ohne SUSHI und IG Publisher. Jeder Testfall läuft für alle angegebenen Ressourcentypen.
// Bewertet wird wie im HAPI-Validator: Nur das Ergebnis [true] erfüllt die Invariante,
// [false] und ein leeres Ergebnis verletzen sie.
//
// Aufruf: npm test (in tests/invariants)
//
// Mit --export <Datei> werden die Testfälle stattdessen als JSON geschrieben, für die Auswertung
// mit der FHIRPath-Engine des HL7-Validators (HapiRunner.java, npm run test:hapi).

const fs = require('fs');
const path = require('path');
const fhirpath = require('fhirpath');
const r4 = require('fhirpath/fhir-context/r4');

const ROOT = path.resolve(__dirname, '../..');
const FSH_DIR = path.join(ROOT, 'input/fsh');
const CASES_DIR = path.join(__dirname, 'cases');
const RESOURCE_TYPES = ['MedicationRequest', 'MedicationDispense', 'MedicationStatement'];
const DOSAGE_PATH = { MedicationRequest: 'dosageInstruction', MedicationDispense: 'dosageInstruction', MedicationStatement: 'dosage' };

function fshFiles(dir) {
  return fs.readdirSync(dir, { withFileTypes: true }).flatMap(e => {
    const p = path.join(dir, e.name);
    return e.isDirectory() ? fshFiles(p) : e.name.endsWith('.fsh') ? [p] : [];
  });
}

// Liest einen FSH-String ab Position i (einfach oder dreifach in Anführungszeichen).
function readFshString(s, i) {
  if (s.startsWith('"""', i)) {
    const end = s.indexOf('"""', i + 3);
    return s.slice(i + 3, end);
  }
  let out = '';
  for (let j = i + 1; j < s.length; j++) {
    const c = s[j];
    if (c === '\\') { out += s[++j]; continue; }
    if (c === '"') return out;
    out += c;
  }
  throw new Error('Unterminierter String');
}

// Invarianten einer FSH-Datei; file ist der Pfad relativ zum Repo.
function invariantsIn(s, file) {
  const invariants = {};
  const re = /^Invariant:\s*(\S+)/gm;
  let m;
  while ((m = re.exec(s))) {
    const next = s.slice(m.index + 1).search(/^(Invariant|Profile|Extension|Logical|RuleSet|ValueSet|CodeSystem|Instance|Alias):/m);
    const block = next === -1 ? s.slice(m.index) : s.slice(m.index, m.index + 1 + next);
    const e = block.indexOf('Expression:');
    if (e === -1) continue;
    const q = block.indexOf('"', e);
    const severity = (block.match(/^Severity:\s*#(\w+)/m) || [])[1];
    invariants[m[1]] = { expression: readFshString(block, q), severity, file };
  }
  return invariants;
}

function loadInvariants() {
  return Object.assign({}, ...fshFiles(FSH_DIR).map(file => invariantsIn(fs.readFileSync(file, 'utf8'), path.relative(ROOT, file))));
}

// Alle Testfall-Blöcke aus cases/*.json, in fester Reihenfolge.
function caseBlocks() {
  return fs.readdirSync(CASES_DIR).filter(f => f.endsWith('.json')).sort()
    .flatMap(file => JSON.parse(fs.readFileSync(path.join(CASES_DIR, file), 'utf8')).map(block => ({ file, block })));
}

// {"$decimal": "1.0"} steht in Testfällen für eine Dezimalzahl, deren Schreibweise zählt. JSON.parse
// macht aus 1.0 die Zahl 1; fhirpath.js bekommt die Zahl, der Export für HAPI die Schreibweise.
const DECIMAL = /\{"\$decimal":"(-?\d+(?:\.\d+)?)"\}/g;
const toNumber = (key, value) => value && typeof value === 'object' && typeof value.$decimal === 'string' ? Number(value.$decimal) : value;

function buildResource(type, testCase, { keepDecimals = false } = {}) {
  const p = DOSAGE_PATH[type];
  const dosages = testCase.dosages ?? (testCase.dosage ? [testCase.dosage] : []);
  const json = JSON.stringify({ dosages, extension: testCase.extension }).replaceAll('{{resourceType}}', type);
  const { dosages: d, extension } = JSON.parse(json, keepDecimals ? undefined : toNumber);
  const res = { resourceType: type, status: type === 'MedicationDispense' ? 'completed' : 'active', subject: { display: 'Patient' } };
  if (type === 'MedicationRequest') res.intent = 'order';
  res.medicationCodeableConcept = { text: 'Testmedikation' };
  if (extension) res.extension = extension;
  if (d.length) res[p] = d;
  return res;
}

// Pfade der Elemente, an denen die Invariante ausgewertet wird.
function targetsFor(context, type, res) {
  const p = DOSAGE_PATH[type];
  const targets = [];
  if (context === 'Resource') targets.push(type);
  (res[p] || []).forEach((dosage, i) => {
    if (context === 'Dosage') targets.push(`${type}.${p}[${i}]`);
    if (context === 'Timing' && dosage.timing) targets.push(`${type}.${p}[${i}].timing`);
    if (context === 'Timing.repeat' && dosage.timing?.repeat) targets.push(`${type}.${p}[${i}].timing.repeat`);
  });
  return targets;
}

// Wertet die Invariante an jedem Element des Kontexts aus. Erfüllt, wenn jedes Element [true] liefert.
function evaluate(expression, context, type, res) {
  const results = targetsFor(context, type, res).map(t => fhirpath.evaluate(res, `${t}.select(${expression})`, { resource: res, rootResource: res }, r4));
  return { ok: results.every(r => r.length === 1 && r[0] === true), results };
}

const WHEN = ['MORN', 'MORN.early', 'MORN.late', 'NOON', 'AFT', 'AFT.early', 'AFT.late', 'EVE', 'EVE.early', 'EVE.late', 'NIGHT', 'PHS', 'HS', 'WAKE', 'C', 'CM', 'CD', 'CV', 'AC', 'ACM', 'ACD', 'ACV', 'PC', 'PCM', 'PCD', 'PCV'];
const DAYS = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];

// Realistisch befüllte MedicationDispense mit n Dosierungen im angegebenen Schema für die Laufzeitprüfung.
// Im Schema when und dayOfWeek wiederholen sich die Werte, sobald n die Zahl der Codes übersteigt.
function perfResource(n, schema) {
  const dosages = Array.from({ length: n }, (_, i) => {
    const m = 6 * 60 + 15 * i;
    const time = `${String(Math.floor(m / 60)).padStart(2, '0')}:${String(m % 60).padStart(2, '0')}:00`;
    const slot = schema === 'when' ? { period: 1, periodUnit: 'd', when: [WHEN[i % WHEN.length]] }
      : schema === 'dayOfWeek' ? { period: 1, periodUnit: 'wk', dayOfWeek: [DAYS[i % DAYS.length]] }
      : { period: 1, periodUnit: 'd', timeOfDay: [time] };
    return {
      text: `${schema} ${i + 1}: je 1 Stück`,
      patientInstruction: 'Nicht zerkauen',
      timing: { repeat: { boundsDuration: { value: 14, unit: 'Tage', system: 'http://unitsofmeasure.org', code: 'd' }, frequency: 1, ...slot } },
      route: { coding: [{ system: 'http://standardterms.edqm.eu', code: '20053000', display: 'Oral use' }] },
      doseAndRate: [{ doseQuantity: { value: 1, unit: 'Stück', system: 'https://fhir.kbv.de/CodeSystem/KBV_CS_SFHIR_BMP_DOSIEREINHEIT', code: '1' } }]
    };
  });
  return buildResource('MedicationDispense', { dosages });
}

function exportCases(outFile) {
  const invariants = loadInvariants();
  const contexts = {};
  const cases = [];
  for (const { file, block } of caseBlocks()) {
    if (!invariants[block.invariant]) continue;
    contexts[block.invariant] = block.context;
    for (const type of block.resourceTypes ?? RESOURCE_TYPES) {
      for (const tc of block.cases) {
        const res = buildResource(type, tc, { keepDecimals: true });
        cases.push({ file, invariant: block.invariant, resourceType: type, name: tc.name, expect: tc.expect, resource: res, targets: targetsFor(block.context, type, res) });
      }
    }
  }
  const n = Number(process.env.PERF_DOSAGES || 40);
  const contextsList = ['Resource', 'Dosage', 'Timing', 'Timing.repeat'];
  const perf = ['timeOfDay', 'when', 'dayOfWeek'].map(schema => {
    const resource = perfResource(n, schema);
    return { schema, resource, targets: Object.fromEntries(contextsList.map(c => [c, targetsFor(c, 'MedicationDispense', resource)])) };
  });
  const out = {
    invariants: Object.fromEntries(Object.entries(contexts).map(([k, context]) => [k, { context, expression: invariants[k].expression }])),
    cases,
    perf
  };
  fs.writeFileSync(outFile, JSON.stringify(out).replace(DECIMAL, '$1'));
  console.log(`${cases.length} Testfälle zu ${Object.keys(contexts).length} Invarianten exportiert: ${outFile}`);
}

function main() {
  const invariants = loadInvariants();
  const tested = new Set();
  let total = 0;
  const failures = [];
  for (const { file, block } of caseBlocks()) {
    const inv = invariants[block.invariant];
    if (!inv) { failures.push(`${file}: Invariante ${block.invariant} nicht in den FSH-Dateien gefunden`); continue; }
    tested.add(block.invariant);
    for (const type of block.resourceTypes ?? RESOURCE_TYPES) {
      for (const tc of block.cases) {
        total++;
        const res = buildResource(type, tc);
        let outcome;
        try { outcome = evaluate(inv.expression, block.context, type, res); }
        catch (err) { failures.push(`${file}: ${block.invariant} / ${type} / ${tc.name}: Auswertungsfehler ${err.message}`); continue; }
        if (outcome.ok !== tc.expect)
          failures.push(`${file}: ${block.invariant} / ${type} / ${tc.name}: erwartet ${tc.expect ? 'erfüllt' : 'verletzt'}, Ergebnis ${JSON.stringify(outcome.results)}`);
      }
    }
  }
  const untested = Object.keys(invariants).filter(k => !tested.has(k)).sort();
  console.log(`${total - failures.length}/${total} Testfälle bestanden, ${tested.size}/${Object.keys(invariants).length} Invarianten mit Tests`);
  if (untested.length) console.log(`Ohne Tests: ${untested.join(', ')}`);
  if (failures.length) {
    console.log(`\n${failures.length} Fehlschläge:`);
    failures.forEach(f => console.log(`- ${f}`));
    process.exit(1);
  }
}

module.exports = { ROOT, RESOURCE_TYPES, DOSAGE_PATH, DECIMAL, invariantsIn, loadInvariants, caseBlocks, buildResource, targetsFor };

if (require.main === module) {
  const exportIndex = process.argv.indexOf('--export');
  if (exportIndex !== -1) exportCases(process.argv[exportIndex + 1]);
  else main();
}
