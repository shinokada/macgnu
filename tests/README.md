# Testing Guide

MacGNU includes a comprehensive test suite to verify all functionality.

## Running Tests

### Full Test Suite

```bash
bash tests/run_tests.sh
```

This runs all tests including:
- Unit tests for internal functions
- Integration tests for commands
- Config file tests
- Flag parsing tests

### Unit Tests Only

```bash
bash tests/unit_tests.sh
```

Runs unit tests for flag parsing and command parsing logic.

## Test Coverage

The test suite covers:

### Unit Tests
- ✓ Dry-run flag parsing
- ✓ Formula filtering
- ✓ macOS check function
- ✓ Config file loading
- ✓ Progress display function

### Integration Tests
- ✓ Help command output
- ✓ Version command
- ✓ Help shows all packages
- ✓ Invalid command handling
- ✓ Dry-run install mode
- ✓ Dry-run uninstall mode
- ✓ Status command (when brew installed)
- ✓ Config file example exists
- ✓ Config file has correct content

## Test Output

Successful tests show checkmarks:

```text
✓ Help command output
✓ Version command
✓ Invalid command handling
✓ Dry-run install mode
```

Failed tests show crosses with details:

```text
✗ Some test name
  Expected: value1
  Actual:   value2
```

## Test Summary

After all tests, you'll see a summary:

```text
================================
Test Summary
================================
Total:  18
Passed: 18
Failed: 0
================================
All tests passed!
```

## Testing with Different Configurations

You can test with a custom config file:

```bash
# Copy test config
cp tests/test.macgnu.conf ~/.macgnu.conf

# Run tests
bash tests/run_tests.sh

# Clean up
rm ~/.macgnu.conf
```

## Requirements

- macOS (tests check for this)
- bash 3.2+ (compatible with macOS default bash)
- Homebrew installed (for some tests)

## Troubleshooting

### Tests fail on non-macOS systems
MacGNU is designed for macOS only. Tests will skip or fail on Linux/Windows.

### Brew-dependent tests skip
Some tests require Homebrew. If brew is not installed, those tests are skipped but others continue.

### Permission denied errors
Make sure test files are executable:

```bash
chmod +x tests/run_tests.sh
chmod +x tests/unit_tests.sh
```

## Contributing Tests

When adding new features, please add corresponding tests:

1. Add unit tests to `tests/unit_tests.sh` for new functions
2. Add integration tests to `tests/run_tests.sh` for new commands
3. Run full test suite to verify everything passes
4. Update this README with new test coverage

## CI/CD Integration

You can integrate tests into CI/CD:

```bash
#!/bin/bash
set -e
bash tests/run_tests.sh
bash tests/unit_tests.sh
echo "All tests passed!"
```
