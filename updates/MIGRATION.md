# Migration Guide: v0.2.4 → v0.3.0

## Overview

MacGNU v0.3.0 introduces several new features while maintaining full backward compatibility. No changes are required to use the updated version, but new features are available to use.

## What Changed

### Commands
- **New**: `macgnu status` - Check installation status
- **New**: `macgnu install <package>` - Install specific package
- **Enhanced**: All commands now support `--dry-run` and `--force` flags
- **Enhanced**: Better help output

### Configuration
- **New**: `~/.macgnu.conf` - Customize package selection
- **New**: `MACGNU_SKIP_PACKAGES` variable in config file
- **Optional**: Config is not required (backward compatible)

### Behavior
- Better progress feedback with progress bars
- Improved error handling
- More robust flag parsing
- Better command validation

## Upgrading

### Step 1: Update the Script

Pull the latest version:

```bash
cd macgnu
git pull origin main
```

Or if using Awesome:

```bash
awesome update shinokada/macgnu
```

### Step 2: No Changes Required

Your existing setup continues to work:
- `~/.macgnu` file still works
- Existing shell configuration still works
- No configuration needed

### Step 3: (Optional) Create Config File

To use new configuration features:

```bash
cp .macgnu.conf.example ~/.macgnu.conf
```

Edit `MACGNU_SKIP_PACKAGES` if you want to skip certain packages.

### Step 4: Run Tests (Optional)

Verify everything works:

```bash
bash tests/run_tests.sh
```

## Feature Migration

### If You Manually Skip Packages

Old way:
```bash
# Edit macgnu script to comment out packages
# Not maintainable with updates
```

New way:
```bash
# Create ~/.macgnu.conf
MACGNU_SKIP_PACKAGES="package1 package2"

# Or use environment variable
export MACGNU_SKIP_PACKAGES="package1 package2"
macgnu install
```

### If You Want to Try Before Installing

Old way:
```bash
# No preview functionality
# Had to reinstall if something went wrong
```

New way:
```bash
# Preview first
macgnu install --dry-run

# Then install
macgnu install
```

### If You Want to Check Status

Old way:
```bash
# Had to manually check each package
brew ls --versions package-name
```

New way:
```bash
# Check all at once
macgnu status
```

### If You Want to Reinstall One Package

Old way:
```bash
# Had to reinstall everything
macgnu install
```

New way:
```bash
# Just upgrade one package
macgnu install bash --force
```

## Configuration Migration

### From Environment Variables

If you were using environment variables:

```bash
export MACGNU_SKIP_PACKAGES="bash emacs"
macgnu install
```

This still works! But you can now save it:

```bash
# Create persistent config
cat > ~/.macgnu.conf << 'EOF'
MACGNU_SKIP_PACKAGES="bash emacs"
EOF

# Environment variable still works and overrides config
export MACGNU_SKIP_PACKAGES="bash emacs nano"
macgnu install  # Uses override from environment
```

### From Script Modifications

If you modified the macgnu script:

```bash
# Old: edited macgnu_formulas array
# New: use config file instead
```

Move your customizations to `~/.macgnu.conf`:

```bash
# Instead of editing macgnu script:
# macgnu_formulas=(
#   ...
#   # commented out bash
#   # "bash"
#   ...
# )

# Use config file:
MACGNU_SKIP_PACKAGES="bash"
```

Benefits:
- Config survives script updates
- Easier to maintain
- Better for teams/sharing setups

## Command Changes

### install

```bash
# Old usage (still works)
macgnu install

# New usage
macgnu install --dry-run              # Preview
macgnu install --force                # Force reinstall
macgnu install bash                   # Install one package
macgnu install bash --force --dry-run # Combine flags
```

### uninstall

```bash
# Old usage (still works)
macgnu uninstall

# New usage
macgnu uninstall --dry-run  # Preview uninstall
macgnu uninstall --force    # Force with dependencies
```

### New Commands

```bash
macgnu status     # Check what's installed
macgnu install <pkg>  # Install specific package
```

### Improved Help

```bash
macgnu -h   # More detailed, shows new commands
macgnu -v   # Same version output
```

## Troubleshooting Migration

### "Unknown option: --dry-run"

Make sure you're using the new script:

```bash
# Check version
macgnu -v
# Should be 0.3.0 or higher

# If not, update:
git pull origin main
```

### Config File Not Being Read

Verify file exists and is readable:

```bash
cat ~/.macgnu.conf
# Should show your MACGNU_SKIP_PACKAGES

# Check format:
grep MACGNU_SKIP_PACKAGES ~/.macgnu.conf
```

### Commands Behave Differently

Check if you're using the updated script:

```bash
which macgnu
file $(which macgnu)
# Should be the updated version
```

Update your PATH or reinstall if needed:

```bash
macgnu install
```

## Rollback (If Needed)

To go back to v0.2.4:

```bash
git log --oneline
git checkout <commit-hash-for-0.2.4>
```

Or use the release tag:

```bash
git checkout v0.2.4
```

## Getting Help

- See [docs/FEATURES.md](../docs/FEATURES.md) for feature details
- See [docs/CONFIGURATION.md](../docs/CONFIGURATION.md) for config guide
- Run `macgnu -h` for command help
- Check [tests/README.md](../tests/README.md) for testing info

## Summary

| Aspect                 | v0.2.4 | v0.3.0   |
| ---------------------- | ------ | -------- |
| Config File            | ❌      | ✅        |
| Status Check           | ❌      | ✅        |
| Single Package Install | ❌      | ✅        |
| Dry-Run Mode           | ❌      | ✅        |
| Force Upgrade          | ❌      | ✅        |
| Progress Feedback      | Basic  | Enhanced |
| Test Suite             | ❌      | ✅        |
| Backward Compatible    | -      | ✅ 100%   |

## Next Steps

1. ✅ Update the script
2. ✅ (Optional) Create config file
3. ✅ (Optional) Run tests
4. ✅ Use new features!

---

**No urgent action required.** Enjoy the new features when ready!
