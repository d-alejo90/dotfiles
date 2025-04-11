-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.zettelkasten")

vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.clipboard = "unnamedplus" -- allow me to paste what is in my clipboard

vim.cmd([[hi @function.builtin guifg=pink]])

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>", { desc = "Source File" })

-- Lsp Keymapping
vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
vim.keymap.set("n", "<space>ra", vim.lsp.buf.code_action, { desc = "Code action" })
vim.keymap.set("n", "<space>rr", vim.lsp.buf.references, { desc = "Find References" })
vim.keymap.set("n", "<space>ri", vim.lsp.buf.implementation, { desc = "Find Implementation" })
vim.keymap.set("n", "<space>O", vim.lsp.buf.document_symbol, { desc = "Document Symbols" })
vim.keymap.set({ "i", "n" }, "<C-a>", vim.lsp.buf.signature_help, { desc = "Signature help" })
