# Bash 3.2 Compatibility Fix - Summary

## Problem
CI was failing on macOS 14 and 15 with "mapfile: command not found"

## Root Cause
- macOS ships with Bash 3.2.57 (from 2007)
- `mapfile` was introduced in Bash 4.0 (2009)
- macOS cannot upgrade due to GPLv3 licensing

## Solution Applied
Replaced all 4 instances of `mapfile` with Bash 3.2-compatible `while read` loops:

```bash
# Instead of:
mapfile -t filtered_formulas < <(macgnu_filter_formulas "${formulas[@]}")

# We now use:
while IFS= read -r formula; do
    filtered_formulas+=("$formula")
done < <(macgnu_filter_formulas "${formulas[@]}")
```

## Files Changed
1. `macgnu` - Fixed 4 occurrences in:
   - `macgnu_install()`
   - `macgnu_uninstall()`
   - `macgnu_info()`
   - `macgnu_status()`
2. `.github/workflows/ci.yml` - Improved Bash version reporting
3. Added documentation:
   - `BASH_COMPATIBILITY.md` - Comprehensive compatibility guide
   - `tests/test_bash32_compat.sh` - Test script for verification

## Testing
```bash
# Test locally with system Bash 3.2
/bin/bash ./macgnu install --dry-run

# Test the compatibility test script
chmod +x tests/test_bash32_compat.sh
./tests/test_bash32_compat.sh

# Run full test suite
./tests/unit_tests.sh
./tests/run_tests.sh
```

## Verification
The script now works on:
- ✅ macOS default Bash 3.2.57
- ✅ Homebrew Bash 5.x
- ✅ Linux Bash 4.x/5.x
- ✅ GitHub Actions macOS runners

## Commit Message
```
fix: replace mapfile with Bash 3.2-compatible while-read loops

- Replace mapfile (Bash 4+) with while-read (Bash 3.2+)
- Fixes CI failures on macOS 14 and 15 runners
- Ensures compatibility with macOS default Bash 3.2.57
- Add comprehensive Bash compatibility documentation
- Improve CI Bash version reporting

Fixes #[issue-number] (if applicable)
```

## Additional Notes
- ShellCheck warns about not using `mapfile`, but we prioritize Bash 3.2 compatibility
- Can silence ShellCheck with `# shellcheck disable=SC2207` if needed
- The `while read` approach is slightly slower but works everywhere
- Performance difference is negligible for our use case (30-40 formulas)
