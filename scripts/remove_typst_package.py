# /// script
# requires-python = ">=3.13"
# dependencies = []
# ///
"""Remove an installed package directory.

Mirrors scripts/uninstall. Usage:

    uv run scripts/remove_typst_package.py <target>

<target> may be @local, @preview, or a directory.
"""

import shutil
import sys

import typst_package_config

HELP = """uninstall TARGET

Removes the installed '<name>/<version>' directory at TARGET.
If TARGET is set to @local or @preview, the local Typst package
directory will be used.
The name and version are read from 'typst.toml' in the project root.

Local package prefix: {local_prefix}
Local preview package prefix: {preview_prefix}"""


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
    print(f"Package to uninstall: {pkg_target}")

    if not (pkg_target.exists() or pkg_target.is_symlink()):
        print("Package was not found.")
        return 0

    try:
        if pkg_target.is_dir() and not pkg_target.is_symlink():
            shutil.rmtree(pkg_target)
        else:
            pkg_target.unlink()
    except OSError as e:
        print(f"Removal failed: {e}")
        return 1

    print("Successfully removed.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
