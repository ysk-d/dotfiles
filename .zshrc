# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/yoshiki/dotfiles/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(brew gem rbenv git)

source $ZSH/oh-my-zsh.sh
source $HOME/.zshrc.custom

# User configuration
export PATH="/usr/local/sbin:$PATH"
export PATH=/usr/local/opt/mysql@5.7/bin:${PATH}
export DYLD_LIBRARY_PATH=/usr/local/opt/mysql@5.7/:${DYLD_LIBRARY_PATH}
export LANG=ja_JP.UTF-8

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

fpath=(/path/to/homebrew/share/zsh-completions $fpath)

autoload -U compinit
compinit -u

DEFAULT_USER=yoshiki@tira-me-su
