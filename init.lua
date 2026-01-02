--: Options
vim.g.mapleader = ' '
vim.o.backup = false
vim.o.expandtab = true
vim.o.incsearch = true
vim.o.number = true
vim.o.scrolloff = 8
vim.o.shiftwidth = 4
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.smartindent = true
vim.o.softtabstop = 4
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.updatetime = 50
vim.o.wrap = false
vim.o.hlsearch = true
vim.o.clipboard = "unnamedplus"
vim.o.undofile = true
--:

--: Basic keymaps
vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set('v', '<', '<gv', { noremap = true })

vim.keymap.set('n', 'gt', ':bn<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gT', ':bp<CR>', { noremap = true, silent = true })

vim.keymap.set('n', 'qn', ':cnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'qp', ':cprev<CR>', { noremap = true, silent = true })

vim.keymap.set('', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('', '<C-l>', '<C-w>l', { noremap = true })

vim.keymap.set('v', '<C-c>', '"+y')
vim.api.nvim_set_keymap("n", "<C-c>", [[:lua vim.fn.setreg('+', vim.fn.getline('.'))<CR>]],
	{ noremap = true, silent = true })
--:

--: nord
vim.pack.add({
	{ src = "https://github.com/shaunsingh/nord.nvim" },
})
-- sed -i 's/2E3440/07080A/g'  ~/.local/share/nvim/site/pack/core/opt/nord.nvim/lua/nord/named_colors.lua

vim.cmd([[ colorscheme nord ]])
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
--:

--: whichkey
vim.pack.add({
	{ src = "https://github.com/folke/which-key.nvim" },
})

local whichkey = require("which-key")
whichkey.add(
    {
        { "<leader>a", group = "AI" },
        { "<leader>f", group = "Files" },
        { "<leader>s", group = "Search" },
        { "<leader>l", group = "LSP" },
    }, { mode = "n" })
--:

--: treesitter
vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

require 'nvim-treesitter'.install { 'bash', 'rust', 'html', 'xml', 'json', 'yaml', 'javascript', 'c', 'cpp', 'markdown', 'markdown_inline', 'python', 'lua' }

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("EnableTreesitterHighlighting", { clear = true }),
  desc = "Try to enable tree-sitter syntax highlighting",
  pattern = "*", -- run on *all* filetypes
  callback = function()
    pcall(function() vim.treesitter.start() end)
  end,
})
--:

--: nvim-tree
vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle, { desc = "File Tree" })
require("nvim-tree").setup({
	view = {
		adaptive_size = true,
	},
	update_focused_file = {
		enable = true,
	},
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
})
--:

--: blink.cmp
vim.pack.add({
	{ src = "https://github.com/Saghen/blink.cmp", version = "v1.6.0" },
})
require("blink.cmp").setup({
	keymap = { preset = 'default' },
	appearance = {
		nerd_font_variant = 'mono'
	},
	completion = { documentation = { auto_show = true } },
	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer' },
	},
	fuzzy = { implementation = "prefer_rust" }
})
--:

--: telescope
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
})

local telescope_builtin = require('telescope.builtin')

require('telescope').setup({
	pickers = {
		buffers = {
			initial_mode = "normal",
		},
		bookmarks = {
			initial_mode = "normal",
		},
	},
})

vim.keymap.set('n', '<leader>b', telescope_builtin.buffers, { desc = 'Open Buffers' })

vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fr', telescope_builtin.oldfiles, { desc = 'Find Recent Files' })

vim.keymap.set('n', '<leader>/', telescope_builtin.live_grep, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>sf', telescope_builtin.live_grep, { desc = 'Search Files' })
--vim.keymap.set('n', '<leader>sb', ":vimgrep /<string>/ % | copen", { desc = 'Search Current Buffer' })
vim.keymap.set('n', '<leader>sq', telescope_builtin.quickfix, { desc = 'Search Quickfix' })
vim.keymap.set('n', '<leader>sk', telescope_builtin.keymaps, { desc = 'Search Keymaps' })
vim.keymap.set('n', '<leader>sh', telescope_builtin.help_tags, { desc = 'Search Help' })
vim.keymap.set('n', '<leader>sw', telescope_builtin.grep_string, { desc = 'Search Current Word In Files' })
vim.keymap.set('n', '<leader>sr', telescope_builtin.resume, { desc = 'Resume Previous Search' })

vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, { desc = "Go To Definition (LSP)", noremap = true, silent = true })
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Show Symbol Info (LSP)", noremap = true, silent = true })

vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.definition() end, { desc = "Code Actions (LSP)", noremap = true, silent = true })
vim.keymap.set("n", "<leader>ld", function() vim.lsp.buf.definition() end, { desc = "Go To Definition (LSP)", noremap = true, silent = true })
vim.keymap.set("n", "<leader>lt", function() vim.lsp.buf.type_definition() end, { desc = "Go To Type Definition (LSP)", noremap = true, silent = true })
vim.keymap.set("n", "<leader>li", function() vim.lsp.buf.implementation() end, { desc = "Go To Implementation (LSP)", noremap = true, silent = true })
vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.references() end, { desc = "Find References (LSP)", noremap = true, silent = true })
vim.keymap.set("n", "<leader>ln", function() vim.lsp.buf.rename() end, { desc = "Find References (LSP)", noremap = true, silent = true })
vim.keymap.set("n", "<leader>ls", function() vim.lsp.buf.hover() end, { desc = "Show Symbol Info (LSP)", noremap = true, silent = true })
vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, { desc = "Format (LSP)", noremap = true, silent = true })
--:

--: nvim-lspconfig
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig.git" },
})
vim.lsp.enable({"clangd", "basedpyright"})
--:

--: tiny-inline-diagnostic
vim.pack.add({
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
})
local diag = require("tiny-inline-diagnostic")
diag.setup()
--:

--: nvim-dap
vim.pack.add({
	{ src = "https://github.com/mfussenegger/nvim-dap" },
})
local dap = require("dap")
dap.defaults.fallback.auto_continue_if_many_stopped = false
dap.defaults.fallback.exception_breakpoints = {}
--:

--: CopilotChat
vim.pack.add({
    { src = "https://github.com/CopilotC-Nvim/CopilotChat.nvim" },
})
vim.cmd([[ set splitright ]])
vim.keymap.set('n', '<leader>aa', ":CopilotChatToggle<CR>", { desc = 'Copilot Chat' })
vim.keymap.set('v', '<leader>aa', function()
    require("CopilotChat").open()
end, { desc = "Copilot Chat (With Selection)" })
--:

--: diffview
vim.pack.add({
	{ src = "https://github.com/sindrets/diffview.nvim" },
})
--:

--: loghighlight
vim.pack.add({
	{ src = "https://github.com/fei6409/log-highlight.nvim" },
})
require('log-highlight').setup {
	-- The following options support either a string or a table of strings.

	-- The file extensions.
	extension = 'log',

	-- The file names or the full file paths.
	filename = {
		'messages',
	},

	-- The file path glob patterns, e.g. `.*%.lg`, `/var/log/.*`.
	-- Note: `%.` is to match a literal dot (`.`) in a pattern in Lua, but most
	-- of the time `.` and `%.` here make no observable difference.
	pattern = {
		'/var/log/.*',
		'messages%..*',
	}
}
--:

