// Mutationsprüfung der Invarianten: Erkennen die Testfälle naheliegende Fehler im Ausdruck?
//
// Für jede Invariante mit Testfällen entstehen Varianten des Ausdrucks (Mutanten), die sich an
// genau einer Stelle vom Original unterscheiden, etwa `and` statt `or` oder `<` statt `<=`.
// Ein Mutant ist erkannt, wenn mindestens ein Testfall ein anderes Ergebnis als erwartet liefert.
// Ein überlebender Mutant zeigt einen ungetesteten Teil der Regel, oder er ist gleichwertig zum
// Original. Gleichwertige Mutanten stehen mit Anzahl und Begründung je Invariante in
// mutation-known-survivors.json. Die Prüfung schlägt fehl, wenn bei einer Invariante mehr oder
// weniger Mutanten überleben als dort eingetragen.
//
// Aufruf: npm run test:mutation [-- <Invariante> ...] [-- --summary <Datei>]
// --summary schreibt den Bericht zusätzlich als Markdown (CI-Zusammenfassung).

const fs = require('fs');
const path = require('path');
const fhirpath = require('fhirpath');
const r4 = require('fhirpath/fhir-context/r4');
const { RESOURCE_TYPES, DOSAGE_PATH, loadInvariants, caseBlocks, expectFor, buildResource } = require('./run');

const KNOWN_FILE = 'mutation-known-survivors.json';

// Der ANTLR-Parser von fhirpath.js liefert die Zeichenpositionen jedes Teilausdrucks. Das Paket
// exportiert ihn nicht, deshalb über den Dateipfad (fhirpath ist in package.json fest versioniert).
const PARSER_DIR = path.join(path.dirname(require.resolve('fhirpath')), 'parser');
const antlr4 = require(path.join(PARSER_DIR, 'antlr4-index'));
const Lexer = require(path.join(PARSER_DIR, 'generated/FHIRPathLexer'));
const Parser = require(path.join(PARSER_DIR, 'generated/FHIRPathParser'));

function parseTree(expression) {
  const parser = new Parser(new antlr4.CommonTokenStream(new Lexer(new antlr4.InputStream(expression))));
  parser.removeErrorListeners();
  parser.buildParseTrees = true;
  return parser.entireExpression();
}

const kind = ctx => ctx.constructor.name.replace(/Context$/, '');
const span = ctx => [ctx.start.start, ctx.stop.stop + 1];
const operator = ctx => (ctx.children || []).find(c => c.symbol && !['(', ')', '.', ','].includes(c.getText()));

// Erzeugt alle Mutanten als { label, expression }. label nennt Art und Stelle des Eingriffs.
function mutants(expression) {
  const out = [];
  const lineOf = pos => expression.slice(0, pos).split('\n').length;
  const excerpt = (from, to) => {
    const t = expression.slice(from, to).replace(/\s+/g, ' ').trim();
    return t.length > 70 ? t.slice(0, 67) + '…' : t;
  };
  const replace = (from, to, text, label, site) =>
    out.push({ label: `${label} (Zeile ${lineOf(site[0])}: ${excerpt(...site)})`, expression: expression.slice(0, from) + text + expression.slice(to) });
  const swapOperator = (ctx, map, label) => {
    const op = operator(ctx);
    const to = map[op.getText()];
    if (to) replace(op.symbol.start, op.symbol.stop + 1, to, `${label}: ${op.getText()} → ${to}`, span(ctx));
  };
  // Ersetzt den ganzen Teilausdruck durch einen seiner Operanden; die Stelle nennt den entfernten.
  const keepOperand = (ctx, i, label) => {
    const operands = ctx.children.filter(c => !c.symbol);
    replace(...span(ctx), expression.slice(...span(operands[i])), label, span(operands[1 - i]));
  };
  // Umgebender Vergleich oder Aufruf eines Literals, damit die Stelle erkennbar ist.
  const around = ctx => {
    let c = ctx.parentCtx;
    while (c && /^(LiteralTerm|TermExpression|ParamList|Functn|FunctionInvocation)$/.test(kind(c))) c = c.parentCtx;
    return c && kind(c) !== 'EntireExpression' ? span(c) : span(ctx);
  };

  (function walk(ctx) {
    if (!ctx.children) return;
    switch (kind(ctx)) {
      case 'AndExpression':
        swapOperator(ctx, { and: 'or' }, 'Verknüpfung');
        keepOperand(ctx, 0, 'Klausel entfernt');
        keepOperand(ctx, 1, 'Klausel entfernt');
        break;
      case 'OrExpression':
        swapOperator(ctx, { or: 'and', xor: 'or' }, 'Verknüpfung');
        keepOperand(ctx, 0, 'Alternative entfernt');
        keepOperand(ctx, 1, 'Alternative entfernt');
        break;
      case 'ImpliesExpression':
        swapOperator(ctx, { implies: 'and' }, 'Verknüpfung');
        keepOperand(ctx, 1, 'Bedingung von implies entfernt');
        break;
      case 'EqualityExpression':
        swapOperator(ctx, { '=': '!=', '!=': '=', '~': '!~', '!~': '~' }, 'Vergleich');
        break;
      case 'InequalityExpression':
        swapOperator(ctx, { '<': '<=', '<=': '<', '>': '>=', '>=': '>' }, 'Vergleich');
        break;
      case 'InvocationExpression': {
        // <Ausdruck>.<Funktion>(…): Funktion tauschen oder Aufruf entfernen.
        const [target, , invocation] = ctx.children;
        const fn = kind(invocation) === 'FunctionInvocation' ? invocation.children[0] : null;
        const id = fn?.children[0];
        const name = id?.getText();
        const hasParams = fn?.children.some(c => !c.symbol && kind(c) === 'ParamList');
        // all(x) → exists(x) behält das Argument; die übrigen Tausche nur ohne Argument.
        const swap = hasParams ? { all: 'exists' } : { exists: 'empty', empty: 'exists', first: 'last', last: 'first', toInteger: 'toString' };
        if (swap[name]) replace(...span(id), swap[name], `Funktion: ${name}() → ${swap[name]}()`, span(ctx));
        if (name === 'not' || name === 'distinct')
          replace(...span(ctx), expression.slice(...span(target)), `.${name}() entfernt`, span(ctx));
        // %resource.<Pfad>: Pfad relativ zum aktuellen Element statt zur Ressource.
        if (target.getText() === '%resource')
          replace(span(ctx)[0], span(invocation)[0], '', '%resource. entfernt', span(ctx));
        break;
      }
      case 'NumberLiteral': {
        const text = ctx.getText();
        const n = Number(text);
        const decimals = (text.split('.')[1] || '').length;
        const step = decimals ? 10 ** -decimals : 1;
        for (const v of [n + step, n - step].filter(v => v >= 0))
          replace(...span(ctx), v.toFixed(decimals), `Zahl: ${text} → ${v.toFixed(decimals)}`, around(ctx));
        break;
      }
      case 'StringLiteral':
        replace(...span(ctx), "'mutiert'", `Text: ${ctx.getText()} → 'mutiert'`, around(ctx));
        break;
    }
    ctx.children.forEach(walk);
  })(parseTree(expression));

  const seen = new Set([expression]);
  return out.filter(m => !seen.has(m.expression) && seen.add(m.expression));
}

// Pfad aller Kontext-Elemente eines Testfalls und ihre Anzahl. Ausgewertet wird
// <Pfad>.select(<Ausdruck>) an der Ressource, kompiliert einmal je Mutant und Pfad. Wie im
// HAPI-Validator erfüllt nur [true] je Element die Invariante: Das Ergebnis muss genau so viele
// Werte haben wie Kontext-Elemente, und alle müssen true sein.
function contextPath(context, type, res) {
  const p = DOSAGE_PATH[type];
  const dosages = res[p] || [];
  if (context === 'Resource') return { base: type, n: 1 };
  if (context === 'Dosage') return { base: `${type}.${p}`, n: dosages.length };
  if (context === 'Timing') return { base: `${type}.${p}.timing`, n: dosages.filter(d => d.timing).length };
  return { base: `${type}.${p}.timing.repeat`, n: dosages.filter(d => d.timing?.repeat).length };
}

function makeChecker(expression, cases) {
  const compiled = {};
  const fn = base => (compiled[base] ??= fhirpath.compile(`${base}.select(${expression})`, r4));
  const holds = ({ resource, path: { base, n } }) => {
    if (n === 0) return true;
    const r = fn(base)(resource, { resource, rootResource: resource });
    return r.length === n && r.every(v => v === true);
  };
  // Erster Testfall, der ein anderes Ergebnis als erwartet liefert, sonst null.
  return () => cases.find(c => holds(c) !== c.expect) ?? null;
}

function main() {
  const args = process.argv.slice(2);
  const summaryIndex = args.indexOf('--summary');
  const summaryFile = summaryIndex === -1 ? null : args[summaryIndex + 1];
  if (summaryIndex !== -1) args.splice(summaryIndex, 2);
  const only = new Set(args);

  const invariants = loadInvariants();
  const casesByKey = {};
  for (const { block } of caseBlocks()) {
    if (!invariants[block.invariant] || (only.size && !only.has(block.invariant))) continue;
    for (const type of block.resourceTypes ?? RESOURCE_TYPES)
      for (const tc of block.cases) {
        const resource = buildResource(type, tc);
        (casesByKey[block.invariant] ??= []).push({ name: `${tc.name} (${type})`, expect: expectFor(tc, 'fhirpathjs'), resource, path: contextPath(block.context, type, resource) });
      }
  }

  const rows = [];
  const started = Date.now();
  for (const key of Object.keys(casesByKey).sort()) {
    const cases = casesByKey[key];
    const expression = invariants[key].expression;
    if (makeChecker(expression, cases)()) { rows.push({ key, error: 'Original besteht die Testfälle nicht (npm test)' }); continue; }
    const survivors = [];
    let killed = 0, invalid = 0;
    for (const m of mutants(expression)) {
      try { makeChecker(m.expression, cases)() ? killed++ : survivors.push(m.label); }
      catch { invalid++; }
    }
    rows.push({ key, cases: cases.length, killed, invalid, survivors });
  }

  // Abgleich mit den eingetragenen gleichwertigen Mutanten. Bei einer Auswahl von Invarianten nur diese.
  const known = JSON.parse(fs.readFileSync(path.join(__dirname, KNOWN_FILE), 'utf8')).survivors;
  const expected = key => known[key]?.count ?? 0;
  const valid = rows.filter(r => !r.error);
  const deviations = valid.filter(r => r.survivors.length !== expected(r.key)).map(r => r.survivors.length > expected(r.key)
    ? `${r.key}: ${r.survivors.length} überleben, eingetragen ${expected(r.key)}. Testfälle ergänzen oder gleichwertige Mutanten mit Begründung eintragen`
    : `${r.key}: ${r.survivors.length} überleben, eingetragen ${expected(r.key)}. Eintrag auf ${r.survivors.length} senken`);
  for (const key of Object.keys(known).filter(k => !only.size || only.has(k)))
    if (!rows.some(r => r.key === key)) deviations.push(`${key}: eingetragen, aber ohne Testfälle oder nicht mehr in den FSH-Dateien. Eintrag entfernen`);

  const total = valid.reduce((s, r) => s + r.killed + r.survivors.length, 0);
  const killed = valid.reduce((s, r) => s + r.killed, 0);
  const lines = [`Mutationsprüfung: ${killed}/${total} Mutanten erkannt (${total ? Math.round(100 * killed / total) : 100} %), ${valid.length} Invarianten, ${((Date.now() - started) / 1000).toFixed(0)} s`];
  for (const r of rows.filter(r => r.error)) lines.push('', `${r.key}: ${r.error}`);
  if (deviations.length) lines.push('', `Abweichungen von ${KNOWN_FILE}:`, ...deviations.map(d => `  - ${d}`));
  else lines.push(`Überlebende Mutanten wie in ${KNOWN_FILE} eingetragen`);
  for (const r of valid.filter(r => r.survivors.length).sort((a, b) => b.survivors.length - a.survivors.length)) {
    lines.push('', `${r.key}: ${r.survivors.length} von ${r.killed + r.survivors.length} Mutanten überleben (${r.cases} Testfälle, eingetragen ${expected(r.key)})`);
    r.survivors.forEach(s => lines.push(`  - ${s}`));
  }
  const report = lines.join('\n');
  console.log(report);
  if (summaryFile) fs.appendFileSync(summaryFile, `## Mutationsprüfung der Invarianten\n\n\`\`\`\n${report}\n\`\`\`\n`);
  if (deviations.length || rows.some(r => r.error)) process.exit(1);
}

main();
