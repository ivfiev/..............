vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.scrolloff = 5

-- spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.api.nvim_create_autocmd("FileType", {
	pattern = "cs",
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.expandtab = true
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
	end,
})

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.mouse = "a"

-- search
vim.opt.hlsearch = false
vim.ignorecase = true
vim.smartcase = true

vim.opt.clipboard = "unnamedplus" -- +clipboard
vim.opt.swapfile = false

vim.g.netrw_browse_split = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_list_hide = ""
vim.g.netrw_winsize = 25

vim.opt.statusline = "%f %y %m %r %= %l:%c %p%%"
vim.opt.confirm = true

vim.keymap.set("n", "<leader>e", ":Ex<CR>")
vim.keymap.set("n", "ZZ", "<Cmd>wqa<CR>")

vim.keymap.set({ "n", "x", "o" }, "L", "$")
vim.keymap.set({ "n", "x", "o" }, "H", "^")
vim.keymap.set({ "n", "x" }, "J", "10j")
vim.keymap.set({ "n", "x" }, "K", "10k")

vim.keymap.set({ "x" }, ">", ">gv")
vim.keymap.set({ "x" }, "<", "<gv")
vim.keymap.set({ "x" }, "<C-c>", function()
	vim.cmd('normal! "+y')
end)
vim.keymap.set({ "n", "i", "x" }, "<C-s>", "<Cmd>:w<CR><Esc>")
vim.keymap.set({ "n" }, "T", "<Cmd>bd<CR>")
vim.keymap.set({ "n" }, "<Tab>", "<Cmd>bnext<CR>")
vim.keymap.set({ "n" }, "<S-Tab>", "<Cmd>bprev<CR>")
vim.keymap.set({ "x" }, "p", '"_dP')
vim.keymap.set({ "n", "x" }, "<C-v>", "p", { remap = true })
vim.keymap.set("i", "<C-v>", "<Esc>pa", { remap = true })
vim.keymap.set("i", "<C-BS>", "<Esc>vbs")
vim.keymap.set({ "n", "i", "x" }, "<C-0>", "<C-v>")

vim.api.nvim_create_autocmd("filetype", {
	pattern = "netrw",
	desc = "Better mappings for netrw",
	callback = function()
		local bind = function(lhs, rhs)
			vim.keymap.set("n", lhs, rhs, { remap = true, buffer = true })
		end
		bind("a", "%")
		bind("l", "<CR>")
		bind("h", "<CR>")
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch", -- highlight group to use
			timeout = 150, -- highlight duration in ms
		})
	end,
})

vim.lsp.set_log_level("ERROR")

-- setup lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- is this needed anymore with branch=master?
local original = vim.lsp.util.make_position_params
vim.lsp.util.make_position_params = function(pos, encoding, ...)
	encoding = encoding or "utf-16" -- explicitly set
	return original(pos, encoding, ...)
end

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.defer_fn(function()
			local arg = vim.fn.argv(0)
			local stat = arg ~= "" and vim.loop.fs_stat(arg) or nil
			if stat and stat.type == "directory" then
				vim.cmd("Neotree buffers")
				vim.cmd("wincmd h")
				vim.cmd("wincmd h")
			end
		end, 50)
	end,
})

-- setup all the plugin shite
require("lazy").setup({
	spec = {

		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				vim.cmd([[colorscheme tokyonight-night]])
			end,
		},

		{
			"nvim-treesitter/nvim-treesitter",
			branch = "master",
			lazy = false,
			build = ":TSUpdate",
			config = function()
				require("nvim-treesitter.configs").setup({
					ensure_installed = {
						"lua",
						"python",
						"javascript",
						"html",
						"css",
						"bash",
						"c",
						"go",
						"c_sharp",
						"json",
						"yaml",
						"sql",
						"dockerfile",
						"hcl",
					},
					sync_install = false,
					auto_install = true,
					highlight = {
						enable = true,
						additional_vim_regex_highlighting = false,
					},
					indent = { enable = true },
				})
				vim.filetype.add({ extension = { yml = "yaml" } })
			end,
		},

		{
			"nvim-telescope/telescope.nvim",
			branch = "master",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				require("telescope").setup({
					defaults = {
						layout_strategy = "flex",
						layout_config = {
							prompt_position = "top",
							width = 0.999,
							height = 0.999,
						},
						sorting_strategy = "ascending",
						winblend = 0,
					},
				})
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<C-p>", builtin.find_files)
				vim.keymap.set("n", "<C-f>", builtin.live_grep)
				--vim.keymap.set("n", "t", builtin.buffers)
				vim.keymap.set("n", "<C-r>", builtin.resume)
			end,
		},

		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				local theme = require("lualine.themes.nightfly")
				theme.normal.c.bg = "#1a1b26"
				theme.inactive.c.bg = "#1a1b26"
				require("lualine").setup({
					options = {
						theme = theme,
					},
				})
			end,
		},

		{
			"akinsho/bufferline.nvim",
			enabled = false,
			version = "*",
			dependencies = "nvim-tree/nvim-web-devicons",
			config = function()
				require("bufferline").setup({
					options = {
						offsets = {
							{
								filetype = "neo-tree",
								text = "",
								--		padding = 1,
							},
						},
					},
				})
				vim.api.nvim_set_hl(0, "BufferLineFill", { bg = "#1a1b26" })
			end,
		},

		{
			"folke/noice.nvim",
			dependencies = { "MunifTanjim/nui.nvim" },
			config = function()
				require("noice").setup({
					cmdline = { enabled = true },
					lsp = {
						progress = { enabled = false },
					},
					messages = {
						enabled = true,
					},
					commands = {
						all = {
							view = "popup",
						},
					},
					views = {
						mini = {
							timeout = 5000,
						},
					},
				})
			end,
		},

		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"MunifTanjim/nui.nvim",
				"nvim-tree/nvim-web-devicons", -- optional, but recommended
			},
			lazy = false, -- neo-tree will lazily load itself
			config = function()
				require("neo-tree").setup({
					window = {
						--position = "float",
						--auto_expand_width = true,
						popup = {
							size = {
								height = "100%",
								width = "100%",
							},
							position = "50%",
						},
						mapping_options = {
							noremap = true,
							nowait = true,
						},
						mappings = {
							["l"] = "open",
							["h"] = "open",
							["<C-l>"] = "open",
							["t"] = false,
							["f"] = false,
						},
					},
					filesystem = {
						window = {
							position = "left",
						},
						follow_current_file = {
							enabled = true,
							leave_dirs_open = true,
						},
						hijack_netrw_behavior = "open_default", -- replace netrw
					},
					buffers = {
						window = {
							position = "right",
						},
						show_unloaded = true,
					},
				})
				vim.keymap.set(
					"n",
					"<C-`>",
					"<Cmd>Neotree buffers toggle<CR><Cmd>Neotree filesystem toggle<CR>",
					{ desc = "Toggle Neotree stuff" }
				)
			end,
		},

		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},

		{
			"windwp/nvim-autopairs",
			event = "InsertEnter",
			config = true,
			opts = {},
		},

		{
			"folke/flash.nvim",
			event = "VeryLazy",
			---@type Flash.Config
			opts = {
				modes = {
					char = {
						enabled = false,
					},
				},
				jump = {
					-- autojump = true,
				},
				label = {
					rainbow = {
						enabled = true,
					},
				},
			},
			keys = {
				{
					"f",
					mode = { "n", "x" },
					function()
						require("flash").remote()
					end,
				},
				{
					"t",
					mode = { "n", "x" },
					function()
						require("flash").treesitter()
					end,
				},
			},
		},

		{
			"seblyng/roslyn.nvim",
			opts = {},
		},

		{
			"neovim/nvim-lspconfig",
			dependencies = {
				-- Automatically install LSPs and related tools to stdpath for Neovim
				-- Mason must be loaded before its dependents so we need to set it up here.
				-- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
				{ "mason-org/mason.nvim", opts = {} },
				"mason-org/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				-- Useful status updates for LSP.
				{ "j-hui/fidget.nvim", opts = {} },
				-- Allows extra capabilities provided by blink.cmp
				"Saghen/blink.cmp",
			},
			config = function()
				vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
					callback = function(event)
						local map = function(keys, func, desc, mode)
							mode = mode or "n"
							vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
						end

						-- Rename the variable under your cursor.
						--  Most Language Servers support renaming across files, etc.
						map("<F2>", vim.lsp.buf.rename, "[R]e[n]ame")

						-- Execute a code action, usually your cursor needs to be on top of an error
						-- or a suggestion from your LSP for this to activate.
						map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

						local telescope = require("telescope.builtin")
						-- Find references for the word under your cursor.
						map("grr", telescope.lsp_references, "[G]oto [R]eferences")

						-- Jump to the implementation of the word under your cursor.
						--  Useful when your language has ways of declaring types without an actual implementation.
						--map("gi", require("omnisharp_extended").lsp_implementation, "[G]oto [I]mplementation")
						map("gi", telescope.lsp_implementations, "[G]oto [I]mplementation")

						-- Jump to the definition of the word under your cursor.
						--  This is where a variable was first declared, or where a function is defined, etc.
						--  To jump back, press <C-t>.
						--map("gd", require("omnisharp_extended").lsp_definition, "[G]oto [D]efinition")
						map("gd", telescope.lsp_definitions, "[G]oto [D]efinition")

						map("<C-h>", vim.lsp.buf.hover, "[H]oover", { "n", "i" })

						-- WARN: This is not Goto Definition, this is Goto Declaration.
						--  For example, in C this would take you to the header.
						--map("", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

						-- Fuzzy find all the symbols in your current document.
						--  Symbols are things like variables, functions, types, etc.
						map("gO", telescope.lsp_document_symbols, "Open Document Symbols")

						-- Fuzzy find all the symbols in your current workspace.
						--  Similar to document symbols, except searches over your entire project.
						map("gW", telescope.lsp_dynamic_workspace_symbols, "Open Workspace Symbols")

						-- Jump to the type of the word under your cursor.
						--  Useful when you're not sure what type a variable is and you want to see
						--  the definition of its *type*, not where it was *defined*.
						map("grt", telescope.lsp_type_definitions, "[G]oto [T]ype Definition")

						-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
						-- delete this shite
						---@param client vim.lsp.Client
						---@param method vim.lsp.protocol.Method
						---@param bufnr? integer some lsp support methods only in specific files
						---@return boolean
						local function client_supports_method(client, method, bufnr)
							if vim.fn.has("nvim-0.11") == 1 then
								return client:supports_method(method, bufnr)
							else
								return client.supports_method(method, { bufnr = bufnr })
							end
						end

						-- The following two autocommands are used to highlight references of the
						-- word under your cursor when your cursor rests there for a little while.
						--    See `:help CursorHold` for information about when this is executed
						--
						-- When you move your cursor, the highlights will be cleared (the second autocommand).
						local client = vim.lsp.get_client_by_id(event.data.client_id)
						if
							client
							and client_supports_method(
								client,
								vim.lsp.protocol.Methods.textDocument_documentHighlight,
								event.buf
							)
						then
							local highlight_augroup =
								vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
							--vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
							-- buffer = event.buf,
							--group = highlight_augroup,
							--callback = vim.lsp.buf.document_highlight,
							--})

							local timer = vim.loop.new_timer()
							vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
								buffer = event.buf,
								group = highlight_augroup,
								callback = function()
									vim.lsp.buf.clear_references()
									timer:stop()
									timer:start(1000, 0, function()
										vim.schedule(function()
											vim.lsp.buf.document_highlight()
											--vim.lsp.buf.hover()
										end)
									end)
								end,
							})
							--vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							--	buffer = event.buf,
							--	group = highlight_augroup,
							--	callback = vim.lsp.buf.clear_references,
							--})

							vim.api.nvim_create_autocmd("LspDetach", {
								group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
								callback = function(event2)
									vim.lsp.buf.clear_references()
									vim.api.nvim_clear_autocmds({
										group = "kickstart-lsp-highlight",
										buffer = event2.buf,
									})
								end,
							})
						end

						-- The following code creates a keymap to toggle inlay hints in your
						-- code, if the language server you are using supports them
						--
						-- This may be unwanted, since they displace some of your code
						if
							client
							and client_supports_method(
								client,
								vim.lsp.protocol.Methods.textDocument_inlayHint,
								event.buf
							)
						then
							map("<leader>th", function()
								vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
							end, "[T]oggle Inlay [H]ints")
						end
					end,
				})
				vim.diagnostic.config({
					severity_sort = true,
					float = { border = "rounded", source = "if_many" },
					underline = { severity = vim.diagnostic.severity.ERROR },
					signs = vim.g.have_nerd_font and {
						text = {
							[vim.diagnostic.severity.ERROR] = "󰅚 ",
							[vim.diagnostic.severity.WARN] = "󰀪 ",
							[vim.diagnostic.severity.INFO] = "󰋽 ",
							[vim.diagnostic.severity.HINT] = "󰌶 ",
						},
					} or {},
					virtual_text = {
						source = "if_many",
						spacing = 2,
						format = function(diagnostic)
							local diagnostic_message = {
								[vim.diagnostic.severity.ERROR] = diagnostic.message,
								[vim.diagnostic.severity.WARN] = diagnostic.message,
								[vim.diagnostic.severity.INFO] = diagnostic.message,
								[vim.diagnostic.severity.HINT] = diagnostic.message,
							}
							return diagnostic_message[diagnostic.severity]
						end,
					},
				})

				-- LSP servers and clients are able to communicate to each other what features they support.
				--  By default, Neovim doesn't support everything that is in the LSP specification.
				--  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
				--  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
				local capabilities = require("blink.cmp").get_lsp_capabilities()

				-- Enable the following language servers
				--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
				--
				--  Add any additional override configuration in the following tables. Available keys are:
				--  - cmd (table): Override the default command used to start the server
				--  - filetypes (table): Override the default list of associated filetypes for the server
				--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
				--  - settings (table): Override the default settings passed when initializing the server.
				--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
				local servers = {
					clangd = {},
					gopls = {},
					pyright = {},
					-- `:help lspconfig-all`
					lua_ls = {
						-- cmd = { ... },
						-- filetypes = { ... },
						-- capabilities = {},
						settings = {
							Lua = {
								completion = {
									callSnippet = "Replace",
								},
								-- diagnostics = { disable = { 'missing-fields' } },
							},
						},
					},
				}

				-- Ensure the servers and tools above are installed
				--
				-- To check the current status of installed tools and/or manually install
				-- other tools, you can run
				--    :Mason
				--
				-- You can press `g?` for help in this menu.
				--
				-- `mason` had to be setup earlier: to configure its options see the
				-- `dependencies` table for `nvim-lspconfig` above.
				--
				-- You can add other tools here that you want Mason to install
				-- for you, so that they are available from within Neovim.
				local ensure_installed = vim.tbl_keys(servers or {})
				vim.list_extend(ensure_installed, {
					"stylua", -- Used to format Lua code
				})
				require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

				require("mason-lspconfig").setup({
					ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
					automatic_installation = false,
					handlers = {
						function(server_name)
							local server = servers[server_name] or {}
							-- This handles overriding only values explicitly passed
							-- by the server configuration above. Useful when disabling
							-- certain features of an LSP (for example, turning off formatting for ts_ls)
							server.capabilities =
								vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
							require("lspconfig")[server_name].setup(server)
						end,
					},
				})
			end,
		},

		{ -- Autoformat
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			keys = {
				{
					"<leader>f",
					function()
						require("conform").format({ async = true, lsp_format = "fallback" })
					end,
					mode = "",
					desc = "[F]ormat buffer",
				},
			},
			opts = {
				notify_on_error = false,
				format_on_save = function(bufnr)
					-- Disable "format_on_save lsp_fallback" for languages that don't
					-- have a well standardized coding style. You can add additional
					-- languages here or re-enable it for the disabled ones.
					local disable_filetypes = { c = true, cpp = true }
					if disable_filetypes[vim.bo[bufnr].filetype] then
						return nil
					else
						return {
							timeout_ms = 500,
							lsp_format = "fallback",
						}
					end
				end,

				formatters_by_ft = {
					lua = { "stylua" },
					-- Conform can also run multiple formatters sequentially
					-- python = { "isort", "black" },
					--
					-- You can use 'stop_after_first' to run the first available formatter from the list
					-- javascript = { "prettierd", "prettier", stop_after_first = true },
				},
			},
		},

		{ -- Autocompletion
			"Saghen/blink.cmp",
			event = "VimEnter",
			version = "1.*",
			dependencies = {
				"folke/lazydev.nvim",
			},
			--- @module 'blink.cmp'
			--- @type blink.cmp.Config
			opts = {
				keymap = {
					["<C-l>"] = { "accept", "fallback" },
					["<CR>"] = { "accept", "fallback" },
					["<Tab>"] = { "accept", "fallback" },
					["<S-Tab>"] = nil,
					-- 'default' (recommended) for mappings similar to built-in completions
					--   <c-y> to accept ([y]es) the completion.
					--    This will auto-import if your LSP supports it.
					--    This will expand snippets if the LSP sent a snippet.
					-- 'super-tab' for tab to accept
					-- 'enter' for enter to accept
					-- 'none' for no mappings
					--
					-- For an understanding of why the 'default' preset is recommended,
					-- you will need to read `:help ins-completion`
					--
					-- No, but seriously. Please read `:help ins-completion`, it is really good!
					--
					-- All presets have the following mappings:
					-- <tab>/<s-tab>: move to right/left of your snippet expansion
					-- <c-space>: Open menu or open docs if already open
					-- <c-n>/<c-p> or <up>/<down>: Select next/previous item
					-- <c-e>: Hide menu
					-- <c-k>: Toggle signature help
					--
					-- See :h blink-cmp-config-keymap for defining your own keymap
					preset = "default",
				},

				appearance = {
					-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
					-- Adjusts spacing to ensure icons are aligned
					nerd_font_variant = "mono",
				},

				completion = {
					-- By default, you may press `<c-space>` to show the documentation.
					-- Optionally, set `auto_show = true` to show the documentation after a delay.
					documentation = { auto_show = true, auto_show_delay_ms = 2000 },
				},

				sources = {
					default = { "lsp", "path", "snippets", "lazydev", "buffer" },
					providers = {
						lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
					},
				},

				--snippets = { preset = "luasnip" },
				--

				-- Blink.cmp includes an optional, recommended rust fuzzy matcher,
				-- which automatically downloads a prebuilt binary when enabled.
				--
				-- By default, we use the Lua implementation instead, but you may enable
				-- the rust implementation via `'prefer_rust_with_warning'`
				--
				-- See :h blink-cmp-config-fuzzy for more information
				fuzzy = { implementation = "prefer_rust_with_warning" },

				-- Shows a signature help window while you type arguments for a function
				signature = { enabled = true },
			},
		},
	},
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
