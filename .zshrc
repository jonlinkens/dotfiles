# zmodload zsh/zprof

autoload -Uz compinit
compinit

bindkey '^I'      autosuggest-accept
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

EDITOR=nvim

export GITHUB_TOKEN=
export HOMEBREW_GITHUB_API_TOKEN=$GITHUB_TOKEN
export AWS_REGION=eu-west-1

export COREPACK_ENABLE_AUTO_PIN=0
export HUSKY_SKIP_HOOKS=1
export OPENCODE_EXPERIMENTAL_OXFMT=true

eval "$(fnm env --use-on-cd --shell zsh)"

export PATH="$HOME/.tfenv/bin:$PATH"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
export PATH=/Users/jonlinkens/.local/bin:$PATH
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="$HOME/Library/Python/3.14/bin:$PATH"

source ~/.git.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

alias vim="nvim"
alias gmj="gimoji && git commit"
alias tml="tmux split-window -h \; select-pane -L \; split-window -v"
alias tma="tmux attach"
alias lg="lazygit"
alias vfr='vim $(find /Users/jonlinkens/dev -mindepth 1 -maxdepth 1 -type d | fzf)'
alias oc="opencode"
alias hd="hunk diff --watch"


alias gcr='git branch --sort=-committerdate | grep -v "^\*" | fzf --height=30% --reverse --info=inline | xargs git checkout'

source <(fzf --zsh)
# zprof
