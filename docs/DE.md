# shae-pascal-student-records (Deutsch)

Ein Schülerdatensatz-Verwaltungssystem in echtem Free Pascal. Unterstützt
das Hinzufügen von Schülern (ID, Name, Note), Auflisten aller Schüler,
Suchen nach ID oder Name, Löschen von Schülern sowie Speichern und Laden von
Datensätzen in einer Textdatei.

## Anforderungen

- **Free Pascal Compiler (fpc)** — nicht lokal installiert. Siehe
  `scripts/install.sh`.

## Installation

```bash
./scripts/install.sh
```

## Verwendung

```bash
shae-pascal-student-records
# Menü: 1 Hinzufügen, 2 Auflisten, 3 nach ID suchen, 4 nach Name suchen,
# 5 Löschen, 6 Speichern, 7 Laden, 0 Beenden
```

## Build & Test

```bash
make build
make test
make clean
```

## Design

Entsprechend dem SHAE Field Manual: Papier `#F2EEE5`, Tinte `#191712`,
Oxid-Signal `#B3341B`, JetBrains Mono für Code, keine Gradiente/Glas/Schatten.
Siehe `DESIGN.md`.

## Lizenz

MIT. Siehe `LICENSE`.
