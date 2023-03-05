local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = false }
local expr_opts = { noremap = true, expr = true, silent = true }


keymap("n", "<leader>n", ":set number!<CR>", default_opts)
keymap("n", "<leader>x", ":q!<CR>", default_opts)
keymap("n", "<leader>w", ":w!<CR>", default_opts)
keymap("n", "<leader>wx", ":wq!<CR>", default_opts)
keymap("n", "<leader>i", ":IndentBlanklineToggle<CR>", default_opts)


keymap("v", "J", ":m '>+1<CR>gv=gv", default_opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", default_opts)
--test2
