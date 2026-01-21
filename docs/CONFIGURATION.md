# Configuration Guide

## Overview

MacGNU now supports customizable package selection through a configuration file. This allows you to skip packages you don't want to install while still benefiting from the rest of the GNU suite.

## Setup

### Creating Your Config File

1. Create a file at `~/.macgnu.conf`:

```bash
touch ~/.macgnu.conf
```

2. Add your configuration. The config file uses simple bash variable syntax:

```bash
# Space-separated list of packages to skip
MACGNU_SKIP_PACKAGES="bash emacs nano"
```

### Config File Location

MacGNU looks for the config file at: `~/.macgnu.conf`

You can also copy from the example:

```bash
cp .macgnu.conf.example ~/.macgnu.conf
```

Then edit it to your preferences.

## Configuration Options

### MACGNU_SKIP_PACKAGES

Space-separated list of packages to skip during installation.

#### Examples

Skip nothing (install all packages):
```bash
MACGNU_SKIP_PACKAGES=""
```

Skip specific packages:
```bash
MACGNU_SKIP_PACKAGES="bash emacs nano"
```

Skip all gnu-prefixed packages:
```bash
MACGNU_SKIP_PACKAGES="gnu-indent gnu-sed gnu-tar gnu-which"
```

Skip packages you've already installed elsewhere:
```bash
MACGNU_SKIP_PACKAGES="git openssh python perl"
```

## How It Works

1. When you run `macgnu install`, the script first checks if `~/.macgnu.conf` exists
2. If it does, it sources the file and reads `MACGNU_SKIP_PACKAGES`
3. Any packages listed in `MACGNU_SKIP_PACKAGES` are excluded from installation
4. All other packages are installed normally

This works for both `install` and `uninstall` commands.

## Complete Package List

The following packages are available for configuration:

### GNU programs non-existing in macOS
- tree
- watch
- wget
- wdiff
- autoconf

### GNU programs whose BSD counterpart is installed in macOS
- coreutils
- binutils
- diffutils
- ed
- findutils
- gawk
- gnu-indent
- gnu-sed
- gnu-tar
- gnu-which
- grep
- gzip
- screen

### GNU programs existing in macOS which are outdated
- bash
- emacs
- gpatch
- less
- m4
- make
- nano
- bison

### BSD programs existing in macOS which are outdated
- flex

## Tips

- Keep your config file simple with just the packages you want to skip
- You can edit your config file at any time; it takes effect on the next install/uninstall
- To see what would be installed/uninstalled with your current config, use the `--dry-run` flag:
  ```bash
  macgnu install --dry-run
  ```
- Use `macgnu status` to check the current installation status of all packages in your config
