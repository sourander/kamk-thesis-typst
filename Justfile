root := justfile_directory()

export TYPST_ROOT := root

# Variables
ENTRY_FILE := "template/thesis.typ"
OUT_DIR := "build"
OUT_FILE := OUT_DIR + "/thesis.pdf"
THUMBNAIL_FILE := "thumbnail.png"

# Default recipe: list all available recipes
default:
    @just --list

# Build the thesis PDF from the Typst source file to build/thesis.pdf. Useful for developing.
build:
    just install-preview
    mkdir -p {{OUT_DIR}}
    typst compile --root . {{ENTRY_FILE}} {{OUT_FILE}}
    just uninstall-preview
    @echo "Build successful: {{OUT_FILE}}"

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

# As of now, this works only on macOS that has Skim installed
skim:
    open -a Skim {{OUT_FILE}}

# Run test suite using Tytanic
test *args:
    tt run --use-system-fonts --no-fail-fast {{args}}

# Run the Python unit tests for the packaging scripts
test-scripts:
    uv run python -m unittest discover -s scripts/tests

# Update test cases using Tytanic
update *args:
    tt update {{args}}

# Bump the package version in typst.toml, template/thesis.typ and README.md.
bump version: (thumbnail)
    # Require the supplied version to match X.Y.Z exactly, using numeric components.
    @perl -e '$v = "{{version}}"; die "bump: version must be X.Y.Z, got \"{{version}}\"\n" unless $v =~ /\A[0-9]+\.[0-9]+\.[0-9]+\z/;'

    # Look for a complete TOML line such as: version = "0.1.0"
    @perl -pi -e 's/^version = "[0-9]+\.[0-9]+\.[0-9]+"$/version = "{{version}}"/' typst.toml

    # Look for a Typst package reference such as: kamk-thesis:0.1.0
    @perl -pi -e 's/(kamk-thesis:)[0-9]+\.[0-9]+\.[0-9]+/${1}{{version}}/' template/thesis.typ

    # Look for an HTML-escaped version label such as: &gt;Version 0.1.0
    @perl -pi -e 's/(&gt;Version )[0-9]+\.[0-9]+\.[0-9]+/${1}{{version}}/' README.md

    # Look for a Typst package reference such as: kamk-thesis:0.1.0
    @perl -pi -e 's/(kamk-thesis:)[0-9]+\.[0-9]+\.[0-9]+/${1}{{version}}/' README.md

    # Display the resulting changes.
    @git diff -- typst.toml template/thesis.typ README.md

# Print the resolved packaging configuration. Call as `just setup '@preview'`
setup target:
    uv run scripts/typst_package_config.py {{target}}

# Package the library into the specified destination folder
package target:
    uv run scripts/install_typst_package.py "{{target}}"

# Install the library with the "@local" prefix
install: (package "@local")

# Install the library with the "@preview" prefix for pre-release testing
install-preview: (package "@preview")

[private]
remove target:
    uv run scripts/remove_typst_package.py "{{target}}"

# Uninstall the library from the "@local" prefix
uninstall: (remove "@local")

# Uninstall the library from the "@preview" prefix
uninstall-preview: (remove "@preview")
