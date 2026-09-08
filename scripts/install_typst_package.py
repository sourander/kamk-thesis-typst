# /// script
# requires-python = ">=3.13"
# dependencies = []
# ///
"""Package the thesis template into a Typst package directory.

Mirrors scripts/package. Usage:

    uv run scripts/install_typst_package.py <target>

<target> may be @local, @preview, or a directory.
"""

import fnmatch
import shutil
import sys
import tempfile
from pathlib import Path

import typst_package_config

HELP = """package TARGET

Packages all relevant files into a directory named '<name>/<version>'
at TARGET. If TARGET is set to @local or @preview, the local Typst package
directory will be used so that the package gets installed for local use.
The name and version are read from 'typst.toml' in the project root.

Local package prefix: {local_prefix}
Local preview package prefix: {preview_prefix}"""


def load_ignore_rules(root: Path) -> list[tuple[bool, str]]:
    """Read .typstignore as (negated, pattern) rules, in file order."""
    rules: list[tuple[bool, str]] = []
    ignore_file = root / ".typstignore"
    if not ignore_file.is_file():
        raise FileNotFoundError(f"Missing ignore file: {ignore_file}")
    for line in ignore_file.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        negated = line.startswith("!")
        if negated:
            line = line[1:]
        rules.append((negated, line))
    return rules


def is_included(rel: str, rules: list[tuple[bool, str]]) -> bool:
    """Last matching rule wins; `*` matches across path separators."""
    included = True
    for negated, pattern in rules:
        if fnmatch.fnmatchcase(rel, pattern):
            # a plain rule excludes (included=False), a "!" rule re-includes
            included = negated
    return included


def enumerate_files(root: Path, rules: list[tuple[bool, str]]) -> list[Path]:
    """All files under root not excluded by the ignore rules."""
    files: list[Path] = []

    def walk(dirpath: Path) -> None:
        for entry in sorted(dirpath.iterdir()):
            if entry.name in (".git", ".typstignore"):
                continue
            rel = entry.relative_to(root).as_posix()
            if not is_included(rel, rules):
                continue
            if entry.is_dir():
                walk(entry)
            else:
                files.append(entry)

    walk(root)
    return files


def main(argv: list[str]) -> int:
    if not argv or argv[0] in ("help", "-h", "--help"):
        print(
            HELP.format(
                local_prefix=typst_package_config.data_dir() / "typst" / "packages" / "local",
                preview_prefix=typst_package_config.data_dir() / "typst" / "packages" / "preview",
            )
        )
        return 0 if argv else 1

    target = typst_package_config.resolve_target(argv[0])
    print(f"Install dir: {target}")
    pkg_target = target / typst_package_config.package_prefix() / typst_package_config.version()

    rules = load_ignore_rules(typst_package_config.ROOT)
    files = enumerate_files(typst_package_config.ROOT, rules)

    with tempfile.TemporaryDirectory() as tmp:
        tmp_root = Path(tmp)
        for src in files:
            rel = src.relative_to(typst_package_config.ROOT)
            dst = tmp_root / rel
            dst.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(src, dst)

        print(f"Packaged to: {pkg_target}")
        if pkg_target.exists() or pkg_target.is_symlink():
            print("Overwriting existing version.")
            if pkg_target.is_dir() and not pkg_target.is_symlink():
                shutil.rmtree(pkg_target)
            else:
                pkg_target.unlink()

        pkg_target.mkdir(parents=True)
        for entry in sorted(tmp_root.iterdir()):
            shutil.move(str(entry), str(pkg_target / entry.name))
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
