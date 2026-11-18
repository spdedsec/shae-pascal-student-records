#!/usr/bin/env bash
#
# scripts/install.sh - install shae-pascal-student-records
#
# Installs the Free Pascal Compiler (fpc), builds the student record
# system from src/student_records.pas, and installs the binary.
#
# Usage:
#   ./scripts/install.sh
#   PREFIX=~/.local/bin ./scripts/install.sh
#
set -euo pipefail

PROJECT="shae-pascal-student-records"
BIN="student_records"
PREFIX="${PREFIX:-/usr/local/bin}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

have_cmd() { command -v "$1" >/dev/null 2>&1; }

# -----------------------------------------------------------------------------
# 1. Ensure fpc is available
# -----------------------------------------------------------------------------
if ! have_cmd fpc; then
  echo "[install] fpc not found; attempting to install via apt (Debian/Ubuntu)"
  if have_cmd apt-get; then
    sudo apt-get update -y
    sudo apt-get install -y fpc
  elif have_cmd apk; then
    sudo apk add fpc
  else
    echo "[install] error: no supported package manager found" >&2
    echo "[install] install Free Pascal manually (https://www.freepascal.org/)" >&2
    exit 1
  fi
fi

have_cmd fpc || { echo "[install] error: fpc still unavailable" >&2; exit 1; }
echo "[install] fpc: $(fpc -iV)"

# -----------------------------------------------------------------------------
# 2. Build
# -----------------------------------------------------------------------------
echo "[install] building $(PROJECT)"
make -C "$ROOT_DIR" build

# -----------------------------------------------------------------------------
# 3. Install binary
# -----------------------------------------------------------------------------
echo "[install] installing $(BIN) to $(PREFIX)"
install -d "$PREFIX"
install -m 0755 "$ROOT_DIR/$BIN" "$PREFIX/$(PROJECT)"
echo "[install] done: $(PREFIX)/$(PROJECT)"
echo "[install] usage: $(PREFIX)/$(PROJECT)"
