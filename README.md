# Dotfiles

Dotfiles managed with GNU Stow on MacOS.

---

## Installation

### 0. Prerequisites (macOS)

Install Xcode and Homebrew
```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 1. Clone the Repository

```bash
git clone https://github.com/czensored/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Install GNU Stow

```bash
brew install stow
```

### 3. Stow the Dotfiles

Run the following from inside the `.dotfiles` directory:

```bash
stow alacritty bin git hammerspoon nvim tmux zsh
```

---

## Homebrew Packages

Install Homebrew files from backup:

```bash
brew bundle ~/.dotfiles/Brewfile
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
