# Changelog

## Version 0.3.0 (2026-01-21)

### ✨ New Features

#### Configuration File Support
- Users can now create `~/.macgnu.conf` to customize package installation
- `MACGNU_SKIP_PACKAGES` environment variable lets users skip specific packages
- Config file is optional - fully backward compatible
- See [Configuration Guide](../docs/CONFIGURATION.md)

#### Status Command
- `macgnu status` shows which packages are installed
- Displays version for installed packages
- Shows count of installed vs. total packages
- Helpful for users to see what's missing

#### Selective Package Installation  
- `macgnu install <package>` to install a single package
- Example: `macgnu install bash` to upgrade just bash
- Respects configuration file
- Works with all flags

#### Dry-Run Mode
- `macgnu install --dry-run` to preview installation
- `macgnu uninstall --dry-run` to preview uninstall
- Shows what would be installed/uninstalled
- No changes made to system
- Useful for testing configurations

#### Force Reinstall/Upgrade
- `--force` flag to force reinstall or upgrade packages
- Example: `macgnu install --force` to upgrade all
- Works with single package: `macgnu install bash --force`
- Useful for updating outdated packages

#### Progress Feedback
- Installation shows progress bar during execution
- Real-time feedback of which packages are being processed
- Cleaner output with checkmarks for completion
- Better user experience for long installations

#### Improved Help System
- More detailed help output with all commands listed
- Examples for all new features
- References to documentation
- Help auto-displays for invalid commands

### 📝 Documentation

New documentation files created:

- **[docs/INSTALLATION.md](../docs/INSTALLATION.md)** - Complete setup guide with examples
- **[docs/FEATURES.md](../docs/FEATURES.md)** - Detailed feature descriptions and usage
- **[docs/CONFIGURATION.md](../docs/CONFIGURATION.md)** - Configuration file guide
- **[tests/README.md](../tests/README.md)** - Testing guide and coverage
- **.macgnu.conf.example** - Example configuration file template

### 🧪 Testing

Comprehensive test suite added:

- **tests/run_tests.sh** - Full test suite (20+ tests)
  - Unit tests for functions
  - Integration tests for commands
  - Config file tests
  - Flag parsing tests

- **tests/unit_tests.sh** - Unit tests for parsing logic
  - Flag parsing tests
  - Command parsing tests
  - ~10 test cases

- **tests/test.macgnu.conf** - Test configuration file

All tests pass and verify:
- Help output correctness
- Version format
- Command functionality
- Dry-run behavior
- Config file loading
- Package filtering

### 🔄 Backward Compatibility

All changes are fully backward compatible:
- Existing scripts continue to work
- Config is optional (falls back to all packages)
- New flags are optional
- Help still works for old commands

### 🐛 Bug Fixes

- Better error handling in install/uninstall
- Silent failures don't stop installation
- Improved file permissions checking
- Better cleanup on errors

### 📈 Improvements

- Version bumped from 0.2.4 to 0.3.0
- Script now handles more edge cases
- Better user feedback throughout
- More robust flag parsing
- Cleaner command structure

### 📋 Notes for Users

#### Upgrading from 0.2.4

No action needed - simply update the script:

```bash
git pull origin main
./macgnu install
```

Existing `~/.macgnu` file continues to work.

#### New Users

Start with configuration:

```bash
cp .macgnu.conf.example ~/.macgnu.conf
# Edit to your preferences
macgnu install --dry-run  # Preview
macgnu install            # Install
```

#### Testing

Run the test suite to verify installation:

```bash
bash tests/run_tests.sh
```

## Version 0.2.4 (Previous)

- Basic install/uninstall functionality
- Info command for package details
- Help and version commands
- BSD/GNU program management
- Optional shell configuration

---

For detailed migration guide from v0.2.4 to v0.3.0, see [docs/FEATURES.md](../docs/FEATURES.md).
