local remap = require("pkgrt.remap")

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    lazy = false,
    config = remap.telescope,
    dependencies = {
        {
            "nvim-lua/plenary.nvim",
            tag = "v0.1.4"
        }
    }
}

