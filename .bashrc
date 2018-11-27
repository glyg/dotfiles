# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
export HISTFILESIZE=2500
export HISTSIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval `dircolors -b`
    alias sl='ls --color=auto'
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# A color and a non-color prompt:
#PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w \$ '

# Comment in the above and uncomment this below for a color prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\][\u]:\[\033[01;34m\]\W\[\033[00m\] \$ '

# If this is an xterm set the title to dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${PWD}\007"'
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
export PATH
PATH="/home/guillaume/bin:$PATH"

PYTHONPATH="/home/guillaume/Dev:$PYTHONPATH"
export PYTHONPATH

SIMPATH="/media/data/Simulations/"
export SIMPATH



#alias ajoutés par moi

#taille d'un fichier
alias size='ll -h | grep'

alias gnome-terminal='gnome-terminal --geometry 80X25+25+25'
alias xfce4-terminal='xfce4-terminal --geometry 80X25+25+25'
alias emacs='emacs'
alias emacs_nd='emacs --no-desktop -g 160X60'
alias ipynb='jupyter notebook'
alias sa='source activate'
alias pyinst='python setup.py install && date'


# Custom prompt
GIT_PS1_SHOWUNTRACKEDFILES=1 # affiche % en présence de fichiers non versionnés
GIT_PS1_SHOWDIRTYSTATE=1 # affiche si des changements sont intervenus
if [ `whoami` = root ]; then
    SYMBOL="#"
else
SYMBOL="\$"
fi
PS1='\[\033[01;32m\]\u\[\033[0m\] \[\033[1;34m\]\h \[\033[1;35m\]\W\[\033[1;31m\]$(__git_ps1 " (%s)") \[\033[0m\]$SYMBOL '

# added by Miniconda3 4.3.21 installer
export PATH="/home/guillaume/miniconda3/bin:$PATH"

export EDITOR=jed
