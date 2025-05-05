# My dotfiles

This directory contains key dotfiles, mainly zsh and hyprland running Arch (btw).

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

## Installation

Clone the dotfiles repo (this repo) and run the setup script.
```
https://github.com/lieten/dotfiles.git
cd dotfiles
./setup.sh
```

Then use GNU stow to create the symlinks.
```
stow .
```
```
