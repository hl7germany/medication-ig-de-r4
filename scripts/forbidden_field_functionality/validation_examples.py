#!/usr/bin/env python3
"""
Test script to demonstrate the enhanced FHIR dosage text generator
with forbidden field validation.
"""

import json
from medication_dosage_validator import MedicationDosageTextGenerator

def create_test_resource_valid():
    """Create a valid FHIR MedicationRequest resource."""
    return {
        "resourceType": "MedicationRequest",
        "status": "active",
        "intent": "order",
        "medicationCodeableConcept": {
            "text": "Ibuprofen 400mg"
        },
        "subject": {
            "display": "Patient"
        },
        "dosageInstruction": [
            {
                "timing": {
                    "repeat": {
                        "frequency": 1,
                        "period": 1,
                        "periodUnit": "d",
                        "timeOfDay": ["08:00", "20:00"]
                    }
                },
                "doseAndRate": [
                    {
                        "doseQuantity": {
                            "value": 1,
                            "unit": "Stück",
                            "system": "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm",
                            "code": "TAB"
                        }
                    }
                ]
            }
        ]
    }

def create_test_resource_with_forbidden_fields():
    """Create a FHIR MedicationRequest resource with forbidden fields."""
    return {
        "resourceType": "MedicationRequest",
        "status": "active", 
        "intent": "order",
        "medicationCodeableConcept": {
            "text": "Ibuprofen 400mg"
        },
        "subject": {
            "display": "Patient"
        },
        "dosageInstruction": [
            {
                "sequence": 1,  # FORBIDDEN in DosageDgMP
                "patientInstruction": "Mit Wasser einnehmen",  # FORBIDDEN in DosageDgMP
                "timing": {
                    "code": {  # FORBIDDEN in TimingDgMP
                        "coding": [{
                            "system": "http://terminology.hl7.org/CodeSystem/v3-GTSAbbreviation",
                            "code": "BID"
                        }]
                    },
                    "repeat": {
                        "count": 5,  # FORBIDDEN in TimingDgMP
                        "frequency": 1,
                        "period": 1,
                        "periodUnit": "d",
                        "timeOfDay": ["08:00"]
                    }
                },
                "doseAndRate": [
                    {
                        "type": {  # FORBIDDEN in DosageDgMP
                            "coding": [{
                                "system": "http://terminology.hl7.org/CodeSystem/dose-rate-type",
                                "code": "ordered"
                            }]
                        },
                        "doseQuantity": {
                            "value": 1,
                            "unit": "Stück",
                            "system": "http://terminology.hl7.org/CodeSystem/v3-orderableDrugForm",
                            "code": "TAB"
                        }
                    }
                ],
                "maxDosePerPeriod": {  # FORBIDDEN in DosageDgMP
                    "numerator": {
                        "value": 10,
                        "unit": "mg"
                    },
                    "denominator": {
                        "value": 24,
                        "unit": "h"
                    }
                }
            }
        ]
    }

def test_valid_resource():
    """Test with a valid resource."""
    print("🟢 Test 1: Gültige FHIR Resource")
    print("=" * 50)
    
    resource = create_test_resource_valid()
    generator = MedicationDosageTextGenerator(strict_mode=True)  # Use new default
    
    text = generator.generate_dosage_text(resource)
    errors = generator.get_validation_errors()
    
    print(f"Generierter Text: {text}")
    print(f"Validierungsfehler: {len(errors)}")
    print()

def test_resource_with_forbidden_fields_normal_mode():
    """Test with forbidden fields in normal mode."""
    print("🟡 Test 2: Resource mit verbotenen Feldern (Continue Mode)")
    print("=" * 60)
    
    resource = create_test_resource_with_forbidden_fields()
    generator = MedicationDosageTextGenerator(strict_mode=False)  # Explicitly disable strict mode
    
    text = generator.generate_dosage_text(resource)
    errors = generator.get_validation_errors()
    
    print(f"Generierter Text: {text}")
    print(f"Anzahl Validierungsfehler: {len(errors)}")
    for error in errors:
        print(f"  - {error}")
    print()

def test_resource_with_forbidden_fields_strict_mode():
    """Test with forbidden fields in strict mode."""
    print("🔴 Test 3: Resource mit verbotenen Feldern (Strict Mode)")
    print("=" * 60)
    
    resource = create_test_resource_with_forbidden_fields() 
    generator = MedicationDosageTextGenerator(strict_mode=True)
    
    try:
        text = generator.generate_dosage_text(resource)
        print(f"Generierter Text: {text}")
    except ValueError as e:
        print(f"Erwarteter Fehler: {e}")
        errors = generator.get_validation_errors()
        print(f"Details: {len(errors)} Validierungsfehler gefunden")
    print()

def test_4_schema_example():
    """Test with 4-schema pattern."""
    print("🟢 Test 4: 4-Schema Beispiel")
    print("=" * 30)
    
    resource = {
        "resourceType": "MedicationRequest",
        "status": "active",
        "intent": "order", 
        "medicationCodeableConcept": {"text": "Ibuprofen 400mg"},
        "subject": {"display": "Patient"},
        "dosageInstruction": [
            {
                "timing": {
                    "repeat": {
                        "when": ["MORN"],
                        "frequency": 1,
                        "period": 1,
                        "periodUnit": "d"
                    }
                },
                "doseAndRate": [{"doseQuantity": {"value": 1, "unit": "Stück"}}]
            },
            {
                "timing": {
                    "repeat": {
                        "when": ["EVE"],
                        "frequency": 1,
                        "period": 1,
                        "periodUnit": "d"
                    }
                },
                "doseAndRate": [{"doseQuantity": {"value": 2, "unit": "Stück"}}]
            }
        ]
    }
    
    generator = MedicationDosageTextGenerator(strict_mode=True)  # Use new default
    text = generator.generate_dosage_text(resource)
    print(f"Generierter Text: {text}")
    print()

if __name__ == "__main__":
    print("Enhanced FHIR Medication Dosage Text Generator - Test Suite")
    print("=" * 70)
    print()
    
    test_valid_resource()
    test_resource_with_forbidden_fields_normal_mode()
    test_resource_with_forbidden_fields_strict_mode()
    test_4_schema_example()
    
    print("✅ Alle Tests abgeschlossen!")
