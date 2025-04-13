vim.cmd [[
    " let g:VM_no_meta_mappings=0
    " - enable mouse for vim-multiple-cursor
    let g:VM_mouse_mappings = 1
    " - clear default mappings of vim-multiple-cursor
    let g:VM_maps = {}
    " - map of mouse for vim-multiple-cursor
    let g:VM_maps["Mouse Cursor"]               = '<C-LeftMouse>'
    let g:VM_maps["Mouse Word"]                 = '<C-RightMouse>'
    let g:VM_maps["Mouse Column"]               = '<M-C-RightMouse>'

    " - map g/ to start regex search for vim-multiple-cursor
    let g:VM_maps["Start Regex Search"]         = 'g/'
    " It is normal mode map
    let g:VM_maps["Visual Regex"]               = 'g/'

    " - map M-j/M-k to add cursor down/up for vim-multiple-cursor
    let g:VM_maps["Add Cursor Down"]            = '<A-J>'
    let g:VM_maps["Add Cursor Up"]              = '<A-K>'

    " - map 1 to add increasing numbers for vim-multiple-cursor
    let g:VM_maps["Numbers"]                    = '1'

    " - map M-a to select all occurence in normal mode for vim-multiple-cursor
    let g:VM_maps["Select All"]                 = '<A-A>'

    " - Select all that match visual selection (it is a visual map)
    let g:VM_maps["Visual All"]                 = '<A-A>'

    " - map z< to align char for vim-multiple-cursor
    let g:VM_maps["Align Char"]                 = 'z<'
]]
