local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local projects = function(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "projects",
        finder = finders.new_table {
            results = { "esparta", "data-ingestor" }
        },
        sorter = conf.generic_sorter(opts),
    }):find()
end

projects()
