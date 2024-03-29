<p align="center">
<a href='https://ko-fi.com/Z8Z2CHALG' target='_blank'><img height='42' style='border:0px;height:42px;' src='https://storage.ko-fi.com/cdn/kofi3.png?v=3' alt='Buy Me a Coffee at ko-fi.com' /></a>
</p>

<h1 align="center">MacGNU</h1>

<p align="center">
<a href="https://macgnu.codewithshin.com/">MacGNU</a>
</p>

<p align="center">
<a href="https://twitter.com/shinokada" rel="nofollow"><img src="https://img.shields.io/badge/created%20by-@shinokada-4BBAAB.svg" alt="Created by Shin Okada"></a>
<a href="https://opensource.org/licenses/MIT" rel="nofollow"><img src="https://img.shields.io/github/license/shinokada/macgnu" alt="License"></a>
</p>

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

## Installing MacGNU with Awesome package manager

After installing [Awesome package manager](https://github.com/shinokada/awesome):

```sh
awesome install shinokada/macgnu
```

## Install GNUs

```bash
macgnu install
```

After installation, create `~/.macgnu` and copy [.macgnu](https://github.com/shinokada/macgnu/blob/main/.macgnu).

Add following to your terminal configuration `~/.zshrc` or `~/.bashrc`

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

## Uninstalling GNUs

```sh
macgnu uninstall
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

## List of packages installed

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

## License

MIT License

Copyright (c) 2021 Shinichi Okada

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.