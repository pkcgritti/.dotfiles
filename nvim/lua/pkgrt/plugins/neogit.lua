local remap = require("pkgrt.remap")
return {
    'NeogitOrg/neogit',
    lazy = false,
    config = function()
        local neogit = require('neogit')
        neogit.setup({})
        remap.neogit()
    end,
}
