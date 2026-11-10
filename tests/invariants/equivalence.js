// Äquivalenzprüfung: Liefert eine umgeformte Invariante dieselben Ergebnisse wie ihre frühere Fassung?
//
// Für jede Invariante, deren Ausdruck sich gegenüber einem Git-Stand (--base) unterscheidet, werden
// beide Fassungen an jedem Kontext-Element ausgewertet und die Ergebnisse verglichen (true, false,
// leer, mehrere Werte, Fehler). Ausgewertet wird an
//   - den Ressourcen aller Testfälle aus cases/*.json,
//   - Zufallsinstanzen mit Kombinationen aus Timing- und Dosisfeldern (--random, fester Seed),
//   - JSON-Ressourcen aus Verzeichnissen (--examples, etwa fsh-generated/resources nach SUSHI).
// fhirpath.js rechnet immer; mit --hapi zusätzlich die Engine des HL7-Validators (HapiEquivalence.java).
// Den Kontext jeder Invariante liefern die Testfälle; Invarianten ohne Testfälle werden übersprungen.
//
// Aufruf: npm run test:equivalence -- --base <ref> [--head <ref>] [--random <n>] [--seed <n>]
//         [--examples <dir>] [--hapi] [--approval <datei>] [--summary <datei>] [<Invariante> ...]
// Ohne --head gilt der Stand im Arbeitsverzeichnis. Unterscheiden sich Ergebnisse, endet der Lauf mit
// Exit-Code 1. Bei einer gewollten fachlichen Änderung ist das erwartet; der Bericht zeigt die Richtung
// und endet mit einem Freigabe-Block (Zeile "Äquivalenz-Freigabe:" und eine Zeile je Abweichungsrichtung).
//
// --approval liest einen Text, etwa die PR-Beschreibung, und vergleicht dessen Freigabe-Block mit den
// Abweichungen dieses Laufs. Exit-Code 0 genau dann, wenn beide übereinstimmen (auch: keine Abweichung
// und kein Block). --summary hängt den Bericht als Markdown an eine Datei an (CI-Zusammenfassung).
// Falsche Argumente und Fehler beim Lauf ergeben Exit-Code 2.

const fs = require('fs');
const os = require('os');
const path = require('path');
const { execFileSync, spawnSync } = require('child_process');
const fhirpath = require('fhirpath');
const r4 = require('fhirpath/fhir-context/r4');
const { ROOT, RESOURCE_TYPES, DOSAGE_PATH, DECIMAL, invariantsIn, loadInvariants, caseBlocks, buildResource, targetsFor } = require('./run');

function parseArgs(argv) {
  const opts = { base: null, head: null, random: 3000, seed: 1, examples: [], hapi: false, approval: null, summary: null, only: [] };
  const value = (i, option) => {
    const v = argv[i];
    if (v === undefined || v.startsWith('--')) throw new Error(`${option} braucht einen Wert`);
    return v;
  };
  const count = (v, option) => {
    if (!/^\d+$/.test(v)) throw new Error(`${option} erwartet eine ganze Zahl ab 0, nicht '${v}'`);
    return Number(v);
  };
  for (let i = 0; i < argv.length; i++) {
    const a = argv[i];
    if (a === '--base') opts.base = value(++i, a);
    else if (a === '--head') opts.head = value(++i, a);
    else if (a === '--random') opts.random = count(value(++i, a), a);
    else if (a === '--seed') opts.seed = count(value(++i, a), a);
    else if (a === '--examples') opts.examples.push(value(++i, a));
    else if (a === '--hapi') opts.hapi = true;
    else if (a === '--approval') opts.approval = value(++i, a);
    else if (a === '--summary') opts.summary = value(++i, a);
    else if (a.startsWith('--')) throw new Error(`Unbekannte Option ${a}`);
    else opts.only.push(a);
  }
  if (!opts.base) throw new Error('--base <ref> fehlt, etwa --base origin/main');
  return opts;
}

// Invarianten aus den FSH-Dateien eines Git-Stands.
function invariantsAt(ref) {
  const git = (...args) => execFileSync('git', ['-C', ROOT, ...args], { encoding: 'utf8', maxBuffer: 64 * 1024 * 1024 });
  const files = git('ls-tree', '-r', '--name-only', ref, '--', 'input/fsh').split('\n').filter(f => f.endsWith('.fsh'));
  return Object.assign({}, ...files.map(f => invariantsIn(git('show', `${ref}:${f}`), f)));
}

// Zufallsinstanzen: Kombinationen der Felder, an denen die Timing- und Dosisregeln hängen.
function randomResources(n, seed) {
  let s = seed >>> 0;
  const rnd = () => { s = (s + 0x6D2B79F5) >>> 0; let t = s; t = Math.imul(t ^ (t >>> 15), t | 1); t ^= t + Math.imul(t ^ (t >>> 7), t | 61); return ((t ^ (t >>> 14)) >>> 0) / 4294967296; };
  const pick = a => a[Math.floor(rnd() * a.length)];
  const maybe = p => rnd() < p;
  const some = (a, max) => a.filter(() => maybe(max / a.length)).slice(0, max);
  const unit = code => code === '1'
    ? { unit: 'Stück', system: 'https://fhir.kbv.de/CodeSystem/KBV_CS_SFHIR_BMP_DOSIEREINHEIT', code: '1' }
    : code ? { unit: code, system: 'http://unitsofmeasure.org', code } : { unit: 'Stück' };
  const quantity = () => ({ value: pick([1, 2, 0.5, 0.25, 0.33, 1.5, 0, -1]), ...unit(pick(['1', '1', 'mg', 'mL', null])) });
  const repeat = () => {
    const r = {};
    if (maybe(0.5)) r.frequency = pick([1, 2, 3]);
    if (maybe(0.15)) r.frequencyMax = pick([2, 3, 4]);
    if (maybe(0.6)) r.period = pick([1, 1, 2, 3, 0.5, 0]);
    if (maybe(0.2)) r.periodMax = pick([2, 3, 4]);
    if (r.period !== undefined || maybe(0.1)) r.periodUnit = pick(['d', 'd', 'wk', 'mo', 'h']);
    if (maybe(0.3)) r.dayOfWeek = some(['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'], 3);
    if (maybe(0.3)) r.timeOfDay = some(['08:00:00', '12:00:00', '18:00:00', '22:00:00'], 2);
    if (maybe(0.3)) r.when = some(['MORN', 'NOON', 'EVE', 'NIGHT'], 2);
    if (maybe(0.3)) r.boundsDuration = { value: pick([1, 7, 14, 0, 1.5]), unit: 'Tag(e)', system: 'http://unitsofmeasure.org', code: pick(['d', 'd', 'wk']) };
    if (maybe(0.1)) r.count = pick([1, 3, 0]);
    for (const k of ['dayOfWeek', 'timeOfDay', 'when']) if (r[k] && !r[k].length) delete r[k];
    return r;
  };
  const doseAndRate = () => {
    const c = rnd();
    if (c < 0.55) return { doseQuantity: quantity() };
    if (c < 0.85) {
      const range = {};
      if (maybe(0.8)) range.low = quantity();
      if (maybe(0.8)) range.high = quantity();
      return { doseRange: range };
    }
    return { rateQuantity: { value: 5, unit: 'mL/h', system: 'http://unitsofmeasure.org', code: 'mL/h' } };
  };
  const dosage = () => {
    const d = {};
    if (maybe(0.9)) d.timing = { repeat: repeat() };
    const dar = Array.from({ length: pick([0, 1, 1, 1, 2]) }, doseAndRate);
    if (dar.length) d.doseAndRate = dar;
    if (maybe(0.1)) d.asNeededBoolean = true;
    if (maybe(0.1)) d.text = 'Freitext';
    return d;
  };
  return Array.from({ length: n }, (_, i) => {
    const dosages = [];
    for (let k = pick([1, 1, 2, 2, 3, 4]); k > 0; k--)
      dosages.push(dosages.length && maybe(0.1) ? JSON.parse(JSON.stringify(pick(dosages))) : dosage());
    return { name: `Zufall ${i + 1}`, resource: buildResource(pick(RESOURCE_TYPES), { dosages }) };
  });
}

function exampleResources(dirs) {
  return dirs.flatMap(dir => fs.readdirSync(dir).filter(f => f.endsWith('.json')).sort().flatMap(f => {
    const resource = JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8'));
    return RESOURCE_TYPES.includes(resource.resourceType) ? [{ name: f, resource }] : [];
  }));
}

function caseResources() {
  const seen = new Set();
  return caseBlocks().flatMap(({ file, block }) => (block.resourceTypes ?? RESOURCE_TYPES).flatMap(type => block.cases.flatMap(tc => {
    // Wie im HAPI-Job: fhirpath.js bekommt Zahlen, HAPI die Schreibweise aus {"$decimal": …}.
    const resource = buildResource(type, tc);
    const hapiResource = buildResource(type, tc, { keepDecimals: true });
    const id = JSON.stringify(hapiResource);
    if (seen.has(id)) return [];
    seen.add(id);
    return [{ name: `${file}: ${tc.name} (${type})`, resource, hapiResource }];
  })));
}

function classify(r) {
  if (r.length === 1 && typeof r[0] === 'boolean') return String(r[0]);
  return r.length === 0 ? 'leer' : `${r.length} Werte`;
}

// Vergleicht beide Fassungen an jedem Kontext-Element jeder Instanz.
function compare(pair, instances) {
  const compiled = {};
  const result = (expression, target, resource) => {
    try {
      const fn = (compiled[expression + '\0' + target] ??= fhirpath.compile(`${target}.select(${expression})`, r4));
      return classify(fn(resource, { resource, rootResource: resource }));
    } catch (e) { return 'Fehler'; }
  };
  const out = { evaluations: 0, directions: {} };
  for (const { name, resource } of instances)
    for (const target of targetsFor(pair.context, resource.resourceType, resource)) {
      out.evaluations++;
      const before = result(pair.base, target, resource), after = result(pair.head, target, resource);
      if (before === after) continue;
      const d = (out.directions[`${before} → ${after}`] ??= { count: 0, samples: [] });
      d.count++;
      if (d.samples.length < 3) d.samples.push(`${name}, ${target}`);
    }
  return out;
}

function report(engine, pairs, results, instances) {
  const changed = new Set(pairs.map(p => p.key.split(' ')[0])).size;
  const lines = [`Äquivalenz (${engine}): ${changed} geänderte ${changed === 1 ? 'Invariante' : 'Invarianten'}, ${instances} Instanzen`];
  pairs.forEach((p, i) => {
    const r = results[i];
    const n = Object.values(r.directions).reduce((s, d) => s + d.count, 0);
    lines.push(`${p.key}: ${r.evaluations} Auswertungen, ${n ? n + ' Abweichungen' : 'keine Abweichung'}`);
    for (const [dir, d] of Object.entries(r.directions)) lines.push(`  ${dir}: ${d.count}, z. B. ${d.samples.join('; ')}`);
  });
  return lines.join('\n');
}

const APPROVAL_HEADER = 'Äquivalenz-Freigabe:';

// Eine Zeile je Invariante (und Kontext) und Abweichungsrichtung, mit der Anzahl je Engine. Die Anzahl
// gehört dazu: Ändert sich die Invariante nach der Freigabe erneut, passt der Block nicht mehr.
function approvalLines(pairs, results, hapiResults) {
  const lines = [];
  pairs.forEach((p, i) => {
    const hapi = hapiResults ? hapiResults[i].directions : null;
    const directions = new Set([...Object.keys(results[i].directions), ...Object.keys(hapi ?? {})]);
    for (const dir of [...directions].sort()) {
      const counts = [`fhirpath.js ${results[i].directions[dir]?.count ?? 0}`];
      if (hapi) counts.push(`HAPI ${hapi[dir]?.count ?? 0}`);
      lines.push(`- ${p.key}: ${dir} (${counts.join(', ')})`);
    }
  });
  return lines;
}

// Der Freigabe-Block in einem Text: die Listenzeilen direkt nach "Äquivalenz-Freigabe:". Leerzeilen vor
// der ersten Zeile und Code-Zäune werden übersprungen, "->" gilt wie "→".
function approvedIn(text) {
  const lines = text.replace(/\r/g, '').split('\n').map(l => l.trim());
  const start = lines.indexOf(APPROVAL_HEADER);
  if (start === -1) return [];
  const approved = [];
  for (const line of lines.slice(start + 1)) {
    if (line.startsWith('```')) continue;
    if (line.startsWith('- ')) approved.push(line.replace(/\s*->\s*/g, ' → ').replace(/\s+/g, ' '));
    else if (line || approved.length) break;
  }
  return approved;
}

// Wertet beide Fassungen mit HAPI aus (HapiEquivalence.java); Ergebnisse in derselben Form wie compare().
function runHapi(pairs, instances) {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'aequivalenz-'));
  try {
    const file = path.join(dir, 'export.json'), resultFile = path.join(dir, 'result.json');
    const contextsUsed = [...new Set(pairs.map(p => p.context))];
    fs.writeFileSync(file, JSON.stringify({
      pairs,
      instances: instances.map(({ name, resource, hapiResource }) => ({ name, resource: hapiResource ?? resource, targets: Object.fromEntries(contextsUsed.map(c => [c, targetsFor(c, resource.resourceType, resource)])) }))
    }).replace(DECIMAL, '$1'));
    const run = spawnSync('java', ['-cp', publisherJar(), path.join(__dirname, 'HapiEquivalence.java'), file, resultFile], { stdio: 'inherit' });
    if (run.status !== 0) throw new Error(`HAPI-Lauf fehlgeschlagen (${run.error?.message ?? 'Exit-Code ' + (run.status ?? run.signal)})`);
    return JSON.parse(fs.readFileSync(resultFile, 'utf8'));
  } finally {
    fs.rmSync(dir, { recursive: true, force: true });
  }
}

function publisherJar() {
  const candidates = [process.env.PUBLISHER_JAR, path.join(ROOT, 'input-cache/publisher.jar'), path.join(os.homedir(), '.fhir/tools/publisher/publisher.jar')];
  const jar = candidates.find(c => c && fs.existsSync(c));
  if (!jar) throw new Error('publisher.jar nicht gefunden, PUBLISHER_JAR setzen');
  return jar;
}

function main() {
  const opts = parseArgs(process.argv.slice(2));
  const before = invariantsAt(opts.base);
  const after = opts.head ? invariantsAt(opts.head) : loadInvariants();
  // Kontexte je Invariante aus den Testfällen; manche Invarianten sind in mehreren getestet.
  const contexts = {};
  for (const { block } of caseBlocks()) (contexts[block.invariant] ??= new Set()).add(block.context);
  const keys = (opts.only.length ? opts.only : Object.keys(after).filter(k => before[k] && before[k].expression !== after[k].expression)).sort();
  const pairs = [], text = [];
  for (const key of keys) {
    if (!before[key] || !after[key]) { text.push(`${key}: fehlt in ${before[key] ? opts.head ?? 'Arbeitsverzeichnis' : opts.base}, übersprungen`); continue; }
    if (!contexts[key]) { text.push(`${key}: keine Testfälle, Kontext unbekannt, übersprungen`); continue; }
    for (const context of contexts[key])
      pairs.push({ key: contexts[key].size > 1 ? `${key} (${context})` : key, context, base: before[key].expression, head: after[key].expression });
  }

  let lines = [];
  if (!pairs.length) {
    text.push(`Keine geänderte Invariante gegenüber ${opts.base}.`);
  } else {
    const instances = [...caseResources(), ...randomResources(opts.random, opts.seed), ...exampleResources(opts.examples)];
    const results = pairs.map(p => compare(p, instances));
    text.push(report('fhirpath.js', pairs, results, instances.length));
    const hapiResults = opts.hapi ? runHapi(pairs, instances) : null;
    if (hapiResults) text.push(report('HAPI', pairs, hapiResults, instances.length));
    lines = approvalLines(pairs, results, hapiResults);
  }
  const block = [APPROVAL_HEADER, ...lines].join('\n');
  console.log(text.join('\n'));
  if (lines.length) console.log(`\n${block}`);

  // Ohne --approval zählt jede Abweichung; mit --approval nur eine, die der Block nicht freigibt.
  let status, missing = lines, stale = [];
  if (!opts.approval) {
    status = lines.length ? 'Abweichungen gefunden.' : 'Keine Abweichung.';
  } else {
    const approved = approvedIn(fs.readFileSync(opts.approval, 'utf8'));
    missing = lines.filter(l => !approved.includes(l));
    stale = approved.filter(l => !lines.includes(l));
    if (!missing.length && !stale.length) status = lines.length ? 'Alle Abweichungen sind freigegeben.' : 'Keine Abweichung.';
    else {
      const parts = [];
      if (missing.length) parts.push(`Nicht freigegeben:\n${missing.join('\n')}`);
      if (stale.length) parts.push(`Freigegeben, aber in diesem Lauf nicht aufgetreten:\n${stale.join('\n')}`);
      status = `Die Freigabe passt nicht zu den Abweichungen.\n${parts.join('\n')}\n` +
        (lines.length ? `Gewollte Abweichungen mit diesem Block in der PR-Beschreibung freigeben:\n${block}` : 'Den Freigabe-Block aus der PR-Beschreibung entfernen.');
      console.log(`\n${status}`);
    }
  }
  if (missing.length || stale.length) process.exitCode = 1;

  if (opts.summary) {
    let md = `## Äquivalenzprüfung der Invarianten\n\n\`\`\`\n${text.join('\n')}\n\`\`\`\n\n`;
    if (!missing.length && !stale.length) md += `${status}\n`;
    else {
      md += `**${opts.approval ? 'Die Freigabe passt nicht zu den Abweichungen.' : status}**\n\n`;
      if (opts.approval && missing.length) md += `Nicht freigegeben:\n\n${missing.join('\n')}\n\n`;
      if (stale.length) md += `Freigegeben, aber in diesem Lauf nicht aufgetreten:\n\n${stale.join('\n')}\n\n`;
      md += lines.length
        ? `Sind die Abweichungen gewollt, diesen Block in die PR-Beschreibung übernehmen:\n\n\`\`\`\n${block}\n\`\`\`\n`
        : 'Den Freigabe-Block aus der PR-Beschreibung entfernen.\n';
    }
    fs.appendFileSync(opts.summary, md);
  }
}

try {
  main();
} catch (e) {
  console.error(e.message);
  process.exit(2);
}
