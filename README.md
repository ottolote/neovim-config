# Neovim Config Setup

Quick setup to link Neovim configs.

## Prerequisites

Before using these configurations, ensure you have [vim-plug](https://github.com/junegunn/vim-plug) installed for plugin management. You can install vim-plug with the following command:

```sh
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

## Environment Setup

Set the `OPENAI_API_KEY` environment variable to use the GPT features:

```bash
export OPENAI_API_KEY='your-api-key-here'
```

Add this line to your `.bashrc`, `.zshrc`, or equivalent shell configuration file to make it persistent.

## Usage

Link config files:
```bash
./create_symlinks.sh
```

Unlink:
```bash
./remove_symlinks.sh
```

## Files

- `init.vim`: Main config.
- `lua/`: Lua configs.

Backup your existing Neovim configs before proceeding!

