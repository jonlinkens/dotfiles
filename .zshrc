bindkey '^I'      autosuggest-accept
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

export GITHUB_TOKEN=  
export HOMEBREW_GITHUB_API_TOKEN=$GITHUB_TOKEN
export AWS_REGION=eu-west-1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

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
alias tml="tmux split-window -h \; select-pane -L \; split-window -v"
