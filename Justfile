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

# Build the testes/end-to-end-fi/test.typ to build/integration.pdf
integration:
    mkdir -p {{OUT_DIR}}
    typst compile --root . --pdf-standard ua-1 tests/end-to-end-fi/test.typ {{OUT_DIR}}/integration.pdf
    @echo "Integration test build successful: {{OUT_DIR}}/integration.pdf"

# Generate the template thumbnail required for package submission
thumbnail: install-preview
    typst compile --root . -f png --pages 1 --ppi 150 {{ENTRY_FILE}} {{THUMBNAIL_FILE}}

# As of now, this works only on macOS that has Skim installed
skim:
    open -a Skim {{OUT_FILE}}

# Run test suite using Tytanic
test *args:
    tt run --use-system-fonts --no-fail-fast {{args}}

# Run the Python unit tests for the packaging scripts
test-scripts:
    uv run python -m unittest discover -s scripts/tests

# Bump the package version in typst.toml, template/thesis.typ and README.md.
bump version: && thumbnail
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

# Run docs locally for development.
docs:
    uvx zensical serve