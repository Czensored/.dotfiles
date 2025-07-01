# Dotfiles

This is a modular, symlink-based dotfiles setup on MacOS managed with [GNU Stow](https://www.gnu.org/software/stow/).

---

## Installation

### 0. Prerequisites (macOS)

Install Xcode Command Line Tools:

```bash
xcode-select --install
```

Then install Homebrew:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Follow any post-install instructions to add Homebrew to your shell environment.

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

This will automatically create the symlinks for the above dotfiles.

---

## Homebrew Packages

This repository includes a `Brewfile` to install system packages via Homebrew:

```bash
brew bundle ~/.dotfiles/Brewfile
```

This installs CLI tools and GUI apps listed in the file.

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
