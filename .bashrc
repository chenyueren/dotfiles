#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
[[ $TERM == 'xterm-kitty' ]] && export TERM=kitty

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
alias config="/usr/bin/git --git-dir=$HOME/.cfg/.git --work-tree=$HOME"
