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
//         [--examples <dir>] [--hapi] [<Invariante> ...]
// Ohne --head gilt der Stand im Arbeitsverzeichnis. Unterscheiden sich Ergebnisse, endet der Lauf mit
// Exit-Code 1. Bei einer gewollten fachlichen Änderung ist das erwartet; der Bericht zeigt die Richtung.

const fs = require('fs');
const os = require('os');
const path = require('path');
const { execFileSync, spawnSync } = require('child_process');
const fhirpath = require('fhirpath');
const r4 = require('fhirpath/fhir-context/r4');
const { ROOT, RESOURCE_TYPES, DOSAGE_PATH, DECIMAL, invariantsIn, loadInvariants, caseBlocks, buildResource, targetsFor } = require('./run');

function parseArgs(argv) {
  const opts = { base: null, head: null, random: 3000, seed: 1, examples: [], hapi: false, only: [] };
  for (let i = 0; i < argv.length; i++) {
    const a = argv[i];
    if (a === '--base') opts.base = argv[++i];
    else if (a === '--head') opts.head = argv[++i];
    else if (a === '--random') opts.random = Number(argv[++i]);
    else if (a === '--seed') opts.seed = Number(argv[++i]);
    else if (a === '--examples') opts.examples.push(argv[++i]);
    else if (a === '--hapi') opts.hapi = true;
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
  let deviations = 0;
  pairs.forEach((p, i) => {
    const r = results[i];
    const n = Object.values(r.directions).reduce((s, d) => s + d.count, 0);
    deviations += n;
    lines.push(`${p.key}: ${r.evaluations} Auswertungen, ${n ? n + ' Abweichungen' : 'keine Abweichung'}`);
    for (const [dir, d] of Object.entries(r.directions)) lines.push(`  ${dir}: ${d.count}, z. B. ${d.samples.join('; ')}`);
  });
  console.log(lines.join('\n'));
  return deviations;
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
  const pairs = [];
  for (const key of keys) {
    if (!before[key] || !after[key]) { console.log(`${key}: fehlt in ${before[key] ? opts.head ?? 'Arbeitsverzeichnis' : opts.base}, übersprungen`); continue; }
    if (!contexts[key]) { console.log(`${key}: keine Testfälle, Kontext unbekannt, übersprungen`); continue; }
    for (const context of contexts[key])
      pairs.push({ key: contexts[key].size > 1 ? `${key} (${context})` : key, context, base: before[key].expression, head: after[key].expression });
  }
  if (!pairs.length) { console.log(`Keine geänderte Invariante gegenüber ${opts.base}.`); return; }

  const instances = [...caseResources(), ...randomResources(opts.random, opts.seed), ...exampleResources(opts.examples)];
  let deviations = report('fhirpath.js', pairs, pairs.map(p => compare(p, instances)), instances.length);

  if (opts.hapi) {
    const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'aequivalenz-'));
    const file = path.join(dir, 'export.json');
    const contextsUsed = [...new Set(pairs.map(p => p.context))];
    fs.writeFileSync(file, JSON.stringify({
      pairs,
      instances: instances.map(({ name, resource, hapiResource }) => ({ name, resource: hapiResource ?? resource, targets: Object.fromEntries(contextsUsed.map(c => [c, targetsFor(c, resource.resourceType, resource)])) }))
    }).replace(DECIMAL, '$1'));
    const run = spawnSync('java', ['-cp', publisherJar(), path.join(__dirname, 'HapiEquivalence.java'), file], { stdio: 'inherit' });
    fs.rmSync(dir, { recursive: true, force: true });
    if (run.status !== 0) deviations += 1;
  }
  if (deviations) process.exitCode = 1;
}

try {
  main();
} catch (e) {
  console.error(e.message);
  process.exit(2);
}
