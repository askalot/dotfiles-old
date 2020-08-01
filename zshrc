# VCS info
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
zstyle ':vcs_info:git:*' formats '%b'

# Prompt
autoload -U colors
colors
setopt PROMPT_SUBST

PROMPT='
%~
%(?,%{$fg[green]%}❯%{$reset_color%},%{$fg[red]%}❯%{$reset_color%}) '

RPROMPT='%{$fg[grey]%}$(whoami)@$(hostname)%{$reset_color%} '\$vcs_info_msg_0_

# Autocomplete
autoload -U compinit
compinit
zmodload zsh/complist
zstyle ':completion:*' menu select

# Alias
if [ `uname` = 'Darwin' ]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi

cd() {
  builtin cd "$@" && ls
}

# Load plugins
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# chruby settings
source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh

