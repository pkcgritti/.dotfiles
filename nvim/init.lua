-- Setup working for NVIM v0.11.3
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=v10.14.6",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("pkgrt")

