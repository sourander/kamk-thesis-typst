# /// script
# requires-python = ">=3.13"
# dependencies = []
# ///
"""Shared configuration for the kamk-thesis packaging scripts.

Imported by install_typst_package.py and remove_typst_package.py. Run directly to print the
resolved configuration, optionally resolving a package target:

    uv run scripts/typst_package_config.py [target]
"""

import os
import sys
import tomllib
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
MANIFEST = ROOT / "typst.toml"


def data_dir() -> Path:
    """The user data directory for this platform."""
    match sys.platform:
        case p if p.startswith("linux"):
            return Path(os.environ.get("XDG_DATA_HOME") or Path.home() / ".local" / "share")
        case "darwin":
            return Path.home() / "Library" / "Application Support"
        case "win32":
            return Path(os.environ.get("APPDATA") or Path.home() / "AppData" / "Roaming")
        case _:
            raise RuntimeError(f"Unsupported platform: {sys.platform}")


def manifest() -> dict[str, object]:
    """The [package] table of typst.toml."""
    with MANIFEST.open("rb") as f:
        return tomllib.load(f)["package"]


def package_prefix() -> str:
    """The package name from typst.toml."""
    return str(manifest()["name"])


def version() -> str:
    """The package version from typst.toml."""
    return str(manifest()["version"])


def package_id() -> str:
    """The '<name>-<version>' identifier used for release artifacts."""
    return f"{package_prefix()}-{version()}"


def write_github_output(ref_name: str) -> None:
    """Write name/version/id to $GITHUB_OUTPUT and verify ref_name matches 'v<version>'.

    Exits with an error if the GITHUB_OUTPUT env var is unset, or if ref_name doesn't match.
    """
    output_path = os.environ.get("GITHUB_OUTPUT")
    if not output_path:
        raise SystemExit("write_github_output: GITHUB_OUTPUT is not set")

    name, pkg_version = package_prefix(), version()
    with open(output_path, "a") as output:
        print(f"name={name}", file=output)
        print(f"version={pkg_version}", file=output)
        print(f"id={name}-{pkg_version}", file=output)

    expected_tag = f"v{pkg_version}"
    if ref_name != expected_tag:
        raise SystemExit(f"Tag {ref_name} does not match {expected_tag}")


def resolve_target(target: str) -> Path:
    """Resolve a package target (@local, @preview, or a directory)."""
    match target:
        case "@local":
            return data_dir() / "typst" / "packages" / "local"
        case "@preview":
            return data_dir() / "typst" / "packages" / "preview"
        case _:
            return Path(target).expanduser()


def main(argv: list[str]) -> int:
    if argv and argv[0] in ("help", "-h", "--help"):
        print("usage: uv run scripts/typst_package_config.py [target]")
        print("       uv run scripts/typst_package_config.py github-output")
        print("")
        print("Prints the resolved packaging configuration. If TARGET is given")
        print("(@local, @preview, or a directory), the resolved target is shown too.")
        print("")
        print("'github-output' writes name/version/id to $GITHUB_OUTPUT and checks")
        print("that the $GITHUB_REF_NAME env var matches the 'v<version>' tag.")
        return 0
    if argv and argv[0] == "github-output":
        write_github_output(os.environ.get("GITHUB_REF_NAME", ""))
        return 0
    print(f"root: {ROOT}")
    print(f"data_dir: {data_dir()}")
    print(f"package_prefix: {package_prefix()}")
    print(f"version: {version()}")
    if argv:
        print(f"target: {resolve_target(argv[0])}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
