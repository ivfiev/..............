vim.g.mapleader = ","
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.keymap.set("i", "qq", "<Esc>")

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.winborder = "single"

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

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.mouse = "a"

vim.opt.hlsearch = false
vim.ignorecase = true
vim.smartcase = true

vim.opt.clipboard = "unnamedplus" -- +clipboard
vim.opt.swapfile = false
vim.opt.report = 9999

vim.g.netrw_browse_split = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_list_hide = ""
vim.g.netrw_winsize = 25

vim.opt.statusline = "%f %y %m %r %= %l:%c %p%%"
vim.opt.confirm = true

vim.keymap.set({ "n", "x", "o" }, "L", "$")
vim.keymap.set({ "n", "x", "o" }, "H", "^")
vim.keymap.set({ "n", "x" }, "J", "10j")
vim.keymap.set({ "n", "x" }, "K", "10k")
vim.keymap.set("n", "ZZ", "<Cmd>wqa<CR>")
vim.keymap.set({ "x" }, ">", ">gv")
vim.keymap.set({ "x" }, "<", "<gv")

vim.keymap.set("n", "<leader>bp", ":bprev<CR>", { silent = true })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { silent = true })

vim.keymap.set({ "n", "i", "x" }, "<C-s>", "<Cmd>:w<CR><Esc>", { silent = true })
vim.keymap.set({ "n", "i", "x" }, "<C-a>", "<Esc>ggVG")
vim.keymap.set("i", "<C-v>", "<Esc>Pa", { remap = true })
vim.keymap.set({ "x" }, "<C-c>", function()
	vim.cmd('normal! "+y')
end)
vim.keymap.set({ "x" }, "p", '"_dp')
vim.keymap.set({ "x" }, "P", '"_dP')

vim.keymap.set({ "n", "i", "x" }, "<C-0>", "<C-v>")
vim.keymap.set({ "n", "i" }, "<X1Mouse>", "<C-o>")
vim.keymap.set({ "n", "i" }, "<X2Mouse>", "<C-i>")
vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set("n", "<C-r>", "U") -- C-restore
vim.keymap.set("i", "<C-BS>", "<Esc>vbs")

vim.api.nvim_set_hl(0, "OnYankHighlight", { bg = "#FF4400" })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "OnYankHighlight",
			timeout = 150,
		})
	end,
})

-- shadas & sessions
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local arg = vim.fn.argv(0)
		if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
			-- force correct cwd if directory passed in
			vim.cmd("cd " .. arg)
			-- per-project shadas
			local workspace_path = vim.fn.getcwd()
			local cache_dir = vim.fn.stdpath("state")
			local unique_id = vim.fn.fnamemodify(workspace_path, ":t") .. "_" .. vim.fn.sha256(workspace_path):sub(1, 8)
			local shadafile = cache_dir .. "/shada/" .. unique_id .. ".shada"
			vim.opt.shadafile = shadafile
			pcall(vim.cmd.rshada)
			-- restore sesh
			vim.schedule(function()
				vim.cmd("AutoSession restore")
			end)
		end
	end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		vim.cmd("AutoSession save")
	end,
})

-- marks
vim.keymap.set("n", "M", function()
	local mark = vim.fn.getcharstr()
	vim.cmd("normal! m" .. string.upper(mark))
end)
vim.keymap.set("n", "'", function()
	local mark = vim.fn.getcharstr()
	vim.cmd("normal! '" .. string.upper(mark))
	vim.cmd("normal! g'\"")
end)
vim.keymap.set("n", "MM", function()
	local mark = vim.fn.getcharstr()
	vim.cmd("normal! m" .. string.lower(mark))
end)
vim.keymap.set("n", "''", function()
	local mark = vim.fn.getcharstr()
	vim.cmd("normal! '" .. string.lower(mark))
end)

-- highlighting
vim.keymap.set("n", "*", function()
	vim.opt.hlsearch = not vim.opt.hlsearch:get()
end)
vim.keymap.set("x", "*", function()
	vim.cmd("normal! y") -- v -> "
	local s = vim.fn.getreg('"')
	if s == nil or s == "" then
		return
	end
	s = s:gsub("[\r\n]+$", "") -- drop trailine whitespace
	local pat = "\\V\\C" .. vim.fn.escape(s, "\\/") -- v-nomagic + case-sensitive
	vim.opt.hlsearch = true
	vim.fn.setreg("/", pat)
end, { noremap = true, silent = true })

-- terminal
vim.keymap.set("n", "<leader>t", ":terminal<CR>", { silent = true })
vim.keymap.set("t", "<S-Esc>", [[<C-\><C-n>]], { silent = true })
vim.keymap.set("t", "<C-o>", [[<C-\><C-n>:b#<Cr>]], { silent = true })
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
	pattern = "*",
	callback = function()
		if vim.opt.buftype:get() == "terminal" then
			vim.cmd("startinsert")
		end
	end,
})

-- git blame
vim.keymap.set("n", "<leader>gb", function()
	local file_path = vim.fn.expand("%:p")
	local file_name = vim.fn.expand("%:t")
	local line_num = vim.fn.line(".")
	local cmd = { "git", "blame", "--line-porcelain", "-L", line_num .. "," .. line_num, "--", file_path }
	local result = vim.fn.systemlist(cmd)
	if vim.v.shell_error ~= 0 or #result == 0 then
		vim.notify("No one to blame...", vim.log.levels.INFO)
		return
	end
	local author, time, summary
	for _, line in ipairs(result) do
		if line:match("^author ") then
			author = line:gsub("^author ", "")
		elseif line:match("^author%-time ") then
			time = os.date("%Y-%m-%d", tonumber(line:gsub("^author%-time ", ""), 10))
		elseif line:match("^summary ") then
			summary = line:gsub("^summary ", "")
		end
	end
	local msg =
		string.format("%s:%s - [%s] @ [%s] -> [%s]  ", file_name, line_num, author or "?", time or "?", summary or "?")
	vim.notify(msg, vim.log.levels.INFO, { title = "blame " }) -- TODO maybe virt text
end)

vim.lsp.set_log_level("ERROR")

function send_key(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, false, true), mode, true)
end

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

-- setup all the plugin shite
require("lazy").setup({

	ui = { border = "rounded" },

	spec = {

		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				BG = "#070407"
				vim.g.BG = BG
				require("tokyonight").setup({
					on_colors = function(c)
						c.bg = BG
						c.bg_dark1 = BG
						c.bg_dark = BG
						c.bg_float = BG
						c.bg_sidebar = BG
						c.bg_popup = BG
						c.bg_highlight = BG
					end,
					on_highlights = function(hl, c)
						hl.CursorLine = { bg = "#001122" }
						hl.Visual = { bg = "#661166" }
						hl.Search = { bg = hl.Visual.bg }
						hl.IncSearch = { bg = hl.Visual.bg }
						hl.DiagnosticVirtualTextError = { bg = "NONE", fg = hl.DiagnosticVirtualTextError.fg }
						hl.DiagnosticVirtualTextWarn = { bg = "NONE", fg = hl.DiagnosticVirtualTextWarn.fg }
						hl.DiagnosticVirtualTextInfo = { bg = "NONE", fg = hl.DiagnosticVirtualTextInfo.fg }
						hl.DiagnosticVirtualTextHint = { bg = "NONE", fg = hl.DiagnosticVirtualTextHint.fg }
						hl.LspInlayHint = { bg = "NONE", fg = hl.LspInlayHint.fg }
						hl.BlinkCmpMenuSelection = { bg = "#002244" }
						hl.NeoTreeCursorLine = { bg = "#002244" }
						hl.TelescopeSelection = { bg = "#002244" }
						hl.FlashCurrent = { bg = "#006666", fg = "#111111", bold = false }
						hl.FlashMatch = { bg = "#006666", fg = "#111111", bold = false }
						hl.FlashLabel = { bg = "#880088", fg = "#FAFAFA", bold = true }
					end,
				})
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
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope-ui-select.nvim",
			},
			config = function()
				local builtin = require("telescope.builtin")
				local actions = require("telescope.actions")
				local telescope = require("telescope")

				telescope.setup({
					defaults = {
						mappings = {
							i = {
								["<Esc>"] = actions.close,
							},
						},
						path_display = { "truncate" },
						layout_strategy = "flex",
						layout_config = {
							prompt_position = "top",
							width = 0.999,
							height = 0.999,
						},
						sorting_strategy = "ascending",
						winblend = 0,
					},
					pickers = {
						find_files = {
							hidden = true,
							find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
						},
						live_grep = {
							additional_args = function(_)
								return { "--hidden", "--glob", "!.git/" }
							end,
						},
					},
					extensions = {
						["ui-select"] = {
							require("telescope.themes").get_cursor({
								winblend = 10,
								previewer = false,
								layout_config = {
									width = 0.5,
									height = 0.4,
									prompt_position = "top",
								},
								border = true,
							}),
						},
					},
				})
				telescope.load_extension("ui-select")

				vim.keymap.set("n", "gf", builtin.find_files)
				vim.keymap.set("n", "gF", builtin.live_grep) -- regex
				vim.keymap.set("x", "gF", function()
					vim.cmd('normal! "zy')
					local text = vim.fn.getreg("z")
					text = text:gsub("[\r\n]+$", "")
					builtin.grep_string({ default_text = text }) -- literal str
				end, { silent = true })

				vim.keymap.set("n", "gs", builtin.lsp_dynamic_workspace_symbols)

				-- gb snipe
				vim.keymap.set("n", "gB", function()
					builtin.buffers()
				end)

				vim.keymap.set("n", "gm", builtin.marks)

				vim.keymap.set("n", "g<BS>", builtin.resume)
			end,
		},

		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				local theme = require("lualine.themes.tokyonight")
				theme.normal.c.bg = vim.g.BG
				theme.inactive.c.bg = vim.g.BG
				vim.api.nvim_set_hl(
					0,
					"LualineFilenameUnderline",
					{ underline = true, fg = theme.normal.c.fg, bg = theme.normal.c.bg }
				)
				require("lualine").setup({
					options = {
						theme = theme,
						section_separators = "",
						component_separators = "",
					},
					sections = {
						lualine_a = {},
						lualine_b = {},
						lualine_c = {},
						lualine_x = {
							"diagnostics",
							--"lsp_status",
							--"encoding",
							--"fileformat",
							--"progress",
							--"location",
							"branch",
							{
								"filename",
								path = 1,
								symbols = { modified = "", readonly = "[Read-only]" },
								fmt = function(str)
									if vim.bo.modified then
										return "%#LualineFilenameUnderline#" .. str:sub(1, -2) .. "%*"
									else
										return str
									end
								end,
							},
							{ "filetype", icon_only = true },
						},
						lualine_y = {},
						lualine_z = {},
					},
					inactive_sections = {
						lualine_a = {},
						lualine_b = {},
						lualine_c = {},
						lualine_x = { "filename" },
						lualine_y = {},
						lualine_z = {},
					},
				})
			end,
		},

		{
			"folke/noice.nvim",
			dependencies = { "MunifTanjim/nui.nvim" },
			config = function()
				require("noice").setup({
					presets = {
						lsp_doc_border = true,
					},
					cmdline = { enabled = true },
					lsp = {
						progress = { enabled = false },
						hover = { enabled = false },
						signature = { enabled = false },
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
							timeout = 10000,
						},
					},
				})
			end,
		},

		{
			"rmagatti/auto-session",
			config = function()
				require("auto-session").setup({
					suppressed_dirs = { "~/", "~/Downloads", "/" },
					auto_save = false,
					auto_restore = false,
					auto_create = false,
				})
				vim.o.sessionoptions = "buffers,curdir" --vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
				--vim.cmd("b#")
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
							["m"] = false, --flash
							["M"] = "move",
						},
					},
					filesystem = {
						window = {
							position = "float",
						},
						follow_current_file = {
							enabled = true,
							leave_dirs_open = true,
						},
						hijack_netrw_behavior = "disabled", -- replace netrw
						filtered_items = {
							hide_dotfiles = false,
							hide_gitignored = false,
							hide_by_name = {
								".git",
							},
						},
					},
				})
				vim.keymap.set({ "n" }, "<leader>fs", "<Cmd>Neotree filesystem reveal<CR>", { silent = true })
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
			"numToStr/Comment.nvim",
			event = "VeryLazy",
			opts = {
				toggler = {
					line = "gc",
				},
				mappings = {
					basic = false,
					extra = false,
				},
			},
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
						enabled = false,
						shade = 4,
					},
				},
			},
			keys = {
				{
					"m",
					mode = { "n", "x" },
					function()
						require("flash").remote()
						--require("flash").treesitter()
					end,
				},
			},
		},

		{
			"leath-dub/snipe.nvim",
			event = "VeryLazy",
			keys = {
				{
					"gb",
					function()
						require("snipe").open_buffer_menu()
					end,
					desc = "Open Snipe buffer menu",
				},
			},
			opts = {
				ui = {
					position = "center",
					persist_tags = false, -- did he fix it?
					preselect_current = true,
					open_win_override = {
						title = "",
					},
				},
				hints = {
					dictionary = "abcdefghilmnopqrstuvwxyz",
				},
				sort = "last",
			},
		},

		{
			"lukas-reineke/indent-blankline.nvim",
			main = "ibl",
			config = function()
				local highlight = {
					"c3",
				}
				local hooks = require("ibl.hooks")
				hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
					vim.api.nvim_set_hl(0, "c3", { fg = "#243648" })
				end)
				require("ibl").setup({
					indent = {
						highlight = highlight,
						char = "┆",
					},
					scope = {
						enabled = false,
					},
				})
			end,
		},

		{
			"seblyng/roslyn.nvim",
			opts = {},
			ft = { "cs" }, -- work machine - load eager
		},

		{
			"lewis6991/hover.nvim",
			event = "VeryLazy",
			config = function()
				require("hover").config({
					providers = {
						"hover.providers.lsp",
						"hover.providers.diagnostic",
					},
					mouse_providers = {},
				})
				vim.keymap.set("n", "gh", function()
					require("hover").open()
				end, { desc = "hover.nvim (open)" })
			end,
		},

		{
			"neovim/nvim-lspconfig",
			dependencies = {
				{ "mason-org/mason.nvim", opts = {} },
				"mason-org/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				{ "j-hui/fidget.nvim", opts = {} },
				"Saghen/blink.cmp",
			},
			config = function()
				vim.api.nvim_create_autocmd("LspAttach", {
					callback = function(event)
						local map = function(keys, func, desc, mode)
							mode = mode or "n"
							vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
						end

						map("gn", vim.lsp.buf.rename, "[R]e[n]ame")
						map("ga", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

						local telescope = require("telescope.builtin")
						map("gr", telescope.lsp_references, "[G]oto [R]eferences")
						map("gi", telescope.lsp_implementations, "[G]oto [I]mplementation")
						map("gd", telescope.lsp_definitions, "[G]oto [D]efinition")
						map("ge", telescope.diagnostics, "[G]oto [E]rror")

						map("gIH", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "n")

						-- Fuzzy find all the symbols in your current document.
						map("gDs", telescope.lsp_document_symbols, "Open Document Symbols")
						-- Fuzzy find all the symbols in your current workspace.
						map("gws", telescope.lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
						-- Jump to the type of the word under your cursor.
						map("gtd", telescope.lsp_type_definitions, "[G]oto [T]ype Definition")
					end,
				})
				-- drop conflicting maps
				vim.keymap.del("n", "grn")
				vim.keymap.del("n", "gra")
				vim.keymap.del("n", "grr")
				vim.keymap.del("n", "gri")
				vim.keymap.del("n", "grt")
				vim.keymap.del("x", "gra")

				vim.diagnostic.config({
					severity_sort = true,
					float = { border = "rounded", source = "if_many" },
					underline = true,
					signs = {
						text = {
							[vim.diagnostic.severity.ERROR] = "󰅚 ",
							[vim.diagnostic.severity.WARN] = "󰀪 ",
							[vim.diagnostic.severity.INFO] = "󰋽 ",
							[vim.diagnostic.severity.HINT] = "󰌶 ",
						},
					},
					virtual_text = {
						current_line = true,
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

				local capabilities = require("blink.cmp").get_lsp_capabilities()

				vim.lsp.config("clangd", { capabilities = capabilities })
				vim.lsp.config("rust_analyzer", {
					capabilities = capabilities,
					settings = {
						["rust-analyzer"] = {
							cargo = { all_features = true },
							checkOnSave = { command = "clippy" },
						},
					},
					on_attach = function(_, _)
						vim.defer_fn(function()
							vim.lsp.handlers["$/progress"] = function() end
						end, 10000)
					end,
				})
				vim.lsp.config("pyright", { capabilities = capabilities })
				vim.lsp.config("gopls", {
					capabilities = capabilities,
					settings = {
						gopls = {
							staticcheck = true,
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
					on_attach = function(client, _)
						-- disable gopls formatting
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end,
				})
				vim.lsp.config("roslyn", {
					capabilities = capabilities,
					cmd = {
						"dotnet",
						"/home/fi/dev/roslyn/artifacts/bin/Microsoft.CodeAnalysis.LanguageServer/Release/net9.0/Microsoft.CodeAnalysis.LanguageServer.dll",
						"--logLevel=Error",
						"--extensionLogDirectory=/tmp/roslyn",
						"--stdio",
					},
					settings = {
						["csharp|background_analysis"] = {
							dotnet_analyzer_diagnostics_scope = "openFiles",
							dotnet_compiler_diagnostics_scope = "openFiles",
						},
						["csharp|symbol_search"] = {
							dotnet_search_reference_assemblies = true,
						},
						["csharp|completion"] = {
							dotnet_show_name_completion_suggestions = true,
							dotnet_show_completion_items_from_unimported_namespaces = true,
							dotnet_provide_regex_completions = true,
						},
						["csharp|code_lens"] = {
							dotnet_enable_references_code_lens = false,
						},
					},
				})

				-- :Mason
				-- require("mason-tool-installer").setup({ ensure_installed = { ... }})
				require("mason-lspconfig").setup({})
				require("mason").setup({ ui = { border = "rounded" } })
			end,
		},

		{
			"stevearc/conform.nvim",
			event = "VeryLazy",
			keys = {
				{
					"<leader>=",
					function()
						require("conform").format({ async = true, lsp_format = "fallback" })
						send_key("<Esc>", "n")
					end,
					mode = "",
					desc = "[F]ormat buffer",
				},
			},
			opts = {
				async = true,
				notify_on_error = false,
				format_on_save = function(bufnr)
					local disable_filetypes = { c = true, cpp = true, cs = true } -- .editorconfig
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
					go = { "goimports", "gofumpt" },
				},
				formatters = {
					gofumpt = {
						args = { "-extra" },
					},
				},
			},
		},

		{
			"L3MON4D3/LuaSnip",
			--dependencies = { "rafamadriz/friendly-snippets" },
			config = function()
				local ls = require("luasnip")
				local s = ls.snippet
				local t = ls.text_node
				local i = ls.insert_node
				local f = ls.function_node
				local events = require("luasnip.util.events")

				local function namespace_from_path()
					local filepath = vim.fn.expand("%:p:h")
					local root = vim.fn.getcwd()
					local relpath = filepath:gsub("^" .. vim.pesc(root) .. "/", "")
					return relpath:gsub("/", ".")
				end
				local function filename()
					return vim.fn.expand("%:t:r")
				end
				local n = {
					callbacks = {
						[-1] = {
							[events.leave] = function()
								send_key("<Esc>", "i")
							end,
						},
					},
				}

				ls.add_snippets("cs", {
					s("initfile", {
						t("namespace "),
						f(namespace_from_path, {}),
						t({ ";", "", "" }),
						t("public interface I"),
						f(filename, {}),
						t({ "", "{", "\t" }),
						i(0),
						t({ "", "}", "", "" }),
						t("public class "),
						f(filename, {}),
						t({ " : I" }),
						f(filename, {}),
						t({ "", "{", "\t", "}" }),
					}, n),
				})

				ls.add_snippets("go", {
					s("iferr", {
						t({ "if err != nil {", "" }),
						t("\t"),
						t("return e"),
						i(0),
						t("rr"),
						t({ "", "}" }),
					}, n),
				})
			end,
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
					["<CR>"] = { "accept", "fallback" },
					["<Tab>"] = { "snippet_forward", "fallback" },
					["<S-Tab>"] = { "snippet_backward", "fallback" },
					-- :h ins-completion :h blink-cmp-config-keymap
					preset = "default",
				},
				appearance = {
					nerd_font_variant = "mono",
				},
				completion = {
					-- `<c-space>` to show the documentation.
					-- `auto_show = true` to show the documentation after a delay.
					documentation = { auto_show = true, auto_show_delay_ms = 100 },
					list = {
						selection = {
							preselect = false,
							auto_insert = true,
						},
					},
				},
				sources = {
					default = { "lsp", "path", "snippets", "lazydev", "buffer" },
					providers = {
						lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
					},
				},
				snippets = {
					preset = "luasnip",
				},
				-- :h blink-cmp-config-fuzzy
				fuzzy = { implementation = "prefer_rust_with_warning" },
				-- func signatures
				signature = { enabled = true },
				cmdline = {
					keymap = { preset = "inherit" },
					completion = {
						menu = { auto_show = true },
						list = { selection = { preselect = false, auto_insert = true } },
					},
				},
			},
		},
	},

	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
