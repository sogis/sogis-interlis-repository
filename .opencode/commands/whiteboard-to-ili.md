---
description: Whiteboard/UML-Foto in zwei Stufen zu einem INTERLIS-Modell ueberfuehren
agent: interlis-vision-extractor
---

Run this workflow in two stages.

Stage A: UML extraction from image

1. Analyze the provided whiteboard/UML image.
2. Produce a structured extraction report with explicit uncertainty labels:
   - Faktisch erkannt
   - Annahme
   - Offene Frage
3. Do not generate final INTERLIS code in Stage A.

After Stage A, ask for explicit confirmation or correction:

- "Bestaetige den UML-Extraktionsreport oder nenne Korrekturen. Erst danach starte ich die INTERLIS-Generierung."

Stage B: INTERLIS generation and checks

Only after explicit user confirmation:

1. Hand over the confirmed extraction report to `@interlis-modeler`.
2. Generate or update the target INTERLIS model.
3. Run:
   - analyzeIliModel
   - checkModelingRules
   - validateIliModel
4. Return:
   - model output (or patch),
   - analysis/check/validation summary,
   - remaining manual checks and open fachliche questions.
