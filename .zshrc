# zmodload zsh/zprof

autoload -Uz compinit
compinit

ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(buffer-empty bracketed-paste accept-line push-line-or-edit)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=true

EDITOR=nvim
export AWS_REGION=eu-west-1
export COREPACK_ENABLE_AUTO_PIN=0
export HUSKY_SKIP_HOOKS=1
export OPENCODE_EXPERIMENTAL_OXFMT=true

eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export PATH=/Users/jonlinkens/.local/bin:$PATH
export PATH="$HOME/Library/Python/3.14/bin:$PATH"

source ~/.git.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

alias vim="nvim"
alias gmj="gimoji && git commit"
alias lg="lazygit"
alias vfr='vim $(find /Users/jonlinkens/dev -mindepth 1 -maxdepth 1 -type d | fzf)'
alias oc="opencode"
alias hd="hunk diff"
alias gcr='git branch --sort=-committerdate | grep -v "^\*" | fzf --height=30% --reverse --info=inline | xargs git checkout'

alias tml="tmux split-window -h \; select-pane -L \; split-window -v"
alias tma="tmux attach"

alias td='d=$(find /Users/jonlinkens/dev -mindepth 1 -maxdepth 1 -type d | fzf) && cd "$d" && w=$(tmux display-message -p "#{window_id}") && tmux new-window -c "$d" \; split-window -h -c "$d" \; new-window -c "$d" "opencode; exec \$SHELL" \; new-window -c "$d" "hunk diff; exec \$SHELL" \; select-window -t "$w"'

alias yys='yarn && yarn start'
alias yyb='yarn && yarn build'
alias yt='yarn test'
alias yso='yarn service start:offline'
alias yta='TS_NODE_TRANSPILE=false yarn service test:acceptance:offline'

alias saad='seneca aws assume dev'
alias saw='seneca aws whoami'

[ -s "/Users/jonlinkens/.bun/_bun" ] && source "/Users/jonlinkens/.bun/_bun"
source <(fzf --zsh)
bindkey '^I' autosuggest-accept

export PATH=/Users/jonlinkens/.opencode/bin:$PATH
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# zprof
