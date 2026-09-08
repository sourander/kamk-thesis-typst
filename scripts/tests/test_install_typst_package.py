"""Tests for install_typst_package.py.

Run with: python3 -m unittest discover -s scripts/tests
"""

import sys
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

SCRIPTS_DIR = Path(__file__).resolve().parent.parent
if str(SCRIPTS_DIR) not in sys.path:
    sys.path.insert(0, str(SCRIPTS_DIR))

import install_typst_package  # noqa: E402
import typst_package_config   # noqa: E402


class IsIncludedTests(unittest.TestCase):
    """Test file inclusion rules, including exclusions, re-inclusions, and last-match precedence."""
    def test_default_is_included(self):
        self.assertTrue(install_typst_package.is_included("src/lib.typ", []))

    def test_plain_rule_excludes(self):
        rules = [(False, "build")]
        self.assertFalse(install_typst_package.is_included("build", rules))

    def test_negated_rule_reincludes(self):
        rules = [(False, "*.typ"), (True, "keep.typ")]
        self.assertFalse(install_typst_package.is_included("skip.typ", rules))
        self.assertTrue(install_typst_package.is_included("keep.typ", rules))

    def test_last_matching_rule_wins(self):
        rules = [(True, "*"), (False, "*")]
        self.assertFalse(install_typst_package.is_included("anything", rules))


class LoadIgnoreRulesTests(unittest.TestCase):
    """Test loading ignore rules, including comments, blank lines, negations, and missing files."""
    def test_parses_lines_skipping_blanks_and_comments(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / ".typstignore").write_text("# comment\n\nbuild\n!build/keep.txt\n")
            rules = install_typst_package.load_ignore_rules(root)
        self.assertEqual(rules, [(False, "build"), (True, "build/keep.txt")])

    def test_missing_ignore_file_raises(self):
        with tempfile.TemporaryDirectory() as tmp:
            with self.assertRaises(FileNotFoundError):
                install_typst_package.load_ignore_rules(Path(tmp))


class EnumerateFilesTests(unittest.TestCase):
    """Test file enumeration excludes ignored paths while keeping included files."""
    def test_excludes_ignored_directory_and_keeps_the_rest(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "src").mkdir()
            (root / "src" / "lib.typ").write_text("content")
            (root / "build").mkdir()
            (root / "build" / "thesis.pdf").write_text("pdf")

            files = install_typst_package.enumerate_files(root, [(False, "build")])

        self.assertEqual(files, [root / "src" / "lib.typ"])


class MainTests(unittest.TestCase):
    def _make_fake_project(self, root: Path) -> None:
        (root / ".typstignore").write_text("build\n")
        (root / "src").mkdir()
        (root / "src" / "lib.typ").write_text("content")
        (root / "build").mkdir()
        (root / "build" / "thesis.pdf").write_text("pdf")

    def test_packages_included_files_and_skips_ignored_ones(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / "project"
            root.mkdir()
            self._make_fake_project(root)
            target = Path(tmp) / "target"

            with (
                patch.object(typst_package_config, "ROOT", root),
                patch.object(typst_package_config, "package_prefix", return_value="kamk-thesis"),
                patch.object(typst_package_config, "version", return_value="0.1.0"),
            ):
                ret = install_typst_package.main([str(target)])

            pkg_dir = target / "kamk-thesis" / "0.1.0"
            self.assertEqual(ret, 0)
            self.assertTrue((pkg_dir / "src" / "lib.typ").is_file())
            self.assertFalse((pkg_dir / "build").exists())

    def test_rerunning_overwrites_previous_package(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / "project"
            root.mkdir()
            self._make_fake_project(root)
            target = Path(tmp) / "target"

            with (
                patch.object(typst_package_config, "ROOT", root),
                patch.object(typst_package_config, "package_prefix", return_value="kamk-thesis"),
                patch.object(typst_package_config, "version", return_value="0.1.0"),
            ):
                install_typst_package.main([str(target)])
                (root / "src" / "new.typ").write_text("new")
                ret = install_typst_package.main([str(target)])

            pkg_dir = target / "kamk-thesis" / "0.1.0"
            self.assertEqual(ret, 0)
            self.assertTrue((pkg_dir / "src" / "new.typ").is_file())

    def test_missing_target_argument_returns_error(self):
        self.assertEqual(install_typst_package.main([]), 1)

    def test_help_argument_returns_success(self):
        self.assertEqual(install_typst_package.main(["help"]), 0)


if __name__ == "__main__":
    unittest.main()
