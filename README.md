# Dotfiles

Personal configuration files managed with GNU Stow.

## Managed Configurations


## Additional Resources
- ~/.local/bin scripts
- ~/.local/share/fonts
- ~/.local/share/themes

## Setup
```bash
git clone git@github.com:USERNAME/archvm-dots.git ~/.dotfiles
cd ~/.dotfiles
stow */
paru -S --needed - < packages.txt
```
