# NvChad v2.5

To use this configuration, clone `starter.git` to `~/.config/NvChad`:
```shell
git clone path/to/NvChad/starter.git ~/.config/NvChad/
```

The NvChad `starter` repository is originated from [https://github.com/NvChad/starter](https://github.com/NvChad/starter)

## Dependencies

```shell
sudo apt install tree-sitter-cli ripgrep fd-find luarocks
```

## Initialization

```shell
# Make sure network connection
export {http,https,ftp}_proxy='http://127.0.0.1:7890'
alias nv="NVIM_APPNAME=NvChad nvim"
ln -s ~/Software/vim/NvChad/starter/ ~/.config/NvChad
nv
# Inside neovim, after the installation of nvchad, run :MasonIntallAll
```

## Daily upgrade
Inside neovim, run `:Lazy` and press `U`

## Disk upgrade
```shell
cd ~/.config/NvChad/
git pull
rm -rf ~/.local/share/NvChad/
nv
# Inside neovim, after the installation of nvchad, run :MasonIntallAll
```

## Uninstall
```shell
rm -rf ~/.config/NvChad/
rm -rf ~/.local/share/NvChad/
rm -rf ~/.cache/NvChad/
```

## Plugins configuration
### Chatgpt setup
Codium:
doubao: It is setup in `path/to/NvChad/starter/lua/configs/chatgpt.lua`. And the apikey is read from `~/.config/doubao/apikey`
llm.nvim:
avante:

### nvim-dap
debugpy: 
```shell
conda create --name debugpy python=3.11
conda activate debugpy
pip install debugpy
```
