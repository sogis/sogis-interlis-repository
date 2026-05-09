# Agent Rules For INTERLIS Modeling

## Purpose

This is the canonical active OpenCode instruction file for INTERLIS modeling in this repository. Use it for model creation, model review, model extension, and safe iteration with the `interlis-mcp` server.

Legacy/reference context:

- `/Users/stefan/sources/interlis-mcp/docs/agentic-interlis-roadmap.md`
- `/Users/stefan/sources/interlis-mcp/docs/INTERLIS.agent.md`

Those files are references only. If they conflict with this file, this file wins for OpenCode work in this repository.

## Working Principles

- Treat every `.ili` model as a cumulative artifact with a current file state.
- Prefer existing local model patterns over inventing new style.
- Use `interlis-mcp` for INTERLIS-specific generation, analysis, validation, rules, and corpus search.
- Do not invent fachliche semantics: no guessed attributes, roles, constraints, cardinalities, code lists, comments, meta attributes, or data mapping rules.
- Ask targeted questions when fachliche intent is missing.
- Keep edits small and validate after structural changes.

## INTERLIS Versionsregel

- Neue Modelle werden immer mit `INTERLIS 2.4;` erstellt.
- Bei bestehenden Modellen mit `INTERLIS 2.3;` wird vor jeder fachlichen Aenderung zuerst ein **Softupdate** gemacht.

Softupdate 2.3 -> 2.4 bedeutet ausschliesslich:

1. `INTERLIS 2.3;` auf `INTERLIS 2.4;` aendern.

Nicht erlaubt im Softupdate:

- keine weiteren inhaltlichen oder strukturellen Aenderungen
- keine Umbenennungen
- keine Reformatierung als Nebeneffekt

Pflicht nach Softupdate:

- `validateIliModel` ausfuehren.
- Bei Validierungsfehlern keine stillen Zusatzkorrekturen vornehmen, sondern Findings und Rueckfragen ausgeben.

## Vision Whiteboard Workflow

For whiteboard or UML class diagram photos, use a mandatory two-stage process:

1. Stage A: structured UML extraction with uncertainty markers.
2. Stage B: INTERLIS generation only after user confirmation or correction of the extraction.

Stage A output contract must include:

- Diagram context
- Classes
- Attributes (name, apparent type, optionality if visible)
- Relations
- Cardinalities (only if visibly encoded)
- Apparent enumerations
- Open points
- Uncertainties

Label every extracted statement as one of:

- `Faktisch erkannt`
- `Annahme`
- `Offene Frage`

Hard rule: no direct one-shot INTERLIS generation from image input without extraction confirmation.

## Mandatory Modeling Workflow

For every complete INTERLIS model creation, review, or structural change:

1. Run `analyzeIliModel`.
2. Run `checkModelingRules`.
3. Run `validateIliModel`.
4. Fix deterministic technical issues.
5. Re-run analysis, rule check, and validation after fixes.
6. Report automated findings separately from manual checks and fachliche questions.

Use `modelPurpose` deliberately:

- `CAPTURE` for normalized capture/editing models.
- `PUBLICATION` for flat publication models.
- `VALIDATION` for validation helper models.
- `UNKNOWN` only when the purpose is genuinely unclear.

## MCP Resources And Prompts

Use MCP resources when context is needed:

- `interlis://knowledge/handbook-rules` for curated modeling rules.
- `interlis://knowledge/agent-workflow` for the standard modeling workflow.
- `interlis://knowledge/model-corpus-index` for configured local `.ili` model corpus overview.

Use MCP prompts when starting a structured task:

- `interlis-modeling-agent` for new modeling tasks.
- `review-interlis-model` for model review.
- `extend-interlis-model` for controlled extension of an existing model.

## MCP Tool Groups

Agentic workflow:

- `analyzeIliModel`
- `listModelingRules`
- `checkModelingRules`
- `validateIliModel`
- `formatIliModel`
- `renameModelElement`

Local corpus:

- `indexConfiguredModels`
- `findSimilarModels`

Model structure snippets:

- `createModelSnippet`
- `createImportLine`
- `createTopicSnippet`
- `createClassSnippet`
- `createStructureSnippet`
- `createAssociationSnippet`

Domains, units, and meta attributes:

- `createEnumDomainSnippet`
- `createEnumTreeDomainSnippet`
- `createNumericDomainSnippet`
- `createCoordDomainSnippet`
- `createUnitSnippet`
- `createMetaAttributeBlock`

Attributes:

- `createAttributeLine`
- `createStructureAttributeLine`

Constraints:

- `createUniqueConstraint`
- `createMandatoryConstraint`
- `createSetConstraint`
- `createPresentIfConstraint`
- `createValueRangeConstraint`
- `createExistenceConstraint`

Geometry:

- `ensureGeometryDependencies`
- `listGeometryTypes`

Identifier hygiene:

- `sanitizeIdentifier`
- `validateIdentifier`
- `validateFqn`

Function lookup:

- `listMathFunctions`
- `listTextFunctions`

XTF examples and validation:

- `generateExampleXtf`
- `validateXtf`

## Snippet, Diff, And File Workflow

- If no current model file or model text exists, return ordinary `ili` snippets first. Do not produce a diff without a baseline.
- If a target file exists, prefer editing that file directly when the user asks for implementation.
- If asked for a patch or review output, use a unified diff with clear context.
- If asked for full model output, return the full updated `MODEL ... END` block in an `ili` code block.
- Snippet tools generate building blocks; integration into the cumulative model must still preserve imports, topic structure, domains, and declaration order.

## Modeling Guardrails

- Do not create a new `TOPIC` unless the user explicitly asks for one or the target model is new and no topic exists.
- If the user asks only for a class or structure without attributes, create an empty class or structure.
- Add attributes only when explicitly requested or already present in the existing model.
- Add roles and cardinalities only from explicit user input or existing source models.
- Add constraints only from explicit fachliche rules.
- Use `iliDoc` only when documentation was requested or provided.
- Use `metaAttributes` only when real INTERLIS meta attributes were requested or provided.
- Do not create free `!!` comments as substitutes for structured documentation/meta attributes.

## Imports And Geometry

- Use `createImportLine` for explicit import requests.
- Prefer qualified imports unless an existing local model pattern clearly differs.
- For geometry attributes, use `ensureGeometryDependencies` before manual geometry assembly.
- If a user uses vague geometry terms like "Polygon", "Flaeche", "Linie", or "Punkt", use `listGeometryTypes` or ask one targeted question when multiple interpretations are plausible.
- Integrate returned `importLinesToAdd`, `domainsToAdd`, and `attributeLine` into the cumulative model without duplicates.
- Validate the full model after geometry changes.

## Output Format

For reviews:

1. Blocking compiler/validation errors.
2. Automated rule findings.
3. Manual checks and fachliche questions.
4. Minimal next edit or recommendation.

For model changes:

- Show the changed model or patch.
- Then summarize `analyzeIliModel`, `checkModelingRules`, and `validateIliModel`.
- Keep findings ordered by severity: `ERROR`, `WARNING`, then `INFO`.

For whiteboard/UML image tasks:

1. First return the extraction report and uncertainty list.
2. Ask for explicit user confirmation/correction.
3. Only then return model output and analysis/check/validation results.

For list tools:

- If the user asks what options exist, present concise Markdown lists or tables.
- If a list tool is used only internally to resolve an unambiguous modeling request, do not dump the full list.

## Safety

- Treat destructive actions and production-impacting actions as approval-required.
- Do not run productive DB/schema changes without explicit approval.
- Do not overwrite unrelated local changes.
- Keep OpenCode outputs concise enough for `qwen3`; prefer one canonical instruction source over repeated long context.
- Treat low-confidence image interpretation as uncertainty, not as hidden assumptions.
