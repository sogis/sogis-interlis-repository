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

## Implizite Standardregeln Fuer Prompts

Users do not need to write explicit guardrails, working mode, check commands, or output format in every prompt. If these sections are missing, apply these defaults:

- Do not invent fachliche semantics.
- Classify the input as technical INTERLIS-ready input, fachliche input, or mixed input.
- For fachliche or mixed input, output the technical mapping table before file edits.
- Ask targeted questions when required for a correct model.
- Do not edit files from fachliche prompts until the mapping and open decisions are sufficiently confirmed.
- For new models, use `INTERLIS 2.4;`.
- For new models, derive `MODEL <Name> (de)` from the target `.ili` filename without extension when a target file is known.
- For new models, use `AT "https://arp.so.ch"` as the repository-wide default unless the user explicitly provides another `AT` URL.
- For new models, set `VERSION "<YYYY-MM-DD>"` to the current runtime date in ISO format.
- Do not silently change `MODEL`, `AT`, or `VERSION` in existing models.
- After a model proposal or file edit, run `analyzeIliModel`, `checkModelingRules`, and `validateIliModel`.
- Return input classification, mapping summary, model output or patch, check results grouped by severity, and remaining open fachliche questions.

If the user explicitly requests direct file creation, it is allowed only for technically complete and consistent prompts. Fachliche prompts still require mapping confirmation before file edits.

## Fachliche Und Technische Eingaben

Users may provide either technical INTERLIS-ready input or fachliche domain input.

Technical input may name concrete INTERLIS identifiers, imports, types, domains, geometry types, cardinalities, and meta attributes. If complete and consistent, proceed directly to model proposal or file edits according to the requested working mode.

Fachliche input may use domain language such as "Flaeche", "Linie", "URL", "0 oder mehrere", "zwingend", or user-facing enum labels. For fachliche input:

- Translate fachliche terms into technical INTERLIS implementation only when the mapping is justified by MCP tools, local model patterns, or explicit mapping rules.
- Use `sanitizeIdentifier`, `validateIdentifier`, and `validateFqn` for identifier hygiene when deriving technical names.
- Preserve user-facing labels with `ili2db.dispName` where technical INTERLIS identifiers must differ from fachliche labels.
- Use `listGeometryTypes` and `ensureGeometryDependencies` for geometry terms before manual geometry assembly.
- Before editing files from a fachliche prompt, first provide a technical mapping table with: fachlicher Begriff, INTERLIS identifier, type/domain/geometry, justification, and open decision.
- If multiple technical mappings are plausible, ask one targeted question with concrete options and a recommended default.

Allowed technical derivations include identifier sanitization, standard INTERLIS primitive types, required imports, and geometry type candidates. Not allowed without explicit user input: fachliche semantics, roles, constraints, cardinalities, code meanings, and data mapping rules.

## Standard-Mappings Fuer Fachliche Begriffe

These mappings are binding default proposals for new INTERLIS 2.4 models in the SO context. They justify a technical suggestion, but they do not remove the confirmation requirement for fachliche prompts.

When using one of these mappings from fachliche input:

- Output the mapping table before editing files.
- Set `Offene Entscheidung` to a concrete confirmation question such as `Default bestaetigen?`.
- Use `listGeometryTypes` and `ensureGeometryDependencies` for geometry terms before assembling the final attribute/import lines.
- Do not treat a default mapping as permission to invent fachliche semantics.

Geometry defaults:

| Fachliche Begriffe | Default proposal |
| --- | --- |
| `Punkt`, `Lage`, `Koordinate` | `GeometryCHLV95_V2.Coord2` |
| `Linie`, `Verlauf`, `Achse` | `GeometryCHLV95_V2.LineWithoutArcs` |
| `Flaeche`, `Polygon`, `Perimeter` | `GeometryCHLV95_V2.SurfaceWithoutArcs` |
| `flaechendeckend`, `Gebietseinteilung`, `Flaechen duerfen sich nicht ueberlappen`, `Geometrien duerfen sich nicht ueberlappen` | `GeometryCHLV95_V2.AreaWithoutArcs` |
| `mehrere Flaechen`, `MultiPolygon`, `Flaechensammlung` | `GeometryCHLV95_V2.MultiSurfaceWithoutArcs` |

`GeometryCHLV95_V2.AreaWithoutArcs` is a stronger topological proposal than `GeometryCHLV95_V2.SurfaceWithoutArcs`. Always include an open decision for this mapping, for example: `Soll dies eine topologische AREA-Geometrie sein, oder reichen unabhaengige SURFACE-Geometrien mit Validierungsregel gegen Ueberlappung?`

Base type defaults:

| Fachliche Begriffe | Default proposal |
| --- | --- |
| `URL`, `Link`, `URI` | `INTERLIS.URI` |
| `Datum` | `DATE` |
| `Text max N Zeichen` | `TEXT*N` |
| `Text` without maximum length | Ask for the maximum length; propose local default `TEXT*500` |
| `Ganzzahl mit Wertebereich X bis Y` | `X .. Y` |
| `Zahl` without range | Ask for numeric type and value range |
| `wahr/falsch`, `ja/nein` | `BOOLEAN`, only if the fachliche meaning is truly binary |
| `zwingend` | `MANDATORY` |
| `optional` | no `MANDATORY` |
| `0 oder mehrere <Struktur>` | `BAG {0..*} OF <Struktur>` only for embedded structure values; ask if a relationship, role, or reference is meant |

Identifier defaults:

- Normalize fachliche labels with spaces, umlauts, punctuation, or other invalid characters into valid INTERLIS identifiers.
- Preserve the original user-facing label with `!!@ ili2db.dispName` where the technical identifier differs and the label matters for publication or database display.
- Validate derived names with `sanitizeIdentifier`, `validateIdentifier`, and `validateFqn`.

## SO Naming And Modeling Defaults

For newly generated SO models, use these hard defaults unless the user explicitly requests a different convention:

- The model name is the target filename without `.ili`, for example `models/ARP/SO_ARP_Foo_20260515.ili` becomes `MODEL SO_ARP_Foo_20260515 (de)`.
- If the user provides a model name that differs from the target filename, the filename wins; report the correction before generating the final model.
- Use `AT "https://arp.so.ch"` as the default `AT` URL for new models in this repository, independent of folder.
- Use the current runtime date as ISO `YYYY-MM-DD` for `VERSION` in new models; do not derive `VERSION` from examples or from a date embedded in the filename.
- Generated attribute names start with an uppercase letter, for example `Titel`, `ObjektId`, `BFSNr`.
- Do not lowercase valid fachliche or technical names supplied by the user.
- Normalize invalid labels into valid INTERLIS identifiers, but preserve the original label with `!!@ ili2db.dispName` when it matters for display or publication.
- For enum values from fachliche labels, use preserve-case snake_case, not CamelCase.
- Preserve the existing word casing and technical abbreviations in enum value identifiers.
- Replace whitespace, punctuation, slashes, and other separators in enum labels with `_`; collapse repeated `_` and trim leading/trailing `_`.
- Transliterate German characters in enum identifiers: `ä` -> `ae`, `ö` -> `oe`, `ü` -> `ue`, `Ä` -> `Ae`, `Ö` -> `Oe`, `Ü` -> `Ue`, `ß` -> `ss`.
- If an enum identifier differs from the fachliche label, preserve the original label on the enum item with `!!@ ili2db.dispName`, using MCP `itemSpecs` or meta attributes where available.
- Example: `"Baubewilligungspflicht für Indachanlagen, Meldepflicht für Aufdachanlagen"` becomes `Baubewilligungspflicht_fuer_Indachanlagen_Meldepflicht_fuer_Aufdachanlagen` with `ili2db.dispName` set to the original label.
- If a named element is later used as an embedded attribute type, for example `BAG/LIST OF <X>` or `0 oder mehrere <X>`, model `<X>` as `STRUCTURE` by default.
- Do not automatically model an element as `STRUCTURE` when it is not used later as an embedded attribute type; then the explicit user request or fachliche need decides.
- Use `CLASS` for standalone object classes such as `Baute`, or when object identity, lifecycle, references, roles, OID/TID, or associations are explicitly required.
- If the user says `JSON-Mapping notwendig`, attach `metaAttributes: [{ name: "ili2db.mapping", rawValue: "JSON" }]` directly to the affected `BAG` or `LIST` attribute.
- Simple value ranges such as `2000 bis 3000` are modeled inline on the attribute, for example `BFSNr : MANDATORY 2000 .. 3000;`.
- Do not create a separate `DOMAIN` for a simple value range unless the user explicitly asks for a domain or the same type is intentionally reused in multiple places.
- Do not add `OID AS INTERLIS.UUIDOID`, additional domains, classes, topics, roles, or constraints without explicit user input or a validated technical requirement.

## MCP-First Construction Rules

For model generation and structural edits, `interlis-mcp` tools are mandatory whenever they cover the requested building block.

- For every ordinary attribute, call `createAttributeLine` first.
- For every embedded structure attribute, call `createStructureAttributeLine` first.
- For every geometry attribute, call `ensureGeometryDependencies` first.
- `createClassSnippet` and `createStructureSnippet` may receive `attrLines` only from MCP-generated attribute lines.
- Raw INTERLIS attribute syntax is allowed only when no MCP tool covers the case; document this as `Tool-Gap` in the output.
- Speed, convenience, or tool payload complexity are not valid reasons to bypass MCP tools.
- The final output must include an `MCP-Konstruktionsuebersicht` listing which MCP tools were used for model, topic, classes/structures, attributes, geometry, and meta attributes.

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
- Do not pass hand-written attribute syntax into snippet-tool `attrLines` when `createAttributeLine`, `createStructureAttributeLine`, or `ensureGeometryDependencies` can generate the line.

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
- Qualified references to predefined INTERLIS base types such as `INTERLIS.URI`, `INTERLIS.XMLDate`, or `INTERLIS.UUIDOID` do not require an import.
- Do not add `IMPORTS INTERLIS;` or `IMPORTS UNQUALIFIED INTERLIS;` solely because attributes, OIDs, or other declarations use `INTERLIS.*` base types.
- Add import lines only for real external models that must be imported, for example `GeometryCHLV95_V2`.
- For geometry attributes, use `ensureGeometryDependencies` before manual geometry assembly.
- For standard geometry mappings to `GeometryCHLV95_V2.*`, call `ensureGeometryDependencies` with `chbase=true` and the qualified CHBase geometry type.
- Do not create local `Coord2` domains or inline `SURFACE WITH ... VERTEX ...` as a substitute for a mapped `GeometryCHLV95_V2.*` type.
- If a user uses geometry terms like "Polygon", "Flaeche", "Linie", or "Punkt", use the standard mappings above as default proposals, then use `listGeometryTypes` or ask one targeted question when multiple interpretations are plausible.
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
