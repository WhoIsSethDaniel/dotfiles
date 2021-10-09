# HOME DIRECTORY SETUP

Commands for initializing a new home directory

## chezmoi Bootstrap

install keychain (https://www.funtoo.org/Keychain)
```
aptitude install keychain
```

then chezmoi (https://github.com/twpayne/chezmoi)

```
go install github.com/twpayne/chezmoi@latest
chezmoi upgrade -f
chezmoi init https://github.com/WhoIsSethDaniel/dotfiles --apply

<config file?>
$HOME/.config/chezmoi/chezmoi.toml
encryption = "gpg"
[gpg]
    recipient = "seth@sethdaniel.org"
```
https://github.com/twpayne/chezmoi
https://github.com/twpayne/chezmoi/blob/master/docs/QUICKSTART.md
https://github.com/twpayne/chezmoi/blob/master/docs/HOWTO.md
https://github.com/twpayne/chezmoi/blob/master/docs/REFERENCE.md#chattr-attributes-targets

## Install Deb Repos

```
create-deb-repos
```

## (Neo)Vim

First install the vim and neovim repositories and packages (see above)

install xclip, some tools, and python3-neovim
```
aptitude install xclip python3-neovim ripgrep fd-find
```

install some fonts
```
install-fonts
```
current font: dejavu sans mono nerd font mono book

### Install all plugins
```
vim-rebuild
```

### Run checkhealth and look for missing things
```
vim +checkhealth
```

### Language servers install

```
install-ls
```

## Perl / Plenv

```
git clone git@github.com:tokuhirom/plenv.git $HOME/.plenv
git clone git@github.com:tokuhirom/Perl-Build.git ~/.plenv/plugins/perl-build/
git clone git@github.com:WhoIsSethDaniel/plenv-module-inspector.git ~/.plenv/plugins/module-inspector
plenv install 5.34.0
plenv version 5.34.0
cpanm PLS
```
https://github.com/tokuhirom/plenv <br>
https://github.com/tokuhirom/Perl-Build

## Go

```
install-go
# maybe
vim +GoInstallBinaries +q  
```
https://golang.org/dl/

## PAM

install some pam modules 
```
sudo aptitude install libpam-ssh libpam-ssh-agent-auth
# configure them
```

## Done

```
homeshick -v -f link
source $HOME/.bashrc
```
