local remap = require("pkgrt.remap")

return {
    "numToStr/Comment.nvim",
    opts = {
        ignore = "^$",
    },
    lazy = false,
    tag = "v0.8.0",
    config = remap.comment,
}
