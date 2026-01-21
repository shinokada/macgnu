# Bash 3.2 Compatibility Fix

## Issue
CI tests were failing on macOS 14 and 15 with:
```
/Users/runner/work/macgnu/macgnu/macgnu: line 139: mapfile: command not found
```

## Root Cause
- `mapfile` (also called `readarray`) was introduced in **Bash 4.0** (2009)
- macOS ships with **Bash 3.2.57** (from 2007) due to licensing reasons
- macOS cannot upgrade to Bash 4+ because it's licensed under GPLv3
- This is why macOS's default Bash is so old

## Solution
Replace `mapfile` with a `while read` loop, which works in Bash 3.2+:

### Before (Bash 4+ only):
```bash
local -a filtered_formulas
mapfile -t filtered_formulas < <(macgnu_filter_formulas "${formulas[@]}")
formulas=("${filtered_formulas[@]}")
```

### After (Bash 3.2+ compatible):
```bash
local -a filtered_formulas
while IFS= read -r formula; do
    filtered_formulas+=("$formula")
done < <(macgnu_filter_formulas "${formulas[@]}")
formulas=("${filtered_formulas[@]}")
```

## Why This Matters
1. **macOS default Bash** - All macOS users have Bash 3.2 by default
2. **GitHub Actions runners** - Use macOS default Bash (3.2)
3. **Wide compatibility** - Script works without requiring users to install newer Bash

## Bash Version Check
You can check your Bash version:
```bash
bash --version
# macOS default: GNU bash, version 3.2.57(1)-release
# Linux typical: GNU bash, version 5.x
```

## Alternative Solutions (Not Used)
1. **Require Bash 4+**: Would break for all macOS users without Homebrew bash
2. **Add shebang `#!/usr/bin/env bash`**: Still uses system default (3.2 on macOS)
3. **Use `/usr/local/bin/bash`**: Assumes user installed Homebrew bash

## Testing
The script now works on:
- ✅ macOS with default Bash 3.2
- ✅ macOS with Homebrew Bash 5.x
- ✅ Linux with Bash 4.x/5.x
- ✅ GitHub Actions (macOS runners)

## Key Bash 3.2 Limitations to Avoid
- `mapfile` / `readarray` - Use `while read` instead
- `&>>` redirect - Use `>> file 2>&1` instead  
- `${var,,}` lowercase - Use `tr '[:upper:]' '[:lower:]'` instead
- `${var^^}` uppercase - Use `tr '[:lower:]' '[:upper:]'` instead
- Associative arrays (`declare -A`) - Use indexed arrays instead

## References
- [Why macOS uses Bash 3.2](https://apple.stackexchange.com/questions/193411/why-does-macos-use-bash-3-2)
- [Bash 4 changelog](https://git.savannah.gnu.org/cgit/bash.git/tree/NEWS?h=bash-4.0)
- [ShellCheck SC2207](https://www.shellcheck.net/wiki/SC2207) - Recommends `mapfile`, but we can't use it for Bash 3.2 compatibility
