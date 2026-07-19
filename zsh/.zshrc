# Set Oh My Zsh path and theme
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
# ENABLE_CORRECTION="true"

# Plugins
plugins=(git)
source $ZSH/oh-my-zsh.sh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
eval "$(zoxide init --cmd cd zsh)" # Makes cd use zoxide instead of default behavior
source <(fzf --zsh)
# eval "$(rbenv init -)"

# Editor
export EDITOR='nvim'

# Tmux auto-start
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux new-session -A -s main
fi

# Aliases
alias t='tmux new-session -A -s main'
alias n='nvim .'
alias nof="fzf_listoldfiles"
alias vim='nvim'
alias dlp='yt-dlp-preferred'
alias codex='tmux set-option -p @codex_pane 1 \; select-pane -T codex; command codex'
alias claude='tmux set-option -p @claude_pane 1 \; select-pane -T claude; command claude'

export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
