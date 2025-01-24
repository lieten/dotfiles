# My dotfiles

This directory contains key dotfiles. 

## Requirements

These dotfiles depend on the following things

### Packages

These are the required packages installable with pacman.

#### git (duh)

```
sudo pacman -S git
```

#### GNU stow 

Used to create the actual symlinks that make this work.
```
sudo pacman -S stow
```

### oh-my-zsh

Used to manage the plugins zsh uses.
First, install oh-my-zsh from their GitHub at https://github.com/ohmyzsh/ohmyzsh 
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
Then install the following plugins. 

#### powerlevel10k

Installed from https://github.com/romkatv/powerlevel10k
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

#### zsh-autosuggestions

Installed from https://github.com/zsh-users/zsh-autosuggestions
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

#### zsh-syntax-highlighting

Installed from https://github.com/zsh-users/zsh-syntax-highlighting
```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

## Installation

Clone the dotfiles repo (this repo) in your $HOME directory using ssh (assumes ssh key setup). 
```
git clone git@github.com:lieten/dotfiles.git
cd dotfiles
```

Then use GNU stow to create the symlinks.
```
stow .
```

## Honorable Mention

This setup is inspired by this youtube video: https://www.youtube.com/watch?v=y6XCebnB9gs

## TODOs

- replace stow with general setup script (on experimental branch)
- current temporary setup script does not symlink modular config
