# Dotfiles

Dotfiles managed with GNU Stow on MacOS.

---

## Installation

### 1. Install MacOS Prerequisites (Xcode and Homebrew)

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Clone the repo

```bash
git clone https://github.com/Czensored/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 3. Install Homebrew Packages From Backup

Make sure you're in the `.dotfiles` directory for steps 3 and 4:

```bash
brew bundle Brewfile
```

### 4. Stow the Dotfiles

```bash
stow alacritty bin git hammerspoon nvim tmux zsh
```

---

## Updating Dotfiles

After adding a new config directory (for example, `tmux`), use:

```bash
stow tmux
```

To remove symlinks:

```bash
stow -D zsh git nvim alacritty
```
