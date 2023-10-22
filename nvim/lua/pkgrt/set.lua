-- show line number and relative numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- indent using tabs with 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- do not wrap
vim.opt.wrap = false

-- undo settings
vim.opt.swapfile = false
vim.opt.backup = fasle
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- incremental search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- windows behavior
vim.opt.scrolloff = 8
vim.opt.signcolumn = "auto"
vim.opt.colorcolumn = "140"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50

-- wild menu behavior
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full"
vim.opt.wildignore = "*.docx,*.jpg,*.png,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"

