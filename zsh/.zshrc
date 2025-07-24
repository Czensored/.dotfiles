# Set Oh My Zsh path and theme
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
ENABLE_CORRECTION="true"

# Plugins
plugins=(git)
source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(zoxide init --cmd cd zsh)" # Makes cd use zoxide instead of default behavior
source <(fzf --zsh)
eval "$(rbenv init -)"

# Editor
export EDITOR='nvim'

# Tmux auto-start
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux new-session -A -s main
fi

# Aliases
alias t='tmux new-session -A -s main'
alias n='nvim .'
alias nof="$HOME/.local/bin/fzf_listoldfiles"
