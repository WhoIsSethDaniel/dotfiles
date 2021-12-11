# HOME DIRECTORY SETUP

Commands for initializing a new home directory

## home Bootstrap

install keychain (https://www.funtoo.org/Keychain)
```
aptitude install keychain
```

install git-crypt
```
apt install git-crypt
```

setup home (https://dev.to/bowmanjd/store-home-directory-config-files-dotfiles-in-git-using-bash-zsh-or-powershell-the-bare-repo-approach-35l3)
```
git clone --bare git@githb.com:WhoIsSethDaniel/dotfiles ~/.dotfiles
check config --local status.showUntrackedFiles no
git-crypt unlock <path to key>
```

## Install Deb Repos

```
create-deb-repos
```

## (Neo)Vim

First install the vim and neovim repositories and packages (see above)

install xclip, some tools, and python3-neovim
```
aptitude install xclip python3-neovim ripgrep fd-find gcc g++
```

install some fonts
```
install-fonts
```
current font: dejavu sans mono nerd font mono book

### Install all plugins
```
vim-check -b
vim-build-sources
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
plenv global 5.34.0
plenv install-cpanm
cpanm PLS
```
https://github.com/tokuhirom/plenv <br>
https://github.com/tokuhirom/Perl-Build

## Go

```
apt install curl make
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
