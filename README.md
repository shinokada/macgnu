# Macgnu

Macgnu is a [linuxify](https://github.com/fabiomaia/linuxify) alternative.

If you want to linuxify your macOS core commands, but you may not want to install `libressl, file-formula, git, openssh, perl, python, rsync, unzip, vim` because you have already installed them. Then this is for you.

The macgnu is built on [linuxify](https://github.com/fabiomaia/linuxify):

Transform the macOS CLI into a fresh GNU/Linux CLI experience by

- installing missing GNU programs
- updating outdated GNU programs
- replacing pre-installed BSD programs with their preferred GNU implementation

Macgnu :

- won't install `libressl, file-formula, git, openssh, perl, python, rsync, unzip, vim`
- won't ask if you want to change your shell to the latest bash.

## Install

```bash
git clone https://github.com/shinokada/macgnu.git
cd macgnu/
./macgnu install
```

Add following to `~/.zshrc` and `~/.bashrc`

```zsh
# ~/.zshrc
. ~/.macgnu
```

```bash
# ~/.bashrc
. ~/.macgnu
```

If you are using iTerm you may need to add following to `~/.bash_profile`:

```bash
. ~/.bashrc
```

## Uninstall

```bash
./macgnu uninstall
```

Remove the following from `~/.zshrc` and `~/.bashrc`.

```zsh
. ~/.macgnu
```

## How to change to bash

```terminal
$ which -a bash
/usr/local/bin/bash
/bin/bash
$ chsh -s /usr/local/bin/bash
$ which bash
/usr/local/bin/bash
```
