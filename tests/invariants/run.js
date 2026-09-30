// Tabellengetriebene Tests für die FHIRPath-Invarianten des IG.
//
// Die Ausdrücke werden direkt aus den FSH-Dateien gelesen und mit fhirpath.js ausgewertet,
// ohne SUSHI und IG Publisher. Jeder Testfall läuft für alle angegebenen Ressourcentypen.
// Bewertet wird wie im HAPI-Validator: Nur das Ergebnis [true] erfüllt die Invariante,
// [false] und ein leeres Ergebnis verletzen sie.
//
// Aufruf: npm test (in tests/invariants)

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

function loadInvariants() {
  const invariants = {};
  for (const file of fshFiles(FSH_DIR)) {
    const s = fs.readFileSync(file, 'utf8');
    const re = /^Invariant:\s*(\S+)/gm;
    let m;
    while ((m = re.exec(s))) {
      const next = s.slice(m.index + 1).search(/^(Invariant|Profile|Extension|Logical|RuleSet|ValueSet|CodeSystem|Instance|Alias):/m);
      const block = next === -1 ? s.slice(m.index) : s.slice(m.index, m.index + 1 + next);
      const e = block.indexOf('Expression:');
      if (e === -1) continue;
      const q = block.indexOf('"', e);
      const severity = (block.match(/^Severity:\s*#(\w+)/m) || [])[1];
      invariants[m[1]] = { expression: readFshString(block, q), severity, file: path.relative(ROOT, file) };
    }
  }
  return invariants;
}

function buildResource(type, testCase) {
  const p = DOSAGE_PATH[type];
  const dosages = testCase.dosages ?? (testCase.dosage ? [testCase.dosage] : []);
  const json = JSON.stringify({ dosages, extension: testCase.extension }).replaceAll('{{resourceType}}', type);
  const { dosages: d, extension } = JSON.parse(json);
  const res = { resourceType: type, status: type === 'MedicationDispense' ? 'completed' : 'active', subject: { display: 'Patient' } };
  if (type === 'MedicationRequest') res.intent = 'order';
  res.medicationCodeableConcept = { text: 'Testmedikation' };
  if (extension) res.extension = extension;
  if (d.length) res[p] = d;
  return res;
}

// Wertet die Invariante an jedem Element des Kontexts aus. Erfüllt, wenn jedes Element [true] liefert.
function evaluate(expression, context, type, res) {
  const p = DOSAGE_PATH[type];
  const targets = [];
  if (context === 'Resource') targets.push(type);
  (res[p] || []).forEach((dosage, i) => {
    if (context === 'Dosage') targets.push(`${type}.${p}[${i}]`);
    if (context === 'Timing.repeat' && dosage.timing?.repeat) targets.push(`${type}.${p}[${i}].timing.repeat`);
  });
  const results = targets.map(t => fhirpath.evaluate(res, `${t}.select(${expression})`, { resource: res, rootResource: res }, r4));
  return { ok: results.every(r => r.length === 1 && r[0] === true), results };
}

function main() {
  const invariants = loadInvariants();
  const tested = new Set();
  let total = 0;
  const failures = [];
  for (const file of fs.readdirSync(CASES_DIR).filter(f => f.endsWith('.json')).sort()) {
    const blocks = JSON.parse(fs.readFileSync(path.join(CASES_DIR, file), 'utf8'));
    for (const block of blocks) {
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

main();
