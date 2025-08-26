local M = {}

M.main_class_name = nil

local function buf_find_package(bufn)
    local pattern = "package ([%a%p]*)"
    local lines = vim.api.nvim_buf_get_lines(bufn, 0, -1, false)
    for _, line in pairs(lines) do
        local _, _, pack = string.find(line, pattern)
        if pack ~= nil then
            return pack
        end
    end
end

local function buf_find_class_name(bufn)
    local pattern = "object (%a*) extends App {"
    local lines = vim.api.nvim_buf_get_lines(bufn, 0, -1, false)
    for _, line in pairs(lines) do
        local _, _, mainClass = string.find(line, pattern)
        if mainClass ~= nil then
            return mainClass
        end
    end
end

function M.execute_current_file()
    local pack = buf_find_package(0)
    if pack == nil then
        print('unable to find package')
        return
    end
    print([[found package ]] .. pack)

    local cname = buf_find_class_name(0)
    if cname == nil then
        print('unable to find class name')
    end
    print([[found class ]] .. cname)

    vim.api.nvim_command([[!bloop run root --main ]] .. pack .. [[.]] .. cname)
end

function M.execute_custom_class()
end

function M.set_main_class_name()
    local mclass = vim.fn.input("Main class: ", "")
    M.main_class_name = mclass
end

function M.get_main_class_name()
    print(M.main_class_name)
end

return M
