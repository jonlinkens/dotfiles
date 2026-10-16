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

if [[ -n $REX_SESSION ]]; then
  autoload -Uz add-zsh-hook
  rex_environment_status() {
    local title
    case $SENECA_ENV in
      production) title=cHJvZHVjdGlvbg== ;;
      staging) title=c3RhZ2luZw== ;;
      dev) title=ZGV2 ;;
      edge) title=ZWRnZQ== ;;
      infra) title=aW5mcmE= ;;
    esac
    if [[ -n $title ]]; then
      printf '\e]7501;state=idle:id=seneca-env:app=seneca:title=%s\e\\' "$title"
    else
      printf '\e]7501;state=clear:id=seneca-env\e\\'
    fi
  }
  add-zsh-hook precmd rex_environment_status
fi

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

td() {
  [[ -n $REX_SESSION ]] || { print -u2 'td requires a Rex terminal'; return 1; }
  local dir
  dir=$(find "$HOME/dev" -mindepth 1 -maxdepth 1 -type d | fzf) || return
  cd -- "$dir" || return
  rex do td_layout dir="$dir" || return
  rex do com.superlogical.terminal.clear -b "$REX_BLOCK" >/dev/null
}

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
