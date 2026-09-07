# Variables
ENTRY_FILE := "template/thesis.typ"
OUT_DIR := "build"
OUT_FILE := OUT_DIR + "/thesis.pdf"
THUMBNAIL_FILE := "thumbnail.png"

# Default recipe: build the PDF
default: build

# Compile the Typst project to the build directory
build:
    @mkdir -p {{OUT_DIR}}
    typst compile --root . {{ENTRY_FILE}} {{OUT_FILE}} # this is only used for Theseus submission version: --pdf-standard 'a-1a'
    @echo "Build successful: {{OUT_FILE}}"

# Watch for file changes and live-compile
watch:
    @mkdir -p {{OUT_DIR}}
    typst watch --root . {{ENTRY_FILE}} {{OUT_FILE}}

# Remove the build directory
clean:
    rm -rf {{OUT_DIR}}

# Generate the template thumbnail required for package submission
thumbnail:
    typst compile --root . -f png --pages 1 --ppi 150 {{ENTRY_FILE}} {{THUMBNAIL_FILE}}
    @echo "Thumbnail generated: {{THUMBNAIL_FILE}}"
    @echo "Check that the file is < 3 MB (Typst package submission limit)"
    @if [ $(stat -f%z {{THUMBNAIL_FILE}}) -lt 3145728 ]; then \
        echo "Thumbnail is within the size limit."; \
    else \
        echo "Thumbnail is too large!"; \
        exit 1; \
    fi
    @echo "Thumbnail generated: {{THUMBNAIL_FILE}}"

# As of now, this works only on macOS that has Skim installed.
skim:
    open -a Skim build/thesis.pdf
