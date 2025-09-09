#!/usr/bin/env python3

import json
import sys
import os

# Add the scripts directory to path and import the class
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..', 'scripts'))

# Import by reading and executing the file
with open(os.path.join(os.path.dirname(__file__), 'scripts', 'medication-dosage-to-text.py')) as f:
    code = f.read()
    
# Remove the main() call at the end to avoid execution
lines = code.split('\n')
filtered_lines = []
in_main_block = False
for line in lines:
    if line.strip() == 'if __name__ == "__main__":':
        in_main_block = True
    if not in_main_block:
        filtered_lines.append(line)

exec('\n'.join(filtered_lines))

def test_schema_detection_bug():
    """Test that demonstrates the schema detection boolean bug."""
    print("=== Testing Schema Detection Boolean Bug ===")
    
    with open('fsh-generated/resources/MedicationRequest-Example-MR-Bug-MultipleTimeOfDay-Interval.json', 'r') as f:
        resource = json.load(f)

    generator = MedicationDosageTextGenerator()
    dosages = generator._extract_dosages(resource)
    timing = dosages[0].get('timing', {})
    repeat = timing.get('repeat', {})

    # Show the current implementation (buggy)
    has_day_of_week = 'dayOfWeek' in repeat and repeat['dayOfWeek']
    has_when = 'when' in repeat and repeat['when']
    has_time_of_day = 'timeOfDay' in repeat and repeat['timeOfDay']

    print(f"has_day_of_week = {repr(has_day_of_week)} (type: {type(has_day_of_week)})")
    print(f"has_when = {repr(has_when)} (type: {type(has_when)})")  
    print(f"has_time_of_day = {repr(has_time_of_day)} (type: {type(has_time_of_day)})")
    print(f"timeOfDay content = {repeat.get('timeOfDay')}")
    print()
    
    # Show what they should be (strict booleans)
    has_day_of_week_strict = bool('dayOfWeek' in repeat and repeat['dayOfWeek'])
    has_when_strict = bool('when' in repeat and repeat['when'])
    has_time_of_day_strict = bool('timeOfDay' in repeat and repeat['timeOfDay'])
    
    print("Fixed (strict boolean) versions:")
    print(f"has_day_of_week_strict = {repr(has_day_of_week_strict)} (type: {type(has_day_of_week_strict)})")
    print(f"has_when_strict = {repr(has_when_strict)} (type: {type(has_when_strict)})")  
    print(f"has_time_of_day_strict = {repr(has_time_of_day_strict)} (type: {type(has_time_of_day_strict)})")
    print()

def test_multiple_times_bug():
    """Test that demonstrates the multiple times bug."""
    print("=== Testing Multiple Times Bug ===")
    
    test_files = [
        'fsh-generated/resources/MedicationRequest-Example-MR-Bug-MultipleTimeOfDay-Interval.json',
        'fsh-generated/resources/MedicationRequest-Example-MR-Bug-MultipleWhen-Interval.json',
        'fsh-generated/resources/MedicationRequest-Example-MR-Bug-MultipleTimeOfDay-Daily.json'
    ]
    
    generator = MedicationDosageTextGenerator()
    
    for file_path in test_files:
        if os.path.exists(file_path):
            print(f"Testing {os.path.basename(file_path)}:")
            
            with open(file_path, 'r') as f:
                resource = json.load(f)
            
            dosages = generator._extract_dosages(resource)
            timing = dosages[0].get('timing', {})
            repeat = timing.get('repeat', {})
            
            if 'timeOfDay' in repeat:
                print(f"  timeOfDay in JSON: {repeat['timeOfDay']}")
            if 'when' in repeat:
                print(f"  when in JSON: {repeat['when']}")
                
            result = generator.generate_dosage_text(resource)
            print(f"  Generated text: {result}")
            print()

if __name__ == "__main__":
    test_schema_detection_bug()
    test_multiple_times_bug()
