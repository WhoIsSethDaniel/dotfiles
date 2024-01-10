# HOME DIRECTORY SETUP

Commands for initializing a new home directory

## home Bootstrap

install needed packages

```bash
apt install keychain git-crypt curl make xclip python3-neovim ripgrep fd-find gcc g++ ncurses-term gh jekyll ruby-dev libhunspell-dev wl-clipboard
```

setup home ("https://dev.to/bowmanjd/store-home-directory-config-files-dotfiles-in-git-using-bash-zsh-or-powershell-the-bare-repo-approach-35l3")

```bash
mkdir -p $HOME/.config/dotfiles
cd $HOME/.config/dotfiles
git --git-dir=$HOME/.config/dotfiles/home --work-tree=$HOME clone --bare https://github.com/WhoIsSethDaniel/dotfiles $HOME/.config/dotfiles/home
git --git-dir=$HOME/.config/dotfiles/home --work-tree=$HOME checkout -f
. ~/.bashrc
git clone git@github.com:WhoIsSethDaniel/dotfiles-home main
cd ~
git-crypt unlock <path to key>
```

## Install Deb Repos

```bash
install-deb-repos
# if sys76 host
install-sys76-deb-repo
```

## Install wezterm

```bash
install-wezterm
```

## Install tmux completions

```bash
install-tmux-completions
```

## (Neo)Vim

First install the vim and neovim repositories and packages (see above)

install some fonts

```bash
install-fonts
```

current font: dejavu sans mono nerd font mono book

### Install all plugins

```bash
vim-check
vim-build-sources
```

### Run checkhealth and look for missing things

```bash
vim +checkhealth
```

## Perl / Plenv

```bash
git clone git@github.com:tokuhirom/plenv.git $HOME/.plenv
git clone git@github.com:tokuhirom/Perl-Build.git ~/.plenv/plugins/perl-build/
git clone git@github.com:WhoIsSethDaniel/plenv-module-inspector.git ~/.plenv/plugins/module-inspector
. .bashrc
plenv install 5.36.0
plenv global 5.36.0
plenv install-cpanm
cpanm PLS
```

"https://github.com/tokuhirom/plenv" <br>
"https://github.com/tokuhirom/Perl-Build"

## Go

```bash
install-go
```

"https://golang.org/dl/"

## PAM

configure the pam modules libpam-ssh/libpam-ssh-agent-path

## jekyll

install

```bash
git clone git@github.com:WhoIsSethDaniel/site
# may require sudo
bundle
cd site
git submodule init
git submodule update
```

run

```bash
bundle exec jekyll build
```

## lemonade

activate and start systemd user service

```bash
systemctl --user enable lemonade.service
systemctl --user start lemonade.service
```
