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

## Installing GNU

### [Awesome package manager]

After installing [Awesome package manager](https://github.com/shinokada/awesome):

```sh
awesome -i shinokada/macgnu
macgnu install
```

### Download/Clone

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

## Uninstalling GNU

```sh
./macgnu uninstall
```

Remove the following from `~/.zshrc` and `~/.bashrc`.

```zsh
. ~/.macgnu
```

## How to change to bash

You may want to change from ZSH to Bash and vice versa:

```terminal
# from ZSH to Bash
$ which -a bash
/usr/local/bin/bash
/bin/bash
$ chsh -s /usr/local/bin/bash
Changing shell for shinokada.
Password for shinokada:
# Open a new tab or restart your terminal
$ which bash
/usr/local/bin/bash
```

```terminal
# from Bash to ZSH
$ which -a zsh
/bin/zsh
$ chsh -s /bin/zsh
Changing shell for shinokada.
Password for shinokada:
# Open a new tab or restart your terminal
```
