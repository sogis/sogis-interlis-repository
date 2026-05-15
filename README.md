# sogis-interlis-repository
Official SO!GIS INTERLIS repository.

see [docs/betriebs-_und_nachfuehrungshandbuch.md](docs/betriebs-_und_nachfuehrungshandbuch.md)

## System Requirements
Java 17 or later.

## OpenCode Nutzung (Agenten und Commands)

In diesem Repository gibt es eigene OpenCode-Agenten in `.opencode/agents` und Commands in `.opencode/commands`.

Wichtig:

- Ein `@agent`-Aufruf startet nur den genannten Agenten.
- Ein `/command`-Aufruf startet den Inhalt der Command-Datei.

Das bedeutet konkret:

- `@interlis-vision-extractor` ruft den Subagent direkt auf, startet aber **nicht** automatisch `/whiteboard-to-ili`.
- `/whiteboard-to-ili` fuehrt den kompletten 2-Stufen-Workflow aus:
  - Stage A: UML/Whiteboard-Extraktion
  - Stage B: INTERLIS-Generierung erst nach Bestaetigung/Korrektur

Copy/Paste-Beispiele:

```text
@interlis-vision-extractor Analysiere dieses Whiteboard-Bild und liefere nur den UML-Extraktionsreport mit Unsicherheiten.
```

```text
/whiteboard-to-ili
```

Relevante Dateien:

- `.opencode/commands/whiteboard-to-ili.md`
- `.opencode/agents/interlis-vision-extractor.md`
- `.opencode/agents/interlis-modeler.md`



