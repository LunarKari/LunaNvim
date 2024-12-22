local heirline = require('heirline')
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local colors = {
    bg = "#1e1e2e",
    fg = "#f4cddd",
    red = "#f38ba8",
    green = "#a6e3a1",
    yellow = "#f9e2af",
    blue = "#89b4fa",
    magenta = "#f5c2e7",
    cyan = "#94e2d5",
    gray = "#585b70",
}

local Diagnostics = {
    condition = conditions.has_diagnostics,
    static = {
        error_icon = " ",
        warn_icon = " ",
        info_icon = " ",
        hint_icon = " ",
    },
    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,
    {
        provider = function(self)
            return self.error_icon .. self.errors .. " "
        end,
        hl = { fg = colors.red },
        condition = function(self)
            return self.errors > 0
        end,
    },
    {
        provider = function(self)
            return self.warn_icon .. self.warnings .. " "
        end,
        hl = { fg = colors.yellow },
        condition = function(self)
            return self.warnings > 0
        end,
    },
    {
        provider = function(self)
            return self.info_icon .. self.info .. " "
        end,
        hl = { fg = colors.blue },
        condition = function(self)
            return self.info > 0
        end,
    },
    {
        provider = function(self)
            return self.hint_icon .. self.hints .. " "
        end,
        hl = { fg = colors.cyan },
        condition = function(self)
            return self.hints > 0
        end,
    },
    { provider = " " },
}

local Mode = {
    provider = function()
        local mode = vim.fn.mode()
        local modes = {
            n = "NORMAL",
            i = "INSERT",
            v = "VISUAL",
            V = "VISUAL LINE",
            ["\22"] = "VISUAL BLOCK",
            ["\22s"] = "VISUAL BLOCK",
            c = "COMMAND",
            R = "REPLACE",
            t = "TERMINAL",
        }
        return string.format(" %s ", modes[mode] or mode)
    end,
    hl = function()
        local mode = vim.fn.mode()
        local mode_colors = {
            n = colors.blue,
            i = colors.green,
            v = colors.magenta,
            V = colors.magenta,
            ["\22"] = colors.magenta,
            ["\22s"] = colors.magenta,
            c = colors.yellow,
            R = colors.red,
            t = colors.cyan,
        }
        return { fg = mode_colors[mode], bg = nil, bold = true, italic = true }
    end,
}

local FileName = {
    provider = function()
        local filename = vim.fn.expand("%:t")
        return filename ~= "" and filename or "[No Name]"
    end,
    hl = { fg = colors.fg, bold = true, italic = true },
}

local FileType = {
    provider = function()
        return vim.bo.filetype:upper()
    end,
    hl = { fg = colors.cyan, bold = true, italic = true },
}

local Ruler = {
    provider = function()
        return string.format(" %d:%d ", unpack(vim.api.nvim_win_get_cursor(0)))
    end,
    hl = { fg = colors.fg, bold = true },
}

local StatusLine = {
    condition = function()
    -- Esconde a status bar no terminal
    return vim.bo.buftype ~= "terminal" and vim.bo.filetype ~= "NvimTree"
    end,
    Mode,
    { provider = " | ", hl = { fg = colors.gray } },
    FileName,
    { provider = " | ", hl = { fg = colors.gray } },
    FileType,
    { provider = "%=" }, -- Centraliza o restante
    Ruler,
    { provider = " | ", hl = {fg = colors.gray} },
    Diagnostics,
}

-- Configura a StatusLine
heirline.setup({
    statusline = StatusLine,
})
