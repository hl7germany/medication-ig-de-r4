import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.hl7.fhir.model.Base;
import org.hl7.fhir.model.utilities.formats.FhirFormat;
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
 * Äquivalenzprüfung mit der FHIRPath-Engine des HL7-Validators (org.hl7.fhir.core): wertet alte und
 * neue Fassung jeder Invariante an den Kontext-Elementen aller Instanzen aus. Die Instanzen und Ausdrücke
 * schreibt equivalence.js (--hapi); die Ergebnisse gehen je Paar als JSON nach result.json zurück
 * ({"evaluations": n, "directions": {"false → true": {"count": n, "samples": [...]}}}), Bericht und
 * Freigabe erstellt equivalence.js. Ein Exit-Code ungleich 0 bedeutet einen Fehler, keine Abweichung.
 *
 * Aufruf: java -cp publisher.jar HapiEquivalence.java export.json result.json
 */
public class HapiEquivalence {
  static FHIRPathEngine fpe;

  public static void main(String[] args) throws Exception {
    JsonObject export = JsonParser.parseString(Files.readString(Path.of(args[0]))).getAsJsonObject();
    PrintStream out = System.out;
    System.setOut(new PrintStream(OutputStream.nullOutputStream()));
    ValidationEngine ve = new ValidationEngine.ValidationEngineBuilder()
        .withCanRunWithoutTerminologyServer(true).withNoTerminologyServer()
        .fromSource("hl7.fhir.r4.core#4.0.1");
    System.setOut(out);
    fpe = new FHIRPathEngine(ve.getContext());

    List<JsonObject> pairs = new ArrayList<>();
    List<ExpressionNode[]> parsed = new ArrayList<>();
    for (JsonElement p : export.getAsJsonArray("pairs")) {
      JsonObject o = p.getAsJsonObject();
      pairs.add(o);
      parsed.add(new ExpressionNode[]{fpe.parse(o.get("base").getAsString()), fpe.parse(o.get("head").getAsString())});
    }
    int[] evaluations = new int[pairs.size()];
    List<Map<String, List<String>>> directions = new ArrayList<>();
    for (int i = 0; i < pairs.size(); i++) directions.add(new LinkedHashMap<>());

    for (JsonElement e : export.getAsJsonArray("instances")) {
      JsonObject inst = e.getAsJsonObject();
      String name = inst.get("name").getAsString();
      byte[] bytes = inst.getAsJsonObject("resource").toString().getBytes(StandardCharsets.UTF_8);
      Element res = Manager.parseSingle(ve.getContext(), new ByteArrayInputStream(bytes), FhirFormat.JSON);
      for (int i = 0; i < pairs.size(); i++) {
        String context = pairs.get(i).get("context").getAsString();
        for (JsonElement t : inst.getAsJsonObject("targets").getAsJsonArray(context)) {
          String path = t.getAsString();
          for (Base target : fpe.evaluate(null, res, res, res, fpe.parse(path))) {
            evaluations[i]++;
            String before = result(res, target, parsed.get(i)[0]), after = result(res, target, parsed.get(i)[1]);
            if (!before.equals(after)) directions.get(i).computeIfAbsent(before + " → " + after, k -> new ArrayList<>()).add(name + ", " + path);
          }
        }
      }
    }

    JsonArray results = new JsonArray();
    for (int i = 0; i < pairs.size(); i++) {
      JsonObject directionsJson = new JsonObject();
      for (var d : directions.get(i).entrySet()) {
        JsonObject direction = new JsonObject();
        direction.addProperty("count", d.getValue().size());
        JsonArray samples = new JsonArray();
        d.getValue().stream().limit(3).forEach(samples::add);
        direction.add("samples", samples);
        directionsJson.add(d.getKey(), direction);
      }
      JsonObject result = new JsonObject();
      result.addProperty("evaluations", evaluations[i]);
      result.add("directions", directionsJson);
      results.add(result);
    }
    Files.writeString(Path.of(args[1]), results.toString(), StandardCharsets.UTF_8);
  }

  static String result(Element res, Base target, ExpressionNode expression) {
    try {
      List<Base> r = fpe.evaluate(null, res, res, target, expression);
      if (r.size() == 1 && r.get(0).isBooleanPrimitive()) return r.get(0).primitiveValue();
      return r.isEmpty() ? "leer" : r.size() + " Werte";
    } catch (Exception e) {
      return "Fehler";
    }
  }
}
