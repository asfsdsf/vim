# NvChad

To use this configuration, symlink `custom/` directory to `~/.config/NvChad/lua/custom`

## Initialization

```shell
# Make sure network connection
export {http,https,ftp}_proxy='http://127.0.0.1:7890'
alias nvc="NVIM_APPNAME=NvChad nvim"
git clone https://github.com/NvChad/NvChad ~/.config/NvChad --depth 1
ln -s ~/Software/vim/NvChad/custom ~/.config/NvChad/lua/custom
nvc
# Inside neovim, after the installation of nvchad, run :MasonIntallAll
```

## Daily upgrade
Inside neovim, run `:Lazy` and press `U`

## Disk upgrade
```shell
cd ~/.config/NvChad/
git pull
rm -rf ~/.local/share/NvChad/
nvc
# Inside neovim, after the installation of nvchad, run :MasonIntallAll
```

## Uninstall
```shell
rm -rf ~/.config/NvChad/
rm -rf ~/.local/share/NvChad/
```
