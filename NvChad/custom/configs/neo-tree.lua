local present, neotree = pcall(require, "neo-tree")

if not present then
  return
end

local options = {
    filesystem = {
    window={mappings={
    -- disable copy-to-clipboard in neo-tree
        ["/"]="none",
    -- disable fuzzy finder in neo-tree
        ["y"]="none",
    -- map Y to copy-to-clipboard
        ["Y"]="copy_to_clipboard",
    -- remap motion key
        ["w"]="none",
        ["e"]="none",
        ["l"]="none",
    }
    }}
}

neotree.setup(options)
