# Variables
ENTRY_FILE := "template/thesis.typ"
OUT_DIR := "build"
OUT_FILE := OUT_DIR + "/thesis.pdf"

# Default recipe: build the PDF
default: build

# Compile the Typst project to the build directory
build:
    @mkdir -p {{OUT_DIR}}
    typst compile --root . {{ENTRY_FILE}} {{OUT_FILE}} --pdf-standard 'a-1a'
    @echo "Build successful: {{OUT_FILE}}"

# Watch for file changes and live-compile
watch:
    @mkdir -p {{OUT_DIR}}
    typst watch --root . {{ENTRY_FILE}} {{OUT_FILE}}

# Remove the build directory
clean:
    rm -rf {{OUT_DIR}}

# As of now, this works only on macOS that has Skim installed.
skim:
    open -a Skim build/thesis.pdf
