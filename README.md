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

## Language Server Protocol (LSP) Configuration

To use the LSP functionality, each language server must be installed separately. For example, to configure the Bicep language server:

1. Install the .NET SDK from the official Microsoft .NET download page.
2. Install the Bicep language server by running the following commands:

    ```bash
    sudo (cd $(mktemp -d) && curl -fLO https://github.com/Azure/bicep/releases/latest/download/bicep-langserver.zip && rm -rf /usr/local/bin/bicep-langserver && unzip -d /usr/local/bin/bicep-langserver bicep-langserver.zip)
    ```

3. The `config.lua` script in the `lua/` directory  installation path for the Bicep language server binary. If you manually install `Bicep.LangServer.dll` at a different location, update the `bicep_lsp_bin` variable in `config.lua` to match the new path.

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

