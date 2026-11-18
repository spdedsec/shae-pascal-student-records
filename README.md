# shae-pascal-student-records

A student record management system written in authentic Free Pascal.
Supports adding students (id, name, grade), listing all students, searching
by id or name, deleting students, and saving/loading records to a text file.

Built to the [SHAE Field Manual design system] (see `DESIGN.md`).

[SHAE Field Manual design system]: ../shared/design-system.md

## Requirements

- **Free Pascal Compiler (fpc)** — not installed locally. The GitHub Actions
  runner may provide it; otherwise install it yourself (see `scripts/install.sh`).

## Install

```bash
./scripts/install.sh
# or, with a custom prefix:
PREFIX=~/.local/bin ./scripts/install.sh
```

Equivalent manual steps:

```bash
fpc -O2 -o student_records src/student_records.pas
install -m 0755 student_records /usr/local/bin/shae-pascal-student-records
```

## Usage

Run the program and use the interactive menu:

```bash
shae-pascal-student-records
=== Student Records ===
1. Add student
2. List all students
3. Search by id
4. Search by name
5. Delete student
6. Save to file
7. Load from file
0. Exit
Choice:
```

Records are stored as `id|name|grade` lines in a text file (default name you
choose at save/load time).

## Build & test

```bash
make build   # compile with fpc
make test    # run a scripted scenario through the menu (requires fpc)
make clean   # remove build artifacts
```

## Design

Documentation and help output follow the SHAE field manual: warm paper ground
`#F2EEE5`, ink `#191712`, oxide signal `#B3341B`, JetBrains Mono for code,
0px radius, 1px borders, no gradients/glass/shadows/pills. See `DESIGN.md`.

## License

MIT. See `LICENSE`.
