---
description: GRETL SQL technisch pruefen gegen Zielstruktur
agent: gretl-sql-reviewer
---

Perform SQL QA for the given GRETL SQL script.

Required checks:

1. SQL compiles.
2. Referenced schemas/tables/columns exist in target environment metadata.
3. Resultset columns match expected target table columns structurally (name and compatible type).
4. Emit warnings for nullability and PK-related assumptions.

Return:

- machine-readable summary block
- concise human-readable conclusion
- explicit open fachliche questions
