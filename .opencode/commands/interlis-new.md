---
description: Neues INTERLIS-Modell strukturiert erstellen
agent: interlis-modeler
---

Start a structured workflow for creating a new INTERLIS model.

The user prompt may be minimal. It only needs the known fachliche or technical content, for example:

- task or goal
- modelPurpose if known: `CAPTURE`, `PUBLICATION`, `VALIDATION`, or `UNKNOWN`
- target file if known
- fachlicher purpose
- structure requirements
- known meta attributes

The user does not need to provide sections for guardrails, working mode, checks, or output format. This command supplies those defaults.

Hard model header defaults for new models:

- The model name is derived from the target `.ili` filename without extension, for example `models/ARP/SO_ARP_Foo_20260515.ili` becomes `MODEL SO_ARP_Foo_20260515 (de)`.
- If the user provides a model name that differs from the target filename, the filename wins; report the correction before generating the final model.
- Use `AT "https://arp.so.ch"` as the repository-wide default `AT` URL, independent of folder, unless the user explicitly provides another URL.
- Use the current runtime date as ISO `YYYY-MM-DD` for `VERSION`; do not derive `VERSION` from examples or from a date embedded in the filename.
- Do not silently change `MODEL`, `AT`, or `VERSION` in existing models.

Hard SO defaults for generated models:

- Generated attribute names start with an uppercase letter, for example `Titel`, `ObjektId`, `BFSNr`.
- Do not lowercase valid fachliche or technical names supplied by the user.
- Preserve display labels with `!!@ ili2db.dispName` when a normalized identifier differs from the user-facing label.
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

Hard MCP-first construction rule:

- For every ordinary attribute, call `createAttributeLine` first.
- For every embedded structure attribute, call `createStructureAttributeLine` first.
- For every geometry attribute, call `ensureGeometryDependencies` first.
- `createClassSnippet` and `createStructureSnippet` may receive `attrLines` only from MCP-generated attribute lines.
- Raw INTERLIS attribute syntax is allowed only when no MCP tool covers the case; document this as `Tool-Gap` in the output.
- Speed, convenience, or tool payload complexity are not valid reasons to bypass MCP tools.
- The final output must include an `MCP-Konstruktionsuebersicht` listing which MCP tools were used for model, topic, classes/structures, attributes, geometry, and meta attributes.

First classify the user input:

1. `technisch praezise`
   - The prompt names concrete INTERLIS identifiers, imports, types, domains, geometry types, cardinalities, meta attributes, and target file.
   - If complete and consistent, create the model proposal directly.
   - If the user explicitly requests direct file creation, file edits are allowed after the technical consistency checks below.

2. `fachlich`
   - The prompt uses domain language, labels, or informal type descriptions such as "Flaeche", "Linie", "URL", "0 oder mehrere", or "zwingend".
   - Do not edit files immediately.
   - First produce a technical mapping table with:
     - fachlicher Begriff
     - INTERLIS identifier
     - type/domain/geometry
     - justification
     - open decision

For fachliche prompts, derive technical INTERLIS implementation only when justified by MCP tools, local model patterns, or explicit mapping rules. If multiple technical mappings are plausible, ask one targeted question with concrete options and a recommended default.

For common fachliche terms in new INTERLIS 2.4 SO models, use these standard mappings as default proposals:

| Fachliche term | Default proposal |
| --- | --- |
| `Punkt`, `Lage`, `Koordinate` | `GeometryCHLV95_V2.Coord2` |
| `Linie`, `Verlauf`, `Achse` | `GeometryCHLV95_V2.LineWithoutArcs` |
| `Flaeche`, `Polygon`, `Perimeter` | `GeometryCHLV95_V2.SurfaceWithoutArcs` |
| `flaechendeckend`, `Gebietseinteilung`, `Flaechen duerfen sich nicht ueberlappen`, `Geometrien duerfen sich nicht ueberlappen` | `GeometryCHLV95_V2.AreaWithoutArcs` |
| `mehrere Flaechen`, `MultiPolygon`, `Flaechensammlung` | `GeometryCHLV95_V2.MultiSurfaceWithoutArcs` |
| `URL`, `Link`, `URI` | `INTERLIS.URI` |
| `Datum` | `DATE` |
| `Text max N Zeichen` | `TEXT*N` |
| `Text` without maximum length | Ask for maximum length; propose `TEXT*500` |
| `Ganzzahl mit Wertebereich X bis Y` | `X .. Y` |
| `Zahl` without range | Ask for numeric type and range |
| `wahr/falsch`, `ja/nein` | `BOOLEAN`, only if truly binary |
| `zwingend` | `MANDATORY` |
| `optional` | no `MANDATORY` |
| `0 oder mehrere <Struktur>` | `BAG {0..*} OF <Struktur>` only for embedded structures; ask if a relationship, role, or reference is meant |

When a fachliche prompt uses one of these standard mappings, output the mapping table first and set `open decision` to a concrete confirmation question such as `Default bestaetigen?`. Do not edit files until the mapping is sufficiently confirmed.

For `GeometryCHLV95_V2.AreaWithoutArcs`, always include an explicit open decision, for example: `Soll dies eine topologische AREA-Geometrie sein, oder reichen unabhaengige SURFACE-Geometrien mit Validierungsregel gegen Ueberlappung?`

For standard geometry mappings to `GeometryCHLV95_V2.*`, call `ensureGeometryDependencies` with `chbase=true` and the qualified geometry type. Do not create local `Coord2` domains or inline `SURFACE WITH ... VERTEX ...` as a substitute for a mapped CHBase geometry type.

Import rule for predefined INTERLIS base types:

- Qualified references to `INTERLIS.*` base types, for example `INTERLIS.URI`, `INTERLIS.XMLDate`, or `INTERLIS.UUIDOID`, do not require an import.
- Do not add `IMPORTS INTERLIS;` or `IMPORTS UNQUALIFIED INTERLIS;` solely because attributes, OIDs, or other declarations use those qualified base types.
- Add import lines only for real external models that must be imported, for example `GeometryCHLV95_V2`.

Default workflow contract:

1. Classify the input.
2. Confirm or infer modelPurpose: `CAPTURE`, `PUBLICATION`, `VALIDATION`, or `UNKNOWN`.
3. Confirm or derive target model name, target file, language, `AT`, and `VERSION`.
4. Use `INTERLIS 2.4;` for new models.
5. For fachliche or mixed input, output a mapping table with fachlicher Begriff, INTERLIS identifier, type/domain/geometry, justification, and open decision.
6. Ask targeted questions for unresolved decisions that affect model correctness.
7. Use local model patterns only for technical conventions, not as fachliche source material unless explicitly requested.
8. Use MCP tools for snippets, identifier hygiene, geometry dependencies, analysis, rule checks, and validation.
9. Do not invent fachliche semantics: no guessed attributes, roles, constraints, cardinalities, code meanings, comments, meta attributes, or data mapping rules.

Only after the input is technically sufficient:

1. Create the complete `MODEL ... END` proposal or edit the target file if explicitly requested.
2. Run `analyzeIliModel`.
3. Run `checkModelingRules` with the chosen modelPurpose.
4. Run `validateIliModel`.
5. Fix deterministic technical issues.
6. Re-run analysis, rule check, and validation after fixes.

File editing rules:

- For fachliche or mixed prompts, do not edit files before the mapping and open decisions are sufficiently confirmed.
- For technically complete prompts, direct file creation is allowed only when the user explicitly asks for it.
- If the user asks for a proposal first, return the full `MODEL ... END` block and wait for confirmation before editing.

Return:

1. Input classification.
2. Technical mapping table or mapping summary.
3. Full `MODEL ... END` block or patch.
4. `analyzeIliModel`, `checkModelingRules`, and `validateIliModel` results grouped by `ERROR`, `WARNING`, and `INFO`.
5. `MCP-Konstruktionsuebersicht`.
6. Remaining open fachliche questions.
