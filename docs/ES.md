# shae-pascal-student-records (Español)

Un sistema de gestión de registros de estudiantes escrito en Free Pascal
auténtico. Permite agregar estudiantes (id, nombre, nota), listar todos,
buscar por id o nombre, eliminar estudiantes, y guardar/cargar registros en
un archivo de texto.

## Requisitos

- **Free Pascal Compiler (fpc)** — no instalado localmente. Consulte
  `scripts/install.sh`.

## Instalación

```bash
./scripts/install.sh
```

## Uso

```bash
shae-pascal-student-records
# Menú: 1 Agregar, 2 Listar, 3 Buscar por id, 4 Buscar por nombre,
# 5 Eliminar, 6 Guardar, 7 Cargar, 0 Salir
```

## Compilación y pruebas

```bash
make build
make test
make clean
```

## Diseño

Según el manual de campo SHAE: papel `#F2EEE5`, tinta `#191712`, señal óxido
`#B3341B`, JetBrains Mono para código, sin gradientes/vidrio/sombras.
Véase `DESIGN.md`.

## Licencia

MIT. Véase `LICENSE`.
