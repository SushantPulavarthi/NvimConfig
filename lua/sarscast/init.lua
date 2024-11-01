require("sarscast.remap")
require("sarscast.set")
require("sarscast.lazy_init")

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/Snippets/" })

local augroup = vim.api.nvim_create_augroup
local SarscastGroup = augroup("Sarscast", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("highlightyank", {})

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

-- Remove trailing whitespace on save
autocmd({ "BufWritePre" }, {
    group = SarscastGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
--     pattern = { "*.norg" },
--     command = ":setl noai nocin nosi inde= conceallevel=3 linebreak breakindent wrap colorcolumn=0"
-- })

autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.tex" },
    command = ":setl noai nocin nosi inde= conceallevel=0 linebreak breakindent wrap colorcolumn=0"
})

autocmd("LspAttach", {
    group = SarscastGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})

local set = vim.opt_local

-- Set local settings for terminal buffers
autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("custom-term-open", {}),
    callback = function()
        set.number = false
        set.relativenumber = false
        set.scrolloff = 0

        vim.bo.filetype = "terminal"
    end,
})

-- Easily hit escape in terminal mode.
vim.keymap.set("t", "<C-c><C-c>", "<c-\\><c-n>")

-- Open a terminal at the bottom of the screen with a fixed height.
vim.keymap.set("n", "<leader>t", function()
    vim.cmd.new()
    vim.cmd.wincmd "J"
    vim.api.nvim_win_set_height(0, 12)
    vim.wo.winfixheight = true
    vim.cmd.term()
end)

vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 26
