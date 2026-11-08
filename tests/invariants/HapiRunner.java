import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.hl7.fhir.model.Base;
import org.hl7.fhir.model.utilities.formats.FhirFormat;
import org.hl7.fhir.services.context.IWorkerContext;
import org.hl7.fhir.services.elementmodel.Element;
import org.hl7.fhir.services.elementmodel.Manager;
import org.hl7.fhir.services.fhirpath.ExpressionNode;
import org.hl7.fhir.services.fhirpath.FHIRPathEngine;
import org.hl7.fhir.validation.ValidationEngine;

import java.io.ByteArrayInputStream;
import java.io.OutputStream;
import java.io.PrintStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;

/**
 * Wertet die Invarianten-Testfälle mit der FHIRPath-Engine des HL7-Validators (org.hl7.fhir.core) aus,
 * auf dem Element-Modell wie bei der Validierung. Die Testfälle exportiert run.js (--export).
 *
 * Abweichungen, die auf bekannte Fehler der Engine zurückgehen, stehen mit Issue in
 * hapi-known-deviations.json. Der Lauf schlägt fehl bei jeder anderen Abweichung und bei jedem
 * Eintrag, der nicht mehr zutrifft, damit die Liste nach einem Fix der Engine bereinigt wird.
 *
 * Danach wird jede Invariante an einer MedicationDispense mit 40 Dosierungen ausgewertet
 * (Summe über alle Kontext-Elemente, Median). Überschreitet eine Invariante das Budget,
 * schlägt der Lauf ebenfalls fehl. Für bekannte langsame Invarianten gilt das Limit aus
 * hapi-known-deviations.json (runtime); liegen sie unter einem Zehntel des Budgets, gibt es nur einen Hinweis.
 *
 * Aufruf: java -cp publisher.jar HapiRunner.java export.json hapi-known-deviations.json [budget-ms]
 */
public class HapiRunner {
  static IWorkerContext ctx;
  static FHIRPathEngine fpe;

  public static void main(String[] args) throws Exception {
    JsonObject export = read(args[0]);
    JsonObject known = read(args[1]);
    double budgetMs = args.length > 2 ? Double.parseDouble(args[2]) : 60;

    PrintStream out = System.out;
    System.setOut(new PrintStream(OutputStream.nullOutputStream()));
    ValidationEngine ve = new ValidationEngine.ValidationEngineBuilder()
        .withCanRunWithoutTerminologyServer(true).withNoTerminologyServer()
        .fromSource("hl7.fhir.r4.core#4.0.1");
    System.setOut(out);
    ctx = ve.getContext();
    fpe = new FHIRPathEngine(ctx);

    Map<String, ExpressionNode> expressions = new HashMap<>();
    JsonObject invariants = export.getAsJsonObject("invariants");
    for (String key : invariants.keySet())
      expressions.put(key, fpe.parse(invariants.getAsJsonObject(key).get("expression").getAsString()));

    List<String> failures = new ArrayList<>();
    checkCases(export.getAsJsonArray("cases"), expressions, known.getAsJsonArray("deviations"), failures);
    checkRuntime(export.getAsJsonObject("perf"), invariants, expressions, budgetMs, known.getAsJsonArray("runtime"), failures);

    if (!failures.isEmpty()) {
      System.out.println("\n" + failures.size() + " Fehlschläge:");
      failures.forEach(f -> System.out.println("- " + f));
      System.exit(1);
    }
  }

  static JsonObject read(String file) throws Exception {
    return JsonParser.parseString(Files.readString(Path.of(file))).getAsJsonObject();
  }

  static Element parse(JsonObject resource) throws Exception {
    byte[] bytes = resource.toString().getBytes(StandardCharsets.UTF_8);
    return Manager.parseSingle(ctx, new ByteArrayInputStream(bytes), FhirFormat.JSON);
  }

  /** Die Kontext-Elemente; die Pfade tragen den Ressourcentyp als Präfix. */
  static List<Base> targets(Element res, JsonArray paths) {
    List<Base> result = new ArrayList<>();
    for (JsonElement p : paths) result.addAll(fpe.evaluate(null, res, res, res, fpe.parse(p.getAsString())));
    return result;
  }

  /** Erfüllt, wenn jedes Kontext-Element genau [true] liefert. */
  static boolean satisfied(Element res, List<Base> targets, ExpressionNode expression) {
    for (Base t : targets) {
      List<Base> r = fpe.evaluate(null, res, res, t, expression);
      if (!(r.size() == 1 && r.get(0).isBooleanPrimitive() && "true".equals(r.get(0).primitiveValue()))) return false;
    }
    return true;
  }

  static JsonObject knownDeviation(JsonArray deviations, String invariant, String name, String type) {
    for (JsonElement e : deviations) {
      JsonObject d = e.getAsJsonObject();
      if (!d.get("invariant").getAsString().equals(invariant) || !d.get("case").getAsString().equals(name)) continue;
      if (!d.has("resourceTypes")) return d;
      for (JsonElement t : d.getAsJsonArray("resourceTypes")) if (t.getAsString().equals(type)) return d;
    }
    return null;
  }

  static void checkCases(JsonArray cases, Map<String, ExpressionNode> expressions, JsonArray deviations, List<String> failures) throws Exception {
    int passed = 0;
    Map<JsonObject, Integer> deviationHits = new LinkedHashMap<>();
    for (JsonElement d : deviations) deviationHits.put(d.getAsJsonObject(), 0);
    for (JsonElement e : cases) {
      JsonObject c = e.getAsJsonObject();
      String invariant = c.get("invariant").getAsString(), name = c.get("name").getAsString(), type = c.get("resourceType").getAsString();
      String label = c.get("file").getAsString() + ": " + invariant + " / " + type + " / " + name;
      boolean expect = c.get("expect").getAsBoolean();
      JsonObject known = knownDeviation(deviations, invariant, name, type);
      String deviation;
      try {
        Element res = parse(c.getAsJsonObject("resource"));
        boolean actual = satisfied(res, targets(res, c.getAsJsonArray("targets")), expressions.get(invariant));
        deviation = actual == expect ? null : "erwartet " + (expect ? "erfüllt" : "verletzt") + ", HAPI " + (actual ? "erfüllt" : "verletzt");
      } catch (Exception ex) {
        deviation = "Auswertungsfehler " + ex.getMessage();
      }
      if (known != null) {
        if (deviation == null) failures.add(label + ": als bekannte Abweichung eingetragen (" + known.get("issue").getAsString() + "), HAPI rechnet aber richtig. Eintrag in hapi-known-deviations.json entfernen.");
        else deviationHits.merge(known, 1, Integer::sum);
      } else if (deviation != null) {
        failures.add(label + ": " + deviation);
      } else {
        passed++;
      }
    }
    int expected = deviationHits.values().stream().mapToInt(Integer::intValue).sum();
    System.out.println(passed + "/" + cases.size() + " Testfälle mit HAPI bestanden, " + expected + " bekannte Abweichungen der Engine");
    deviationHits.forEach((d, n) -> {
      if (n > 0) System.out.println("  bekannt: " + d.get("invariant").getAsString() + " / " + d.get("case").getAsString() + " (" + n + "x, " + d.get("issue").getAsString() + ")");
      else failures.add("Eintrag ohne passenden Testfall in hapi-known-deviations.json: " + d.get("invariant").getAsString() + " / " + d.get("case").getAsString());
    });
  }

  interface Run { void run(); }

  /** Median in ms; Wiederholungen auf ein Zeitbudget begrenzt. */
  static double median(Run r) {
    long t0 = System.nanoTime();
    for (int i = 0; i < 5 && System.nanoTime() - t0 < 1_000_000_000L; i++) r.run();
    List<Long> times = new ArrayList<>();
    long t1 = System.nanoTime();
    while (times.size() < 15 && (times.size() < 3 || System.nanoTime() - t1 < 3_000_000_000L)) {
      long s = System.nanoTime();
      r.run();
      times.add(System.nanoTime() - s);
    }
    Collections.sort(times);
    return times.get(times.size() / 2) / 1e6;
  }

  static void checkRuntime(JsonObject perf, JsonObject invariants, Map<String, ExpressionNode> expressions, double budgetMs, JsonArray slow, List<String> failures) throws Exception {
    Map<String, JsonObject> limits = new HashMap<>();
    for (JsonElement e : slow) limits.put(e.getAsJsonObject().get("invariant").getAsString(), e.getAsJsonObject());
    for (String key : limits.keySet())
      if (!invariants.has(key)) failures.add("Laufzeit-Eintrag ohne getestete Invariante in hapi-known-deviations.json: " + key);
    Element res = parse(perf.getAsJsonObject("resource"));
    JsonObject paths = perf.getAsJsonObject("targets");
    int dosages = paths.getAsJsonArray("Dosage").size();
    List<Map.Entry<String, Double>> times = new ArrayList<>();
    for (String key : invariants.keySet()) {
      String context = invariants.getAsJsonObject(key).get("context").getAsString();
      List<Base> targets = targets(res, paths.getAsJsonArray(context));
      if (targets.isEmpty()) continue;
      ExpressionNode n = expressions.get(key);
      try {
        times.add(Map.entry(key, median(() -> { for (Base t : targets) fpe.evaluate(null, res, res, t, n); })));
      } catch (Exception ex) {
        failures.add("Laufzeitprüfung " + key + ": Auswertungsfehler " + ex.getMessage());
      }
    }
    times.sort((a, b) -> Double.compare(b.getValue(), a.getValue()));
    System.out.println(String.format(Locale.ROOT, "Laufzeit bei %d Dosierungen (Summe je Invariante über alle Kontext-Elemente, Budget %.0f ms):", dosages, budgetMs));
    for (int i = 0; i < Math.min(5, times.size()); i++)
      System.out.println(String.format(Locale.ROOT, "  %8.2f ms  %s", times.get(i).getValue(), times.get(i).getKey()));
    for (var t : times) {
      JsonObject limit = limits.get(t.getKey());
      double allowed = limit != null ? limit.get("limitMs").getAsDouble() : budgetMs;
      if (t.getValue() > allowed)
        failures.add(String.format(Locale.ROOT, "%s braucht bei %d Dosierungen %.1f ms (%s %.0f ms)", t.getKey(), dosages, t.getValue(), limit != null ? "Limit" : "Budget", allowed));
      else if (limit != null)
        System.out.println(String.format(Locale.ROOT, "  bekannt langsam: %s %.1f ms (Limit %.0f ms)%s", t.getKey(), t.getValue(), allowed,
            t.getValue() <= budgetMs / 10 ? " – liegt deutlich im Budget, Eintrag kann entfernt werden" : ""));
    }
  }
}
