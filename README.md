# Macgnu without common/preferred progams

## [linuxify](https://github.com/fabiomaia/linuxify) alternative

If you want to linuxify your macOS core command, but you may not want to install `libressl, file-formula, git, openssh, perl, python, rsync, unzip, vim` because you already installed it before. Then this is for you.

The macgnu is built on [linuxify](https://github.com/fabiomaia/linuxify):

Transform the macOS CLI into a fresh GNU/Linux CLI experience by

- installing missing GNU programs
- updating outdated GNU programs
- replacing pre-installed BSD programs with their preferred GNU implementation

Differences are:

- won't install `libressl, file-formula, git, openssh, perl, python, rsync, unzip, vim`
- won't ask if you want to change your shell to the latest bash.

## Install

```bash
git clone https://github.com/shinokada/macgnu.git
cd macgnu/
./macgnu install
```

Add following to `~/.zshrc`.

```zsh
. ~/.macgnu
```

## Uninstall

```bash
./macgnu uninstall
```

Remove the following from `~/.zshrc`.

```zsh
. ~/.macgnu
```
