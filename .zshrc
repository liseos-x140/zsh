# my zshrc (zsh)
# License : MIT
# http://mollifier.mit-license.org/

#---------------------------------#

# ENVIRONMENT {{{
export LANG=ja_JP.UTF-8
fpath=(
  $HOME/.zsh/zsh-completions
  $fpath
)
#}}}


# COLOR {{{
autoload -Uz colors
colors

eval `dircolors -b`
eval `dircolors ${HOME}/.dircolors`

zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#}}}


# COMPLETIONS {{{
autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

## for pip
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
#}}}


# PROMPT {{{
PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
%# "
#}}}


# HISTORY {{{
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

setopt inc_append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
#}}}


# ALIAS {{{
alias la='ls -a'
alias ll='ls -l'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias dirs='dirs -v'
alias du='du -sh *'
alias grep='grep --color=always'
alias reload='source ~/.zshrc'
alias ssh='TERM=xterm ssh'
alias sudo='sudo '

alias -g L='| less'
alias -g G='| grep'
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
fi

## for docker
alias dps='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"'
#}}}


# KEYBIND {{{
bindkey -v
bindkey '^R' history-incremental-pattern-search-backward
#}}}


# OTHER OPTIONS {{{
setopt print_eight_bit
setopt no_beep
setopt ignore_eof
setopt interactive_comments
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt extended_glob
#}}}


# OS SETTING {{{
case ${OSTYPE} in
    darwin*)
        # Mac
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        # Linux
        alias ls='ls -F --color=auto'
        ;;
esac
#}}}


# LOCAL {{{
if [ -e ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi
# }}}


# ZSH_PACKAGE {{{
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#}}}
