#!/bin/bash
publisher_jar=publisher.jar
input_cache_path=./input-cache/
echo Checking internet connection...
curl -sSf tx.fhir.org > /dev/null

if [ $? -eq 0 ]; then
    echo "Online"
    txoption=""
else
    echo "Offline"
    txoption="-tx n/a"
fi

echo "$txoption"

export JAVA_TOOL_OPTIONS="$JAVA_TOOL_OPTIONS -Dfile.encoding=UTF-8"

run_publisher() {
    local publisher_path="$1"
    shift

    # 1. Generate Sushi
    echo "Running Sushi..."
    sushi .
    if [ $? -ne 0 ]; then
        echo "Sushi failed. Aborting."
        exit 1
    fi

    # 2. Build Dosage Files
    echo "Generating dosage files..."
    python3 scripts/run-dosage-generate.py
    if [ $? -ne 0 ]; then
        echo "Dosage file generation failed. Aborting."
        exit 1
    fi

    # 3. Copy current script into the IG
    echo "Updating dosage-to-text.py in IG content..."
    rm -f input/content/dosage-to-text.py
    cp scripts/dosage-to-text.py input/content/
    if [ $? -ne 0 ]; then
        echo "Copying dosage-to-text.py failed. Aborting."
        exit 1
    fi

    # 4. Generate IG Publisher Content
    echo "Running IG Publisher (no-sushi)..."
    java -jar "$publisher_path" -ig . $txoption "$@" -no-sushi
}

# Usage remains the same:
publisher="$input_cache_path/$publisher_jar"
if test -f "$publisher"; then
    run_publisher "$publisher" "$@"
else
    publisher="../$publisher_jar"
    if test -f "$publisher"; then
        run_publisher "$publisher" "$@"
    else
        echo "IG Publisher NOT FOUND in input-cache or parent folder.  Please run _updatePublisher.  Aborting..."
    fi
fi
