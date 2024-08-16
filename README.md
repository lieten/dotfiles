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

### AUR

Some packages need to be downloaded from the AUR. Consider using yay or paru. This README will assume yay is used. 

#### powerlevel10k

Makes zsh look pretty and has git integration and all kinds of cool stuff.
```
yay -S zsh-theme-powerlevel10k-git
```

### Other requirements 

Some other requirements to use these dotfiles properly. 

#### oh-my-zsh

Used to manage the plugins zsh uses.

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
