# shae-pascal-student-records
# Build / test / release for the Free Pascal student record system.
#
# Requires Free Pascal Compiler (fpc). Not available locally; the
# GitHub Actions runner may provide it. See scripts/install.sh.

PROJECT := shae-pascal-student-records
BIN     := student_records
SRC     := src/student_records.pas
PREFIX  ?= /usr/local/bin

.PHONY: all build test clean install release help

all: build

build: $(BIN)

$(BIN): $(SRC)
	@if command -v fpc >/dev/null 2>&1; then \
		fpc -O2 -o $(BIN) $(SRC); \
	else \
		echo "error: fpc is required to build $(PROJECT)"; \
		echo "install it (see scripts/install.sh) or set PATH"; \
		exit 1; \
	fi

test: build
	@echo "--- smoke test (interactive scenario piped to stdin) ---"
	@printf '1\n101\nAda Lovelace\n95.5\n1\n102\nGrace Hopper\n88.0\n2\n3\n101\n4\nAda Lovelace\n6\nrecords.txt\n7\nrecords.txt\n5\n101\n2\n0\n' | ./$(BIN)
	@echo "--- scenario finished ---"

clean:
	rm -f $(BIN) *.o *.ppu records.txt

install: build
	install -m 0755 $(BIN) "$(PREFIX)/$(PROJECT)"
	@echo "installed $(PROJECT) to $(PREFIX)/$(PROJECT)"

release: build
	@echo "Release artifacts are produced by .github/workflows/release.yml on tag push."
	@echo "Binary: $(BIN)"

help:
	@echo "Targets: build test clean install release"
