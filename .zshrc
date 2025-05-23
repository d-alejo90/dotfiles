# ~~~~~~~~~~~~~~~ SSH ~~~~~~~~~~~~~~~~~~~~~~~~


# Using GPG + YubiKey for ssh.
# Don't execute when in dev container


if [[ -z "$REMOTE_CONTAINERS" && -z "$CODESPACES" && -z "$DEVCONTAINER_TYPE" ]]; then
  export GPG_TTY="$(tty)"
  unset SSH_AGENT_PID

  if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  fi

  gpgconf --launch gpg-agent
  gpg-connect-agent updatestartuptty /bye > /dev/null 2>&1

fi


# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~


# Set to superior editing mode

set -o vi

export VISUAL=nvim
export EDITOR=nvim
export TERM="tmux-256color"

export BROWSER="firefox"

# Directories

export REPOS="$HOME/Repos"
export GITUSER="d-alejo90"
export GHREPOS="$REPOS/github.com/$GITUSER"
export DOTFILES="$GHREPOS/dotfiles"
export LAB="$GHREPOS/lab"
export SCRIPTS="$DOTFILES/scripts"
export ZETTELKASTEN="$HOME/Zettelkasten"

# Go related. In general all executables and scripts go in .local/bin

export GOBIN="$HOME/.local/bin"
export GOPRIVATE="github.com/$GITUSER/*,gitlab.com/$GITUSER/*"
# export GOPATH="$HOME/.local/share/go"
export GOPATH="$HOME/go/"


# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~


setopt extended_glob null_glob

path=(
    $path                           # Keep existing PATH entries
    $HOME/bin
    $HOME/.local/bin
    $SCRIPTS
    $HOME/.krew/bin
    $HOME/.rd/bin                   # Rancher Desktop
    /home/vscode/.local/bin         # Dev Container Specifics
    /root/.local/bin                # Dev Container Specifics
)

# Remove duplicate entries and non-existent directories
typeset -U path
path=($^path(N-/))

export PATH


# ~~~~~~~~~~~~~~~ Dev Container Specifics ~~~~~~~~~~~~~~~~~~~~~~~~


if [ -d "/home/linuxbrew/.linuxbrew" ]; then
     eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi


# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~


HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_SPACE  # Don't save when prefixed with space
setopt HIST_IGNORE_DUPS   # Don't save duplicate lines
setopt SHARE_HISTORY      # Share history between sessions


# ~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~


PURE_GIT_PULL=0


if [[ "$OSTYPE" == darwin* ]]; then
  fpath+=("$(brew --prefix)/share/zsh/site-functions")
else
  fpath+=($HOME/.zsh/pure)
fi

autoload -U promptinit; promptinit
prompt pure


# ~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~


alias v=nvim

alias scripts='cd $SCRIPTS'
alias cdblog="cd ~/websites/blog"
alias c="clear"
alias zrc="v ~/.zshrc"

# Repos

alias lab='cd $LAB'
alias dot='cd $GHREPOS/dotfiles'
alias repos='cd $REPOS'
alias ghrepos='cd $GHREPOS'
alias gr='ghrepos'
alias cdgo='cd $GHREPOS/go/'
alias h='cd ~'

# Homelab

alias homelab='cd $GHREPOS/homelab/'
alias hl='homelab'

#Terraform
alias  tf='terraform'
alias tfp='terraform plan'
alias tfi='terraform init'
alias tfd='terraform destroy'
alias tfa='terraform apply'

# forti-client
alias ofc='sudo openfortivpn'

# ls

alias ls='ls --color=auto'
alias la='ls -lathr'
# alias la='exa -laghm@ --all --icons --git --color=always'


# finds all files recursively and sorts by last modification, ignore hidden files
alias lastmod='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

alias t='tmux'
alias e='exit'

alias syu='sudo pacman -Syu'

# Azure

alias sub='az account set -s'

# Git

alias gp='git pull'
alias gs='git status'
alias lg='lazygit'


# Zettelkasten

alias in="cd \$ZETTELKASTEN/0\ Inbox/"
alias cdzk="cd \$ZETTELKASTEN"


# Kubernetes

alias k='kubectl'

alias kgp='kubectl get pods'
alias kc='kubectx'
alias kn='kubens'

alias fgk='flux get kustomizations'

# Pass

alias pc='pass show -c'

# Devpod

alias ds='devpod ssh'


# ~~~~~~~~~~~~~~~ Completion ~~~~~~~~~~~~~~~~~~~~~~~~


fpath+=~/.zfunc

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

autoload -Uz compinit
compinit -u

zstyle ':completion:*' menu select


# Example to install completion:
# talosctl completion zsh > ~/.zfunc/_talosctl
source <(kubectl completion zsh)


# ~~~~~~~~~~~~~~~ Sourcing ~~~~~~~~~~~~~~~~~~~~~~~~


# source "$HOME/.privaterc"
source <(fzf --zsh)

# eval "$(direnv hook zsh)"

# ~~~~~~~~~~~~~~~ Misc ~~~~~~~~~~~~~~~~~~~~~~~~



fpath+=~/.zfunc; autoload -Uz compinit; compinit

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/home/dalejo90/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# bun completions
[ -s "/home/dalejo90/.bun/_bun" ] && source "/home/dalejo90/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
