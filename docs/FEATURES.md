# New Features

## Version 0.3.0 Features

### 1. Configuration File Support

Skip packages you don't want to install by creating `~/.macgnu.conf`:

```bash
MACGNU_SKIP_PACKAGES="bash emacs nano"
```

See [CONFIGURATION.md](CONFIGURATION.md) for detailed setup instructions.

### 2. Status Command

Check which packages are installed and which are missing:

```bash
$ macgnu status
=== MacGNU Installation Status ===

✓ tree (1.8.0)
✓ watch (4.2.14)
✓ wget (1.21.1)
✗ wdiff
✓ autoconf (2.71)
...

Installed: 32 / 36
Not installed: 4
```

### 3. Selective Package Installation

Install a single package instead of all packages:

```bash
# Install just bash
macgnu install bash

# Install with force upgrade
macgnu install bash --force
```

### 4. Dry-Run Mode

Preview what will be installed/uninstalled without making changes:

```bash
# See what would be installed
macgnu install --dry-run

# See what would be uninstalled
macgnu uninstall --dry-run
```

### 5. Force Reinstall/Upgrade

Use `--force` flag to reinstall or upgrade all packages:

```bash
# Force upgrade all packages
macgnu install --force

# Install with dry-run and force
macgnu install --force --dry-run
```

### 6. Better Progress Feedback

Installation now shows a progress bar:

```
Installing 36 GNU packages...
Progress: [#########################                         ] 50%
✓ Installation complete
```

### 7. Improved Help and Version

More detailed help output with all new commands:

```bash
$ macgnu -h
Description: Macgnu transforms the macOS CLI into 
GNU/Linux by installing GNU programs.

Usage and options: macgnu [command | -h | -v] [flags]

Commands:
    install [pkg]      installs GNU/Linux utilities (or specific pkg)
    uninstall          uninstalls GNU/Linux utilities
    status             shows installation status of all packages
    info               shows info on GNU/Linux utilities
    -h, --help         shows this help message and exit
    -v, --version      shows the version

Flags:
    --dry-run          preview changes without making them
    --force            force reinstall/upgrade packages
```

## Usage Examples

### Install all packages (with config)
```bash
macgnu install
```

### Preview installation with config
```bash
macgnu install --dry-run
```

### Install just one package
```bash
macgnu install grep
```

### Check installation status
```bash
macgnu status
```

### Force upgrade all packages
```bash
macgnu install --force
```

### Uninstall with preview
```bash
macgnu uninstall --dry-run
```

## Backward Compatibility

All new features are fully backward compatible:
- Existing configs work without changes
- Commands still work as before
- New flags are optional

## Testing

Run the test suite to verify functionality:

```bash
bash tests/run_tests.sh
bash tests/unit_tests.sh
```

See [../tests/README.md](../tests/README.md) for more details.
