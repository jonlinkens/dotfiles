# zmodload zsh/zprof

autoload -Uz compinit
compinit

bindkey '^I'      autosuggest-accept
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

export GITHUB_TOKEN=
export HOMEBREW_GITHUB_API_TOKEN=$GITHUB_TOKEN
export AWS_REGION=eu-west-1


lazy_load_nvm() {
  unset -f npm node nvm
  export NVM_DIR=~/.nvm
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
}

npm() {
 lazy_load_nvm
 npm $@
}

node() {
  lazy_load_nvm
  node $@
}

nvm() {
  lazy_load_nvm
  nvm $@
}

export PATH="$HOME/.tfenv/bin:$PATH"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
export PATH=/Users/jonlinkens/.local/bin:$PATH
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

source ~/.git.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

alias vim="nvim"
alias gmj="gimoji && git commit"

# source <(fzf --zsh)
# zprof
