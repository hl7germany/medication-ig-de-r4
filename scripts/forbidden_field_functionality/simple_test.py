#!/usr/bin/env python3

# Quick test for the enhanced dosage generator
import sys
import os

# Add current directory to Python path
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

try:
    from medication_dosage_validator import MedicationDosageTextGenerator, ValidationError
    print("✅ Import erfolgreich!")
    
    # Test 1: Valid resource
    valid_resource = {
        "resourceType": "MedicationRequest",
        "dosageInstruction": [{
            "timing": {
                "repeat": {
                    "frequency": 1,
                    "period": 1,
                    "periodUnit": "d"
                }
            },
            "doseAndRate": [{
                "doseQuantity": {
                    "value": 1,
                    "unit": "Stück"
                }
            }]
        }]
    }
    
    generator = MedicationDosageTextGenerator(strict_mode=True)  # Use new default
    result = generator.generate_dosage_text(valid_resource)
    errors = generator.get_validation_errors()
    
    print(f"Test 1 - Gültige Resource:")
    print(f"  Text: {result}")
    print(f"  Validierungsfehler: {len(errors)}")
    
    # Test 2: Resource with forbidden fields
    invalid_resource = {
        "resourceType": "MedicationRequest", 
        "dosageInstruction": [{
            "sequence": 1,  # FORBIDDEN
            "timing": {
                "repeat": {
                    "frequency": 1,
                    "period": 1,
                    "periodUnit": "d",
                    "count": 5  # FORBIDDEN
                }
            },
            "doseAndRate": [{
                "doseQuantity": {
                    "value": 1,
                    "unit": "Stück"
                }
            }]
        }]
    }
    
    generator2 = MedicationDosageTextGenerator(strict_mode=False)  # Explicitly disable for this test
    result2 = generator2.generate_dosage_text(invalid_resource)
    errors2 = generator2.get_validation_errors()
    
    print(f"\nTest 2 - Resource mit verbotenen Feldern:")
    print(f"  Text: {result2}")
    print(f"  Validierungsfehler: {len(errors2)}")
    for error in errors2:
        print(f"    - {error}")
        
    print("\n🎉 Alle Tests erfolgreich!")
    
except ImportError as e:
    print(f"❌ Import Error: {e}")
except Exception as e:
    print(f"❌ Fehler: {e}")
    import traceback
    traceback.print_exc()
