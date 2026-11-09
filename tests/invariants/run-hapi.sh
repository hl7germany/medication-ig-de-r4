#!/usr/bin/env bash
# Invariantentests mit der FHIRPath-Engine des HL7-Validators (org.hl7.fhir.core).
# Die Engine kommt aus publisher.jar: $PUBLISHER_JAR, sonst input-cache/publisher.jar,
# sonst ~/.fhir/tools/publisher/publisher.jar. Optional: $INVARIANT_BUDGET_MS (Standard 60 ms)
# und $PERF_DOSAGES (Dosierungen in der Laufzeitprüfung, Standard 40).
set -euo pipefail
cd "$(dirname "$0")"

jar=""
for candidate in "${PUBLISHER_JAR:-}" ../../input-cache/publisher.jar "$HOME/.fhir/tools/publisher/publisher.jar"; do
  if [ -n "$candidate" ] && [ -f "$candidate" ]; then jar="$candidate"; break; fi
done
if [ -z "$jar" ]; then
  echo "publisher.jar nicht gefunden, PUBLISHER_JAR setzen" >&2
  exit 2
fi
echo "Engine aus $jar ($(java -jar "$jar" -v 2>/dev/null | tail -1))"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
node run.js --export "$tmp/export.json"
java -cp "$jar" HapiRunner.java "$tmp/export.json" hapi-known-deviations.json "${INVARIANT_BUDGET_MS:-60}"
