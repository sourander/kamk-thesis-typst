"""Tests for remove_typst_package.py.

Run with: uv run python -m unittest discover -s scripts/tests
"""

import sys
import unittest
from pathlib import Path
from tempfile import TemporaryDirectory
from unittest.mock import patch

SCRIPTS_DIR = Path(__file__).resolve().parent.parent
if str(SCRIPTS_DIR) not in sys.path:
    sys.path.insert(0, str(SCRIPTS_DIR))

import remove_typst_package  # noqa: E402
import typst_package_config  # noqa: E402


class MainTests(unittest.TestCase):
    def test_removes_existing_package_directory(self):
        with TemporaryDirectory() as tmp:
            target = Path(tmp)
            pkg_dir = target / "kamk-thesis" / "0.1.0"
            pkg_dir.mkdir(parents=True)
            (pkg_dir / "lib.typ").write_text("content")

            with (
                patch.object(typst_package_config, "package_prefix", return_value="kamk-thesis"),
                patch.object(typst_package_config, "version", return_value="0.1.0"),
            ):
                ret = remove_typst_package.main([str(target)])

            self.assertEqual(ret, 0)
            self.assertFalse(pkg_dir.exists())

    def test_missing_package_is_reported_without_error(self):
        with TemporaryDirectory() as tmp:
            target = Path(tmp)

            with (
                patch.object(typst_package_config, "package_prefix", return_value="kamk-thesis"),
                patch.object(typst_package_config, "version", return_value="0.1.0"),
            ):
                ret = remove_typst_package.main([str(target)])

            self.assertEqual(ret, 0)
            self.assertFalse((target / "kamk-thesis").exists())

    def test_missing_target_argument_returns_error(self):
        self.assertEqual(remove_typst_package.main([]), 1)

    def test_help_argument_returns_success(self):
        self.assertEqual(remove_typst_package.main(["help"]), 0)


if __name__ == "__main__":
    unittest.main()
