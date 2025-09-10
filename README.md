# Dotfiles

## Installation

```bash
# Install MacOS Prerequisites (Xcode and Homebrew)
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Clone the repo
git clone https://github.com/Czensored/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# Install Homebrew Packages From Backup
brew bundle Brewfile

# Stow the Dotfiles
stow alacritty bin git hammerspoon nvim skhd tmux yabai zsh
```

---

## Updating Dotfiles

After adding a new config directory with GNU Stow (for example, `tmux`), use:

```bash
stow tmux
```

To remove symlinks:

```bash
stow -D zsh git nvim alacritty
```
