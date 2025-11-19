# dotfiles

## Install Instructions

### tmux Configuration
To use the `tmux` configuration, create a symlink from the `.tmux.conf` file in this directory to your home directory:

```bash
ln -s $(pwd)/.tmux.conf ~/.tmux.conf
```

### Neovim Configuration
To use the Neovim setup, create a symlink from the `nvim` directory to your `.config` directory:

```bash
ln -s $(pwd)/nvim ~/.config/nvim
```

### Local Binaries
Move all binaries from the `localbin` directory to a symlinked directory named `pkgrt` in your `.local/bin`:

```bash
mkdir -p ~/.local/bin/pkgrt
ln -s $(pwd)/localbin/* ~/.local/bin/pkgrt/
```

Ensure that `~/.local/bin/pkgrt` is added to your `PATH`. You can do so by adding the following line to your shell configuration file (e.g., `.zshrc`):

```bash
export PATH="$HOME/.local/bin/pkgrt:$PATH"
```
