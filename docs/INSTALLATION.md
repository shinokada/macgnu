# Installation and Setup Guide

## Quick Start

### 1. Install MacGNU

Using Awesome package manager:
```bash
awesome install shinokada/macgnu
```

Or clone and run directly:
```bash
git clone https://github.com/shinokada/macgnu.git
cd macgnu
./macgnu install
```

### 2. Create Configuration (Optional)

If you want to skip certain packages:

```bash
# Copy example config
cp .macgnu.conf.example ~/.macgnu.conf

# Edit to your preferences
nano ~/.macgnu.conf
```

Edit `MACGNU_SKIP_PACKAGES` to list packages you want to skip:

```bash
# Example: skip bash and emacs
MACGNU_SKIP_PACKAGES="bash emacs"
```

### 3. Install GNU Programs

```bash
macgnu install
```

The script will:
- Check your system (macOS + Homebrew required)
- Read your config file (if it exists)
- Install or skip packages based on your config
- Copy `.macgnu` to your home directory
- Show you what to add to your shell config

### 4. Update Your Shell Config

Add the following to your `~/.zshrc` or `~/.bashrc`:

```bash
# For zsh
echo '. ~/.macgnu' >> ~/.zshrc

# For bash
echo '. ~/.macgnu' >> ~/.bashrc
```

### 5. Restart Your Terminal

```bash
# Close and reopen terminal, or
exec zsh   # or exec bash
```

### 6. Verify Installation

Check which packages are installed:

```bash
macgnu status
```

## Complete Installation Examples

### Example 1: Install Everything (Default)

```bash
# Create config with no skips
cat > ~/.macgnu.conf << 'EOF'
MACGNU_SKIP_PACKAGES=""
EOF

# Install all packages
macgnu install

# Update shell config
echo '. ~/.macgnu' >> ~/.zshrc
```

### Example 2: Install Without Bash/Emacs

```bash
# Create config skipping bash and emacs
cat > ~/.macgnu.conf << 'EOF'
MACGNU_SKIP_PACKAGES="bash emacs"
EOF

# Install (skips bash and emacs)
macgnu install

# Update shell config
echo '. ~/.macgnu' >> ~/.zshrc
```

### Example 3: Install with Custom Packages

```bash
# Create config with multiple skips
cat > ~/.macgnu.conf << 'EOF'
MACGNU_SKIP_PACKAGES="bash emacs nano bison flex gnu-indent"
EOF

# Preview what will be installed
macgnu install --dry-run

# Install
macgnu install
```

## Troubleshooting

### "Homebrew not installed!"

Install Homebrew first:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### "dir must exist and be writeable"

Fix Homebrew permissions:
```bash
sudo chown -R $(whoami) /usr/local/bin /usr/local/sbin
chmod u+w /usr/local/bin /usr/local/sbin
```

### "command not found" after installation

Make sure you:
1. Added `. ~/.macgnu` to your shell config
2. Restarted your terminal or ran `exec zsh`
3. Have the correct shell (check with `echo $SHELL`)

### Some packages failed to install

Check if Homebrew can install the package:
```bash
brew info package-name
brew install package-name
```

Some packages may have OS version requirements.

### Want to try without installing

Use dry-run mode:
```bash
macgnu install --dry-run
```

This shows what would be installed without actually installing.

## Uninstalling

To remove MacGNU and all packages:

```bash
macgnu uninstall
```

Then remove from your shell config:
```bash
# Remove from ~/.zshrc
sed -i '' '/. ~\/.macgnu/d' ~/.zshrc

# Or remove from ~/.bashrc
sed -i '' '/. ~\/.macgnu/d' ~/.bashrc
```

## Next Steps

- Read [FEATURES.md](FEATURES.md) for all available commands
- See [CONFIGURATION.md](CONFIGURATION.md) for detailed config options
- Check [README.md](../README.md) for package list and general info
- Run `macgnu status` to see what's installed
- Run `macgnu -h` for command help

## Getting Help

- Run `macgnu -h` for help
- Run `macgnu info` to see details about packages
- Check GitHub issues: https://github.com/shinokada/macgnu/issues
