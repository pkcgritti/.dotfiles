local remap = require("pkgrt.remap")
return {
    'NeogitOrg/neogit',
    commit = "d8bf9102692250193b855acd9025a826f1af2729",
    lazy = false,
    config = function()
        local neogit = require('neogit')
        neogit.setup({})
        remap.neogit()
    end,
}
