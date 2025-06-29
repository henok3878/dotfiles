# dotfiles 

This repo contains all my personalized configuration and helper scripts. 

## Structure 

- `home/`
My "dot" files that live in `$HOME` (e.g: `.zshrc`) 

- `configs/`
[XDG-style](https://specifications.freedesktop.org/basedir-spec/latest/) config directories under `~/.config/` (e.g: `nvim/`) 

- `scripts/` 
Executable utilities which get symlinked into `~/bin/` or `~/.local/bin` 

- `install.sh` 
Bootstrap script to symlink everything and install prerequisites. 


## Bootstrap 

On a fresh machine: 
```bash
git clone git@github.com:henok3878/dotfiles.git
cd ~/dotfiles
./install.sh 
```
