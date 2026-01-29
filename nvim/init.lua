vim.g.mapleader = ","
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.keymap.set({ "n", "x" }, ",,", ",")

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.cmdheight = 0
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.winborder = "single"
vim.opt.shortmess:append("I")
vim.opt.showtabline = 0
vim.opt.laststatus = 3
vim.opt.sessionoptions = "buffers,folds,tabpages" -- options(!), curdir, tabpages

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
		vim.cmd("compiler dotnet")
		vim.g.dotnet_errors_only = true
		vim.g.dotnet_show_project_file = false
	end,
})

vim.keymap.set({ "n", "x" }, "q", "<Nop>")
vim.keymap.set("n", "<leader>q", "q") -- @ in v already works
vim.keymap.set("n", "qi", "gi")
vim.keymap.set("n", "qv", "gv")
vim.keymap.set("n", "qg", ":g//norm! 0/<Left><Left><Left><Left><Left><Left><Left><Left><Left>", { silent = false })
vim.keymap.set(
	"n",
	"qr",
	":%s///g | update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>",
	{ silent = false }
)
vim.keymap.set(
	"x",
	"qr",
	":s/// | update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>",
	{ silent = false }
)
vim.keymap.set(
	"n",
	"qR",
	":cdo s///c | update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>",
	{ silent = false }
)
vim.keymap.set("n", "qd", ':cdo execute "norm! "<Left>', { silent = false }) --  <Esc>, C-v + Esc, etc
vim.keymap.set({ "n", "x" }, "<leader>jq", ':%! jq ""<Left>', { silent = false })
vim.keymap.set("x", "qs", function()
	local open = vim.fn.getcharstr()
	local close = vim.fn.getcharstr()
	vim.cmd('norm! "zy')
	local sel = vim.fn.getreg("z"):gsub("\n$", "")
	if sel == nil or sel == "" then
		return
	end
	local surrounded = open .. sel .. close
	vim.fn.setreg("z", surrounded)
	vim.cmd('norm! gv"zP`<lv`>ho')
end, { silent = true })

vim.keymap.set("n", "Q", function()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].buftype == "quickfix" then
			vim.cmd("cclose")
			return
		end
	end
	vim.cmd("copen")
end, { silent = true })

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.wrap = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes:1"
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
vim.keymap.set("n", "ZZ", "<Cmd>wqa<CR>", { silent = true })
vim.keymap.set({ "x" }, ">", ">gv")
vim.keymap.set({ "x" }, "<", "<gv")

vim.keymap.set({ "n", "i", "x" }, "<C-s>", "<Cmd>w<CR><Esc>", { silent = true })
vim.keymap.set({ "n", "x" }, "<C-p>", [["0p]])
vim.keymap.set({ "i" }, "<C-p>", [[<Esc>"0pa]])
vim.keymap.set({ "n", "x" }, "<C-S-p>", [["0P]])
vim.keymap.set({ "i" }, "<C-S-p>", [[<Esc>"0Pa]])

vim.keymap.set({ "n", "i" }, "<X1Mouse>", "<C-o>")
vim.keymap.set({ "n", "i" }, "<X2Mouse>", "<C-i>")

vim.keymap.set({ "n", "x" }, "{", "<Cmd>keepjumps norm! {<CR>", { silent = true })
vim.keymap.set({ "n", "x" }, "}", "<Cmd>keepjumps norm! }<CR>", { silent = true })

vim.keymap.set({ "n", "x" }, "]t", "gt")
vim.keymap.set({ "n", "x" }, "[t", "gT")
vim.api.nvim_create_autocmd("TabLeave", {
	callback = function()
		vim.g.last_tab = vim.api.nvim_get_current_tabpage()
	end,
})
vim.keymap.set({ "i", "n", "x", "t" }, "<S-Tab>", function()
	if vim.g.last_tab and vim.api.nvim_tabpage_is_valid(vim.g.last_tab) then
		vim.api.nvim_set_current_tabpage(vim.g.last_tab)
	end
end)
vim.keymap.set({ "n", "x" }, "<leader><Tab>", ":tab split<CR>", { silent = true })
vim.keymap.set("n", "U", "<C-r>") -- redo
vim.keymap.set("n", "<C-r>", "U") -- C-restore
vim.keymap.set("i", "<C-BS>", "<C-w>")
vim.keymap.set("i", "<C-w>", "<C-o><C-w>")

vim.keymap.set("n", "<C-a>", "<C-^>")
vim.keymap.set("i", "<C-a>", "<C-o><C-^>")
vim.keymap.set("t", "<C-a>", [[<C-\><C-n><C-^>]])

vim.keymap.set({ "x", "n" }, "<C-u>", "<C-u>zz")
vim.keymap.set({ "x", "n" }, "<C-d>", "<C-d>zz")
vim.keymap.set("n", "zz", "mz0zz`z")

-- random autocmds
vim.api.nvim_set_hl(0, "OnYankHighlight", { bg = "#FF4400" })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "OnYankHighlight",
			timeout = 150,
		})
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})
vim.api.nvim_create_autocmd("RecordingEnter", {
	callback = function()
		local reg = vim.fn.reg_recording()
		if reg ~= "" then
			vim.notify("Recording @ '" .. reg .. "'", vim.log.levels.INFO, { Title = "Macro" })
		end
	end,
})
vim.api.nvim_create_autocmd("RecordingLeave", {
	callback = function()
		local reg = vim.fn.reg_recording()
		vim.notify("Recorded @ '" .. reg .. "'", vim.log.levels.INFO, { Title = "Macro" })
	end,
})

-- shadas & sessions
vim.api.nvim_create_user_command("SessionSave", function()
	local dir = vim.fn.getcwd():gsub("/", "%%")
	local path = vim.fn.stdpath("data") .. "/sessions/" .. dir .. ".vim"
	vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
	vim.cmd("mksession! " .. vim.fn.fnameescape(path))
end, {})
vim.api.nvim_create_user_command("SessionLoad", function()
	local dir = vim.fn.getcwd():gsub("/", "%%")
	local path = vim.fn.stdpath("data") .. "/sessions/" .. dir .. ".vim"
	if vim.fn.filereadable(path) == 1 then
		vim.cmd("source " .. vim.fn.fnameescape(path))
	end
end, {})

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
				vim.cmd("SessionLoad")
				vim.g.is_directory_session = true
				-- kill garbage bufs
				vim.defer_fn(function()
					local bufs = vim.api.nvim_list_bufs()
					for _, buf in ipairs(bufs) do
						local bufname = vim.api.nvim_buf_get_name(buf)
						if vim.bo[buf].buftype ~= "" or vim.fn.filereadable(bufname) == 0 then
							vim.api.nvim_buf_delete(buf, { force = true })
						end
					end
				end, 20)
			end)
		elseif arg ~= "" then
			vim.schedule(function()
				pcall(vim.cmd, [[norm! g`"]])
			end)
		end
	end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		if vim.g.is_directory_session then
			vim.cmd("SessionSave")
		end
	end,
})

-- marks
vim.keymap.set("n", "M", "m")
vim.keymap.set("n", "'", function()
	local mark = vim.fn.getcharstr()
	if tonumber(mark) ~= nil then
		vim.cmd("normal! " .. mark .. "gt")
	else
		vim.cmd("normal! '" .. mark)
		if string.upper(mark) == mark then
			vim.cmd([[norm! g`"]])
		end
	end
end)

-- highlighting
vim.keymap.set("n", "*", function()
	if vim.opt.hlsearch:get() then
		vim.opt.hlsearch = false
	else
		vim.cmd('normal! "zyiw')
		local s = vim.fn.getreg("z")
		if s == nil or s == "" then
			return
		end
		s = s:gsub("[\r\n]+$", "") -- drop trailing whitespace
		local pat = "\\V\\C" .. vim.fn.escape(s, "\\/") -- v-nomagic + case-sensitive
		vim.opt.hlsearch = true
		vim.fn.setreg("/", pat)
	end
end)
vim.keymap.set("x", "*", function()
	vim.cmd('normal! "zy')
	local s = vim.fn.getreg("z")
	if s == nil or s == "" then
		return
	end
	s = s:gsub("[\r\n]+$", "") -- drop trailing whitespace
	local pat = "\\V\\C" .. vim.fn.escape(s, "\\/") -- v-nomagic + case-sensitive
	vim.opt.hlsearch = true
	vim.fn.setreg("/", pat)
end, { noremap = true, silent = true })
vim.keymap.set("x", "/", function()
	vim.cmd('normal! "zy')
	local s = vim.fn.getreg("z")
	if s == nil or s == "" then
		return
	end
	s = s:gsub("[\r\n]+$", "") -- drop trailing whitespace
	send_key("/" .. s, "n")
end)

-- terminal
vim.g.last_term = -1
vim.keymap.set("n", "<leader>T", ":terminal<CR>", { silent = true })
vim.keymap.set("n", "<leader>t", function()
	if vim.api.nvim_buf_is_valid(vim.g.last_term) then
		vim.api.nvim_set_current_buf(vim.g.last_term)
	else
		vim.cmd("terminal", { silent = true })
	end
end, { silent = true })
vim.keymap.set("t", "<S-Esc>", [[<C-\><C-n>]], { silent = true })
vim.keymap.set("t", "<C-o>", [[<C-\><C-n>:b#<Cr>]], { silent = true })
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter", "TabEnter", "WinResized" }, {
	pattern = "*",
	callback = function()
		vim.schedule(function()
			if vim.opt.buftype:get() == "terminal" then
				vim.g.last_term = vim.api.nvim_get_current_buf()
				vim.cmd("startinsert")
			end
		end)
	end,
})
vim.keymap.set({ "i", "n" }, "<C-/>", function()
	local ws = vim.api.nvim_tabpage_list_wins(vim.api.nvim_get_current_tabpage())
	local term = nil
	for _, w in ipairs(ws) do
		if vim.bo[vim.api.nvim_win_get_buf(w)].buftype == "terminal" then
			term = w
			break
		end
	end
	if not term then
		local cols = vim.g.terminal_cols or vim.o.columns / 2.5
		local rows = vim.g.terminal_rows or vim.o.lines / 2.5
		local orientation = cols < vim.o.columns / 1.25 and "v" or ""
		local size = orientation == "v" and cols or rows
		vim.cmd(string.format("silent! %d%ssplit", size, orientation))
		if vim.api.nvim_buf_is_valid(vim.g.last_term) then
			vim.api.nvim_set_current_buf(vim.g.last_term)
		else
			vim.cmd("terminal")
		end
	else
		vim.g.terminal_cols = vim.api.nvim_win_get_width(term)
		vim.g.terminal_rows = vim.api.nvim_win_get_height(term)
		vim.api.nvim_win_close(term, true)
	end
end)
vim.keymap.set("t", "<C-/>", function()
	local ws = vim.api.nvim_tabpage_list_wins(vim.api.nvim_get_current_tabpage())
	if #ws > 1 then
		vim.g.terminal_cols = vim.api.nvim_win_get_width(0)
		vim.g.terminal_rows = vim.api.nvim_win_get_height(0)
		vim.cmd("close")
	end
end)
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]])
vim.keymap.set({ "t", "n" }, "<C-w>z", function()
	local r = tonumber(vim.fn.getcharstr())
	if r and 1 <= r and r <= 9 then
		local is_vertical = vim.api.nvim_win_get_width(0) < vim.o.columns - 3
		if is_vertical then
			vim.cmd(string.format("vertical resize %d", r / 10.0 * vim.o.columns))
		else
			vim.cmd(string.format("resize %d", r / 10.0 * vim.o.lines))
		end
	end
end)

-- git blame
BLAME_NS = vim.api.nvim_create_namespace("virt_text_blame")
vim.keymap.set("n", "<leader>gb", function()
	if vim.b.blame_on then
		virt_text("clear_all", BLAME_NS)
		vim.b.blame_on = false
		return
	end
	vim.cmd("update")
	local file_path = vim.fn.expand("%:p")
	local line_start = 1
	local line_end = vim.api.nvim_buf_line_count(0)
	local cmd = { "git", "blame", "--line-porcelain", "-L", line_start .. "," .. line_end, "--", file_path }
	local result = vim.fn.systemlist(cmd)
	if vim.v.shell_error ~= 0 or #result == 0 then
		vim.notify("Can't blame...", vim.log.levels.ERROR, { Title = "blame" })
		return
	end
	local entries = {}
	local current = 0
	for _, line in ipairs(result) do
		if line:match("^author ") then
			table.insert(entries, {})
			current = current + 1
			entries[current].author = line:gsub("^author ", "")
		elseif line:match("^author%-time ") then
			entries[current].time = os.date("%Y-%m-%d", tonumber(line:gsub("^author%-time ", ""), 10))
		elseif line:match("^summary ") then
			entries[current].summary = line:gsub("^summary ", "")
			if #entries[current].summary > 40 then
				entries[current].summary = entries[current].summary:sub(1, 40):gsub("[\r\n ]+$", "") .. ".."
			end
		end
	end
	for line = line_start, line_end do
		local msg = string.format(
			"%s [%s@%s]",
			entries[line].author ~= "Not Committed Yet" and entries[line].summary or "?",
			entries[line].author or "?",
			entries[line].time or "?"
		)
		virt_text("show_line", BLAME_NS, msg, line)
	end
	vim.b.blame_on = true
end)

vim.lsp.set_log_level("ERROR")

-- general
function send_key(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, false, true), mode, true)
end

function virt_text(toggle, ns, text, line, hl)
	if toggle == "show_line" then
		hl = hl or "Comment"
		vim.api.nvim_buf_set_extmark(0, ns, line - 1, 0, {
			virt_text = { { text, hl } },
			virt_text_pos = "eol_right_align",
			hl_mode = "combine",
		})
	elseif toggle == "clear_all" then
		vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
	end
end

Toggle = {}
function Toggle:new(initial, t, f)
	local toggle = { value = initial, t = t, f = f }
	return setmetatable(toggle, { __index = Toggle })
end
function Toggle:toggle()
	if self.value then
		self.t()
		self.value = false
	else
		self.f()
		self.value = true
	end
end
function Toggle:set(b)
	self.value = b
end

-- hover
local hover = Toggle:new(true, vim.diagnostic.open_float, vim.lsp.buf.hover)
vim.keymap.set("n", "K", function()
	local has_float = false
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" and config.focusable then
			has_float = true
			break
		end
	end
	local line = vim.api.nvim_win_get_cursor(0)[1] - 1
	local diags = vim.diagnostic.get(0, { lnum = line })
	if #diags > 0 then
		if has_float then
			hover:toggle()
		else
			vim.diagnostic.open_float()
			hover:set(false)
		end
	elseif not has_float then
		vim.lsp.buf.hover({ silent = true })
	end
end)

-- setup lazy
IS_WORK = vim.loop.os_uname().sysname == "Darwin"
print("IS_WORK: " .. tostring(IS_WORK))

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
	ui = { border = "rounded", backdrop = 100 },
	install = { colorscheme = { "tokyonight-night" } },
	checker = { enabled = false },

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
					styles = {
						keywords = { italic = false },
					},
					on_highlights = function(hl, c)
						hl.CursorLine = { bg = "#001122" }
						hl.CursorLineNr.fg = "#00CCCC"
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
						hl.QuickFixLine = { bg = "#002244" }
						hl.FlashCurrent = { bg = "#006666", fg = "#111111", bold = false }
						hl.FlashMatch = { bg = "#006666", fg = "#111111", bold = false }
						hl.FlashLabel = { bg = "#880088", fg = "#FAFAFA", bold = true }
						hl.Include = { fg = c.purple }
						hl.TabLine = { fg = hl.LineNr.fg, bg = BG }
						hl.TabLineFill = { bg = BG }
						hl.TabLineSel = { fg = hl.CursorLineNr.fg, bold = true, bg = BG }
						hl.TelescopeResultsComment = { fg = hl.LineNr.fg, bg = "NONE", italic = true }
						vim.api.nvim_set_hl(0, "TelescopeMatching", {
							fg = hl.CursorLineNr.fg,
							bg = hl.LineNr.fg,
							bold = true,
						})
					end,
				})
				vim.cmd([[colorscheme tokyonight-night]])
			end,
		},

		{
			"nvim-treesitter/nvim-treesitter",
			dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", branch = "master" },
			branch = "master", -- TODO: migrate to 'main'
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
						disable = { "go" },
						additional_vim_regex_highlighting = false,
					},
					indent = { enable = true },
					incremental_selection = {
						enable = true,
						keymaps = {
							init_selection = false,
							node_incremental = "+",
							node_decremental = "-",
							scope_incremental = false,
						},
					},
					textobjects = {
						select = {
							enable = true,
							lookahead = true,
							keymaps = {
								["af"] = "@function.outer",
								["if"] = "@function.inner",
								["ab"] = "@block.outer",
								["ib"] = "@block.inner",
								["ai"] = "@conditional.outer",
								["ii"] = "@conditional.inner",
								["al"] = "@loop.outer",
								["il"] = "@loop.inner",
								["ac"] = "@call.outer",
								["ic"] = "@call.inner",
								["aa"] = "@parameter.outer",
							},
							selection_modes = {
								["@parameter.outer"] = "v",
								["@function.outer"] = "V",
								["@conditional.outer"] = "V",
								["@loop.outer"] = "V",
								["@block.outer"] = "V",
							},
							include_surrounding_whitespace = false,
						},
						move = {
							enable = true,
							set_jumps = false,
							goto_next_start = {
								["]f"] = "@function.outer",
								["]b"] = "@block.outer",
								["]i"] = "@conditional.outer",
								["]l"] = "@loop.outer",
								["]a"] = "@parameter.outer",
								["]c"] = "@call.inner",
							},
							goto_next_end = {
								["]F"] = "@function.outer",
								["]B"] = "@block.outer",
								["]I"] = "@conditional.outer",
								["]L"] = "@loop.outer",
								["]C"] = "@call.inner",
							},
							goto_previous_start = {
								["[f"] = "@function.outer",
								["[b"] = "@block.outer",
								["[i"] = "@conditional.outer",
								["[l"] = "@loop.outer",
								["[a"] = "@parameter.outer",
								["[c"] = "@call.inner",
							},
							goto_previous_end = {
								["[F"] = "@function.outer",
								["[B"] = "@block.outer",
								["[I"] = "@conditional.outer",
								["[L"] = "@loop.outer",
								["[C"] = "@call.inner",
							},
						},
						swap = {
							enable = true,
							swap_next = {
								[")a"] = "@parameter.inner",
							},
							swap_previous = {
								["(a"] = "@parameter.inner",
							},
						},
					},
				})
				vim.filetype.add({ extension = { yml = "yaml" } })
				local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
				vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
				vim.keymap.set({ "n", "x", "o" }, ",,", ts_repeat_move.repeat_last_move_opposite)
				vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
				vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
				vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
				vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
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
								["<S-Tab>"] = actions.select_tab,
							},
						},
						path_display = {
							filename_first = {
								reverse_directories = false,
							},
							"truncate",
						},
						layout_strategy = "vertical",
						layout_config = {
							prompt_position = "bottom",
							width = 0.96,
							height = 0.96,
						},
						sorting_strategy = "descending",
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
						buffers = {
							sort_mru = true,
							ignore_current_buffer = false,
							mappings = {
								i = {
									["<C-x>"] = actions.delete_buffer,
								},
							},
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

				vim.keymap.set("n", "gH", builtin.help_tags)

				vim.keymap.set("n", "''", builtin.buffers)

				vim.keymap.set("n", "gb", function()
					builtin.live_grep({
						search_dirs = { vim.fn.expand("%:p") },
						prompt_title = "Live Grep (Current buffer)",
					})
				end)
				vim.keymap.set("n", "gB", function()
					builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep (All buffers)" })
				end)

				vim.keymap.set("n", "gm", builtin.marks)

				vim.keymap.set("n", "gT", builtin.builtin)

				vim.keymap.set("n", "g<BS>", builtin.resume)

				vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = "#27a1b9" })
				vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = "#27a1b9" })
			end,
		},

		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				local theme = require("lualine.themes.tokyonight")
				theme.normal.c.bg = vim.g.BG
				theme.inactive.c.bg = vim.g.BG
				vim.api.nvim_set_hl(0, "Statusline", { link = "Normal" })
				vim.api.nvim_set_hl(0, "StatuslineNC", { link = "NormalNC" })

				require("lualine").setup({
					options = {
						theme = theme,
						section_separators = "",
						component_separators = "",
					},
					sections = {
						lualine_a = {
							{
								"tabs",
								max_length = function()
									return vim.o.columns - 50
								end,
								mode = 1,
								path = 0,
								tabs_color = { active = "CursorLineNr", inactive = "LineNr" },
								show_modified_status = false,
								fmt = function(name, ctx)
									local win = vim.api.nvim_tabpage_get_win(ctx.tabId)
									local buf = vim.api.nvim_win_get_buf(win)
									if vim.bo[buf].buftype ~= "" then
										name = vim.bo[buf].buftype
									elseif vim.bo[buf].modified then
										name = name .. " ✎"
									end
									return ctx.tabnr .. " " .. name
								end,
							},
						},
						lualine_b = {},
						lualine_c = {},
						lualine_x = {
							"diagnostics",
							"lsp_status",
							"branch",
							{
								"filetype",
								icon_only = true,
							},
						},
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
				local skip = function(event, kind, find)
					return { filter = { event = event, kind = kind, find = find }, opts = { skip = true } }
				end
				local popup = function(event, kind, find)
					return { filter = { event = event, kind = kind, find = find }, view = "popup" }
				end
				require("noice").setup({
					routes = {
						-- skip("msg_show", "lua_error", "lsp_status.lua:"),
						skip("msg_show", "", "B written"),
						skip("msg_show", "", '^".+L, .+B$'),
						skip("notify", "error", "telescope"),
						popup("msg_show", { "shell_out", "shell_err" }),
						popup("msg_show", nil, "^mark line"),
						popup("msg_show", nil, "^[ ]+#[ ]+cmd history"),
						popup("msg_show", nil, "^Type Name Content"),
						popup("msg_show", nil, "^Tab page"),
						popup("msg_show", "list_cmd", ""),
					},
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
				vim.keymap.set("n", "<leader>na", ":NoiceAll<Cr>", { silent = true })
				vim.keymap.set("n", "<leader>nd", ":NoiceDismiss<Cr>", { silent = true })
				vim.keymap.set("n", "<leader>nt", ":tabs<Cr>", { silent = true })
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
							["<esc>"] = "close_window",
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
							position = "current",
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
			"neovim/nvim-lspconfig",
			dependencies = {
				{ "mason-org/mason.nvim", opts = { ui = { backdrop = 100 } } },
				"mason-org/mason-lspconfig.nvim",
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				-- { "j-hui/fidget.nvim",    enabled = false, opts = {} },
				"Saghen/blink.cmp",
			},
			config = function()
				vim.api.nvim_create_autocmd("LspAttach", {
					callback = function(event)
						local map = function(keys, func, desc, mode)
							mode = mode or "n"
							desc = desc or ""
							vim.keymap.set(
								mode,
								keys,
								func,
								{ buffer = event.buf, desc = "LSP: " .. desc, nowait = true }
							)
						end

						map("gn", vim.lsp.buf.rename, "[R]e[n]ame")
						map("ga", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

						local telescope = require("telescope.builtin")
						map("gr", telescope.lsp_references, "[G]oto [R]eferences")
						map("gi", telescope.lsp_implementations, "[G]oto [I]mplementation") -- qi
						map("gd", telescope.lsp_definitions, "[G]oto [D]efinition")
						map("ge", telescope.diagnostics, "[G]oto [E]rror")
						map("gs", telescope.lsp_dynamic_workspace_symbols, "[G]oto [S]ymbols")
						-- Jump to the type of the word under cursor.
						map("gt", telescope.lsp_type_definitions, "[G]oto [T]ype Definition")

						map("gIH", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "Inlay hints")

						map("<C-Space>", vim.lsp.buf.signature_help, "Sighelp", { "n", "i" })

						-- Fuzzy find all the symbols in your current document.
						map("gDs", telescope.lsp_document_symbols, "Open Document Symbols")
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

				vim.lsp.config("lua_ls", {
					capabilities = capabilities,
					settings = {
						Lua = {
							-- workspace = { -- lazydev should handle this
							-- 	library = vim.api.nvim_get_runtime_file("", true),
							-- },
							telemetry = { enable = false },
						},
					},
				})
				vim.lsp.config("clangd", { capabilities = capabilities })
				vim.lsp.config("rust_analyzer", {
					capabilities = capabilities,
					settings = {
						["rust-analyzer"] = {
							cargo = { all_features = true },
							checkOnSave = { command = "clippy" },
						},
					},
				})
				vim.lsp.config("basedpyright", {
					capabilities = capabilities,
					settings = {
						basedpyright = {
							analysis = {
								typeCheckingMode = "basic",
								autoImportCompletions = false,
							},
						},
					},
				})
				vim.lsp.config("hls", {
					capabilities = capabilities,
					filetypes = { "haskell", "lhaskell", "cabal" },
					on_attach = function(client, _)
						-- disable hls formatting
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end,
				})
				vim.lsp.config("gopls", {
					capabilities = capabilities,
					settings = {
						gopls = {
							staticcheck = true,
							semanticTokens = true,
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

				if IS_WORK then
					vim.lsp.config("roslyn", {
						capabilities = capabilities,
						cmd = {
							"dotnet",
							os.getenv("HOME")
								.. "/dev/roslyn/artifacts/bin/Microsoft.CodeAnalysis.LanguageServer/Release/net9.0/Microsoft.CodeAnalysis.LanguageServer.dll",
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
							["csharp|inlay_hints"] = {
								csharp_enable_inlay_hints_for_implicit_object_creation = true,
								csharp_enable_inlay_hints_for_implicit_variable_types = true,
								csharp_enable_inlay_hints_for_lambda_parameter_types = true,
								csharp_enable_inlay_hints_for_types = true,
								dotnet_enable_inlay_hints_for_indexer_parameters = true,
								dotnet_enable_inlay_hints_for_literal_parameters = true,
								dotnet_enable_inlay_hints_for_object_creation_parameters = true,
								dotnet_enable_inlay_hints_for_other_parameters = true,
								dotnet_enable_inlay_hints_for_parameters = true,
								dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
								dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
								dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
							},
						},
					})
				end

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
					python = { "black" },
				},
				formatters = {
					gofumpt = {
						args = { "-extra" },
					},
					black = {
						prepend_args = { "--line-length=140" },
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
					["<Tab>"] = false, --{ "snippet_forward", "fallback" },
					["<S-Tab>"] = false, --{ "snippet_backward", "fallback" },
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
				fuzzy = { implementation = "rust" },
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

		--
		--
		--
		{
			"seblyng/roslyn.nvim",
			opts = {},
			enabled = IS_WORK,
			ft = { "cs" },
		},
		{
			"GustavEikaas/easy-dotnet.nvim",
			commit = "431d2d41a0f1d5566222720abd5ff568527f3c8b",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
				"Cliffback/netcoredbg-macOS-arm64.nvim",
			},
			enabled = IS_WORK,
			ft = { "cs" },
			config = function()
				local dotnet = require("easy-dotnet")
				dotnet.setup({
					secrets = false,
					lsp = {
						enabled = false,
						roslynator_enabled = false,
					},
					debugger = {
						bin_path = "/Users/filips.ivanovs/.local/share/nvim/lazy/netcoredbg-macOS-arm64.nvim/netcoredbg/netcoredbg",
						mappings = {
							open_variable_viewer = { lhs = "V", desc = "open variable viewer" },
						},
					},
					test_runner = {
						mappings = {
							run_test_from_buffer = { lhs = "<leader>r", desc = "run test from buffer" },
							debug_test = { lhs = "<leader>d", desc = "debug test" },
							peek_stack_trace_from_buffer = { lhs = "<leader>p", desc = "peek stack trace from buffer" },
							filter_failed_tests = { lhs = "<leader>fe", desc = "filter failed tests" },
							go_to_file = { lhs = "g", desc = "go to file" },
							run_all = { lhs = "<leader>R", desc = "run all tests" },
							run = { lhs = "<leader>r", desc = "run test" },
							peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
							expand = { lhs = "o", desc = "expand" },
							expand_node = { lhs = "E", desc = "expand node" },
							expand_all = { lhs = "-", desc = "expand all" },
							collapse_all = { lhs = "W", desc = "collapse all" },
							close = { lhs = "q", desc = "close testrunner" },
							refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
						},
					},
					auto_bootstrap_namespace = {
						type = "file_scoped",
					},
				})
				vim.keymap.set("n", "<leader>DR", ":Dotnet testrunner<CR>", { silent = true })
				vim.keymap.set("n", "<leader>DB", ":Dotnet build<CR>", { silent = true })
				vim.keymap.set("n", "<leader>DD", ":Dotnet debug<CR>", { silent = true })
			end,
		},
		{
			"mfussenegger/nvim-dap",
			enabled = IS_WORK,
			ft = { "cs" },
			config = function()
				local dap = require("dap")
				dap.adapters.coreclr = {
					type = "executable",
					command = "/Users/filips.ivanovs/.local/share/nvim/mason/bin/netcoredbg",
					args = { "--interpreter=vscode", "--engineLogging=/tmp/netcoredbg-engine.log" },
				}
				dap.configurations.cs = {
					{
						type = "coreclr",
						name = "launch - coreclr",
						request = "launch",
						program = function()
							return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/net8.0/", "file")
						end,
						cwd = vim.fn.getcwd(),
						stopAtEntry = true,
						justMyCode = true,
						exceptionBreakpointFilters = {
							{ filter = "all", label = "Break on all exceptions", enabled = true },
						},
					},
				}
			end,
		},
		{
			"rcarriga/nvim-dap-ui",
			enabled = IS_WORK,
			ft = { "cs" },
			dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
			opts = {},
			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")
				vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
				vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpointCondition" })
				vim.fn.sign_define("DapBreakpointRejected", { text = "✖", texthl = "DapBreakpointRejected" })
				vim.fn.sign_define("DapStopped", { text = "➜", texthl = "DapStopped", linehl = "DapStoppedLine" })

				vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e06c75" })
				vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#e5c07b" })
				vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#be5046" })
				vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379" })
				vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#002244" })

				dapui.setup({
					icons = {
						expanded = "▼",
						collapsed = "▶",
						current_frame = "▶",
					},
					controls = {
						icons = {
							pause = "⏸",
							play = "▶",
							step_into = "⤵",
							step_over = "⤼",
							step_out = "⤴",
							step_back = "⏮",
							run_last = "↺",
							terminate = "⏹",
						},
					},
				})

				vim.keymap.set("n", "<F2>", dap.toggle_breakpoint)

				local exns = Toggle:new(false, function()
					require("dap").set_exception_breakpoints({})
					vim.notify("Exceptions off", vim.log.levels.INFO)
				end, function()
					require("dap").set_exception_breakpoints({ "all" })
					vim.notify("Exceptions on", vim.log.levels.INFO)
				end)

				local widgets = require("dap.ui.widgets")
				local scopes = Toggle:new(false, function()
					if vim.api.nvim_win_get_config(0).relative ~= "" then
						vim.cmd(":q")
					end
				end, function()
					widgets.centered_float(widgets.scopes) -- just current frame scopes
				end)

				vim.api.nvim_create_user_command("DebugKeymapsOn", function()
					vim.keymap.set("n", "<C-n>", dap.continue)
					vim.keymap.set("n", "b", dap.toggle_breakpoint)
					vim.keymap.set("n", "n", dap.step_over)
					vim.keymap.set("n", "N", dap.step_into)
					vim.keymap.set("n", "<BS>", dap.step_out)
					vim.keymap.set("n", "X", function()
						dap.terminate()
						dapui.close()
					end)
					vim.keymap.set("n", "e", function()
						exns:toggle()
					end)
					vim.keymap.set("n", "s", function()
						scopes:toggle()
					end)
				end, {})
				vim.api.nvim_create_user_command("DebugKeymapsOff", function()
					pcall(vim.keymap.del, "n", "<C-n>")
					pcall(vim.keymap.del, "n", "n")
					pcall(vim.keymap.del, "n", "N")
					pcall(vim.keymap.del, "n", "<BS>")
					pcall(vim.keymap.del, "n", "X")
					pcall(vim.keymap.del, "n", "b")
					pcall(vim.keymap.del, "n", "e")
					pcall(vim.keymap.del, "n", "s")
				end, {})

				dap.listeners.after.event_initialized["on_start"] = function()
					vim.cmd("DebugKeymapsOn")
					print("Debugger started!")
				end

				dap.listeners.before.event_terminated["on_end"] = function()
					vim.cmd("DebugKeymapsOff")
					print("Debugger terminated.")
				end

				dap.listeners.before.event_exited["on_exit"] = function()
					vim.cmd("DebugKeymapsOff")
					print("Target process exited.")
				end
			end,
		},
		{
			"Cliffback/netcoredbg-macOS-arm64.nvim",
			enabled = IS_WORK,
			ft = { "cs" },
			dependencies = { "mfussenegger/nvim-dap" },
			config = function()
				require("netcoredbg-macOS-arm64").setup(require("dap"))
			end,
		},
	},
})
