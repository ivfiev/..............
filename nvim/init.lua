vim.g.mapleader = ","
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.keymap.set({ "n", "x" }, ",,", ",")
vim.keymap.set({ "n", "x" }, "!", ":norm! ")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.cmdheight = 0
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.winborder = "rounded"
vim.opt.shortmess:append("I")
vim.opt.showtabline = 0
vim.opt.laststatus = 3
vim.opt.sessionoptions = "buffers,folds,tabpages" -- options(!), curdir, tabpages

vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
vim.opt.autoindent = false
vim.opt.smartindent = false

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

vim.opt.clipboard = "unnamedplus" -- +clipboard
vim.opt.swapfile = false
vim.opt.report = 999999

vim.g.netrw_browse_split = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_list_hide = ""
vim.g.netrw_winsize = 25

vim.opt.statusline = "%f %y %m %r %= %l:%c %p%%"
vim.opt.confirm = true

vim.keymap.set({ "n", "x", "o" }, "L", "$")
vim.keymap.set({ "n", "x", "o" }, "H", "^")
vim.keymap.set({ "x" }, ">", ">gv")
vim.keymap.set({ "x" }, "<", "<gv")

vim.keymap.set({ "n", "i", "x" }, "<C-s>", function()
	vim.cmd("silent w")
	vim.cmd("stopinsert")
	-- vim.cmd("redraw")
end, { silent = true })

vim.keymap.set("n", "<leader>lr", ":lsp restart<CR>")

vim.keymap.set("n", "<X1Mouse>", "<C-o>")
vim.keymap.set("n", "<X2Mouse>", "<C-i>")

vim.keymap.set({ "n", "x" }, "{", "<CMD>keepjumps norm! {<CR>", { silent = true })
vim.keymap.set({ "n", "x" }, "}", "<CMD>keepjumps norm! }<CR>", { silent = true })

vim.keymap.set("n", "<leader><Tab>", ":tab split<CR>", { silent = true })
vim.keymap.set("n", "u", ":silent undo<CR>", { silent = true })
vim.keymap.set("n", "U", ":silent redo<CR>", { silent = true })
vim.keymap.set("n", "<C-r>", "U") -- C-restore
vim.keymap.set("i", "<C-BS>", "<C-w>")
vim.keymap.set("i", "<C-w>", "<C-o><C-w>")

vim.keymap.set("n", "<C-a>", "<C-^>")
vim.keymap.set("i", "<C-a>", "<C-o><C-^>")
vim.keymap.set("t", "<C-a>", [[<C-\><C-n><C-^>]])
vim.keymap.set("t", "<C-s>", "<Nop>")
vim.keymap.set({ "n", "x" }, "<C-p>", [["*gp]])
vim.keymap.set({ "n", "x" }, "<C-S-p>", [["*gP]])
vim.keymap.set("i", "<C-p>", [[<c-o>"*gp]])
vim.keymap.set("x", "gy", function() -- gp gP
	send_key("ygv<Esc>", "x")
end)

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
vim.api.nvim_create_autocmd("BufWinEnter", {
	callback = function()
		if vim.bo.filetype == "help" then
			vim.cmd("wincmd L")
		end
	end,
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
vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.cmd("compiler go")
		vim.cmd([[iabbrev <buffer> ife if err != nil {<CR>return err<C-o>b<Esc>]])
	end,
})
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		pcall(vim.cmd, [[norm! g`"zz]])
	end,
})

-- shadas & sessions
vim.api.nvim_create_user_command("SessionSave", function()
	local dir = vim.fn.getcwd():gsub("/", "%%")
	local path = vim.fn.stdpath("state") .. "/sessions/" .. dir .. ".vim"
	vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
	vim.cmd("mksession! " .. vim.fn.fnameescape(path))
end, {})
vim.api.nvim_create_user_command("SessionLoad", function()
	local dir = vim.fn.getcwd():gsub("/", "%%")
	local path = vim.fn.stdpath("state") .. "/sessions/" .. dir .. ".vim"
	if vim.fn.filereadable(path) == 1 then
		vim.cmd("source " .. vim.fn.fnameescape(path))
	end
end, {})
-- setup shada
local arg = vim.fn.argv(0)
if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
	vim.opt.shadafile = "NONE"
	IS_DIRECTORY_SESSION = true
end
local function only_files() -- only leaves normal project files. :ls!
	-- drop diff tabs
	local tabs = vim.api.nvim_list_tabpages()
	for _, t in ipairs(tabs) do
		if vim.t[t].is_git_diff then
			pcall(vim.cmd.tabclose, vim.api.nvim_tabpage_get_number(t))
		end
	end
	-- kill unreadable/scratch bufs
	local bufs = vim.api.nvim_list_bufs()
	local pwd = IS_DIRECTORY_SESSION and vim.fn.getcwd()
	for _, buf in ipairs(bufs) do
		local fullpath = vim.api.nvim_buf_get_name(buf)
		if
			vim.bo[buf].buftype ~= ""
			or vim.fn.filereadable(fullpath) == 0
			or (pwd and fullpath:find(pwd, 1, true) ~= 1)
		then
			vim.api.nvim_buf_delete(buf, { force = true })
		end
	end
end
vim.api.nvim_create_user_command("OnlyFiles", only_files, {})
vim.keymap.set("n", "<leader>OF", only_files)
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		if IS_DIRECTORY_SESSION then
			-- force correct cwd if directory passed in
			vim.cmd("cd " .. arg) -- TODO escape? eg %'s in name
			-- per-project shadas
			local workspace_path = vim.fn.getcwd()
			local unique_id = vim.fn.fnamemodify(workspace_path, ":t") .. "_" .. vim.fn.sha256(workspace_path):sub(1, 8)
			local shadafile = vim.fn.stdpath("state") .. "/shada/" .. unique_id .. ".shada"
			if not vim.uv.fs_stat(shadafile) then
				vim.cmd("wshada! " .. shadafile) -- this should write a valid empty shada
			end
			vim.opt.shadafile = shadafile
			vim.cmd("rshada!")
			-- restore sesh
			vim.schedule(function()
				vim.cmd("SessionLoad")
				-- kill garbage bufs
				vim.defer_fn(only_files, 25)
			end)
		end
	end,
})
vim.api.nvim_create_autocmd("VimLeavePre", {
	callback = function()
		-- drop garbage bufs again for good measure
		only_files()
		-- if in a project - store session
		if IS_DIRECTORY_SESSION then
			vim.cmd("SessionSave")
		end
	end,
})
-- marks
for l in string.gmatch("abcdefghijklmnopqrstuvwxyz", ".") do
	local u = string.upper(l)
	vim.keymap.set("n", "M" .. l, "m" .. u)
	vim.keymap.set("n", "M" .. u, "m" .. l)
	vim.keymap.set("n", "'" .. l, "'" .. u .. [[g`"zz]])
	vim.keymap.set("n", "'" .. u, "`" .. l)
end
-- ... and tabs
for i = 1, 9 do
	vim.keymap.set({ "n", "t" }, "'" .. i, function()
		pcall(vim.cmd.tabnext, i)
	end)
end

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
LAST_TERM = -1
vim.keymap.set("n", "<leader>T", ":terminal<CR>", { silent = true })
vim.keymap.set("n", "<leader>t", function()
	if vim.api.nvim_buf_is_valid(LAST_TERM) then
		vim.api.nvim_set_current_buf(LAST_TERM)
	else
		vim.cmd("terminal")
	end
end)
vim.keymap.set("t", "<S-Esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "<C-o>", [[<C-\><C-n><C-o>]])
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter", "TabEnter", "WinResized" }, {
	callback = function()
		if vim.bo.buftype == "terminal" then
			vim.schedule(function()
				LAST_TERM = vim.api.nvim_get_current_buf()
				vim.cmd("startinsert")
			end)
		end
	end,
})
vim.keymap.set({ "i", "n" }, "<C-/>", function()
	local ws = vim.api.nvim_tabpage_list_wins(0)
	local term = nil
	for _, w in ipairs(ws) do
		if vim.bo[vim.api.nvim_win_get_buf(w)].buftype == "terminal" then
			term = w
			break
		end
	end
	if not term then
		local cols = TERM_COLS or vim.o.columns / 2.5
		local rows = TERM_ROWS or vim.o.lines / 2.5
		local orientation = cols < vim.o.columns / 1.25 and "v" or ""
		local size = orientation == "v" and cols or rows
		vim.cmd(string.format("silent! %d%ssplit", size, orientation))
		if vim.api.nvim_buf_is_valid(LAST_TERM) then
			vim.api.nvim_set_current_buf(LAST_TERM)
		else
			vim.cmd("terminal")
		end
	else
		TERM_COLS = vim.api.nvim_win_get_width(term)
		TERM_ROWS = vim.api.nvim_win_get_height(term)
		vim.api.nvim_win_close(term, true)
	end
end)
vim.keymap.set("t", "<C-/>", function()
	local ws = vim.api.nvim_tabpage_list_wins(0)
	if #ws > 1 then
		TERM_COLS = vim.api.nvim_win_get_width(0)
		TERM_ROWS = vim.api.nvim_win_get_height(0)
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

-- git
vim.keymap.set("n", "<leader>gd", function()
	if vim.t.is_git_diff then
		vim.cmd("DiffviewClose")
	else
		local branches = vim.fn.systemlist({ "git", "branch" })
		if vim.v.shell_error ~= 0 or #branches == 0 then
			vim.notify("Not in a git repo...", vim.log.levels.ERROR)
			return
		end
		table.insert(branches, 1, "HEAD")
		for i, b in ipairs(branches) do
			branches[i] = b:gsub("^%*?%s*", "", 1)
		end
		vim.ui.select(branches, { prompt = "Diff against: " }, function(branch)
			if branch then
				if branch == "HEAD" then
					vim.cmd("DiffviewOpen")
				else
					vim.cmd("DiffviewOpen " .. branch .. " -u")
				end
			end
		end)
	end
end)
vim.keymap.set("n", "<leader>gp", function()
	vim.ui.input({ prompt = "Commit: ", default = "wip" }, function(msg)
		if not msg or msg == "" then
			return
		end
		vim.cmd("G commit -m " .. vim.fn.shellescape(msg))
		vim.cmd("G push")
	end)
end)
vim.keymap.set("n", "<leader>gb", ":G blame<CR>", { silent = true })

-- general
vim.lsp.log.set_level("ERROR")

function send_key(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, false, true), mode, true)
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

local function merge_hls(src, dst, opts)
	local hl = vim.api.nvim_get_hl(0, { name = src })
	hl = vim.tbl_extend("force", hl, opts)
	vim.api.nvim_set_hl(0, dst, hl)
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

-- IS_WORK = vim.loop.os_uname().sysname == "Darwin"
-- print("IS_WORK: " .. tostring(IS_WORK))

require("vim._core.ui2").enable({
	enable = true,
	msg = {
		targets = "msg",
		cmd = {
			height = 0.5,
		},
		dialog = {
			height = 0.5,
		},
		msg = {
			height = 0.8,
			timeout = 5000,
		},
		pager = {
			height = 0.8,
		},
	},
})
local ui2messages = require("vim._core.ui2.messages")
vim.keymap.set("n", "<leader>d", ui2messages.msg_clear) -- dismiss floating notifications

-- filtering spammy messages
local spam = {
	"No configuration selected",
	"Debug adapter disconnected",
	"File restored from index. Undo with",
}
local orig_msg_show = ui2messages.msg_show
ui2messages.msg_show = function(kind, content, replace_last, _, append, id, trigger)
	for _, c in ipairs(content) do
		for _, m in ipairs(spam) do
			if c[2]:find(m, 1, true) then
				return
			end
		end
	end
	return orig_msg_show(kind, content, replace_last, _, append, id, trigger)
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
	ui = { border = "rounded", backdrop = 100 },
	install = { colorscheme = { "tokyonight-night" } },
	checker = { enabled = false },

	spec = {
		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				TERM_BG = "#070407"
				require("tokyonight").setup({
					on_colors = function(c)
						c.bg = TERM_BG
						c.bg_dark1 = TERM_BG
						c.bg_dark = TERM_BG
						c.bg_float = TERM_BG
						c.bg_popup = TERM_BG
						c.bg_sidebar = TERM_BG
						c.bg_highlight = TERM_BG
						c.bg_statusline = TERM_BG
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
						hl.FlashMatch = { bg = hl.Search.bg, fg = hl.Search.fg, bold = false }
						hl.FlashLabel = { bg = hl.Search.bg, fg = "#00FFFF", bold = true }
						hl.BlinkCmpScrollBarThumb = { bg = "#27a1b9" }
						hl.TabLine = { fg = hl.LineNr.fg, bg = "NONE" }
						hl.TabLineFill = { bg = "NONE" }
						hl.TabLineSel = { fg = hl.CursorLineNr.fg, bold = true, bg = "NONE" }
						hl.TelescopeResultsComment = { fg = hl.LineNr.fg, bg = "NONE", italic = true }
						hl.PreProc = { fg = c.purple }
						hl.Folded = { fg = hl.LineNr.fg, bg = "NONE" }
						vim.api.nvim_set_hl(0, "TelescopeMatching", {
							fg = hl.CursorLineNr.fg,
							bg = hl.Search.bg,
							bold = true,
						})
						hl.MatchParen = { fg = "#FF4400", bg = "NONE", bold = true }
						hl.LspReferenceText = { bg = "NONE" }
						vim.schedule(function()
							vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { link = "Special" })
							vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", { link = "@variable" })
							vim.api.nvim_set_hl(
								0,
								"@lsp.type.namespace.go",
								{ fg = hl.Special.fg, italic = true, bold = true, underline = true }
							)
							vim.api.nvim_set_hl(0, "@lsp.mod.readonly.go", { link = "@variable.builtin" })
							vim.api.nvim_set_hl(0, "@lsp.type.number.go", { link = "@variable.builtin" })
							vim.api.nvim_set_hl(0, "@variable.builtin", { fg = "#D070D0" })
						end)
						vim.keymap.set("n", "<leader>I", ":Inspect<CR>", { silent = true })
					end,
				})
				vim.cmd([[colorscheme tokyonight-night]])
			end,
		},

		{
			"nvim-treesitter/nvim-treesitter",
			lazy = false,
			build = ":TSUpdate",
			config = function()
				local treesitter = require("nvim-treesitter")
				local available = treesitter.get_available()
				local installed = treesitter.get_installed()
				local function start_treesitter(buf, lang)
					vim.treesitter.start(buf, lang)
					vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo[0][0].foldmethod = "expr"
					if vim.bo.filetype ~= "go" then
						vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end
				vim.api.nvim_create_autocmd("FileType", {
					callback = function(ev)
						if vim.bo[ev.buf].buftype ~= "" then
							return
						end
						local lang = vim.treesitter.language.get_lang(ev.match)
						if not lang or not vim.list_contains(available, lang) then
							return
						end
						if not vim.list_contains(installed, lang) then
							table.insert(installed, lang)
							treesitter.install(lang):await(function()
								start_treesitter(ev.buf, lang)
							end)
						else
							start_treesitter(ev.buf, lang)
						end
					end,
				})
				vim.keymap.set("x", "+", "an", { remap = true })
				vim.keymap.set("x", "_", "in", { remap = true })
			end,
		},

		{
			"nvim-telescope/telescope.nvim",
			branch = "master",
			event = "VeryLazy",
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
							width = 0.89,
							height = 0.89,
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
									["<C-x>"] = actions.delete_buffer, -- TODO this wipes marks
								},
							},
						},
					},
					extensions = {
						["ui-select"] = {
							require("telescope.themes").get_cursor({
								winblend = 0,
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
				vim.keymap.set("x", "gF", builtin.grep_string)

				vim.keymap.set("n", "gh", builtin.help_tags)

				vim.keymap.set("n", "''", builtin.buffers)

				vim.keymap.set("n", "gb", function()
					builtin.live_grep({
						search_dirs = { vim.fn.expand("%:p") },
						prompt_title = "Live Grep (Current buffer)",
					})
				end)
				vim.keymap.set("n", "gB", function()
					builtin.live_grep({
						grep_open_files = true,
						prompt_title = "Live Grep (All buffers)",
					})
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
				theme.normal.c.bg = "NONE"
				theme.inactive.c.bg = "NONE"
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
									if vim.t[ctx.tabId].is_git_diff then
										name = "git-diff"
									elseif vim.bo[buf].filetype:find("fugitive", 1, true) == 1 then
										name = vim.bo[buf].filetype
									elseif vim.bo[buf].buftype ~= "" then
										name = vim.bo[buf].buftype
									end
									if vim.bo[buf].modified then
										name = name .. " ✎"
									end
									if #vim.api.nvim_list_tabpages() > 1 then
										name = ctx.tabnr .. " " .. name
									end
									return name
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
			"nvim-neo-tree/neo-tree.nvim",
			keys = { "<leader>fs" },
			branch = "v3.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"MunifTanjim/nui.nvim",
				"nvim-tree/nvim-web-devicons", -- optional, but recommended
			},
			lazy = true, -- neo-tree will lazily load itself
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
			"tpope/vim-fugitive",
			cmd = { "Git", "G", "Gdiffsplit" },
		},

		{
			"dlyongemallo/diffview-plus.nvim",
			cmd = "DiffviewOpen",
			opts = {
				enhanced_diff_hl = false,
				view = {
					default = {
						layout = "diff1_inline",
					},
					inline = {
						deletion_highlight = "full_width",
					},
				},
				file_panel = {
					listing_style = "list", -- "tree"
					list_options = {
						path_style = "full",
					},
					win_config = {
						width = "auto", -- little jittery
					},
					show_branch_name = true,
					always_show_sections = true,
				},
				hooks = {
					view_opened = function(view)
						vim.t.is_git_diff = true
					end,
				},
				keymaps = {
					diff1_inline = { -- tab, s-tab, gf, ]c, [c, g?, s/S, l
						{
							"n",
							"]c",
							function()
								require("diffview.actions").next_inline_hunk()
								vim.cmd("norm! zz")
							end,
							{ desc = "next change" },
						},
						{
							"n",
							"[c",
							function()
								require("diffview.actions").prev_inline_hunk()
								vim.cmd("norm! zz")
							end,
							{ desc = "prev change" },
						},
					},
				},
			},
			config = function(_, opts)
				require("diffview").setup(opts)
				vim.api.nvim_set_hl(0, "DiffviewDiffDelete", { link = "DiffDelete" })
				vim.api.nvim_set_hl(0, "DiffviewDiffChange", { link = "DiffAdd" })
				vim.api.nvim_set_hl(0, "DiffviewDiffTextInline", { link = "DiffAdd" })
				vim.api.nvim_set_hl(0, "DiffviewDiffAdd", { link = "DiffAdd" })
				merge_hls("diffChanged", "DiffviewStatusModified", { bg = "NONE", bold = true })
				merge_hls("diffAdded", "DiffviewStatusUntracked", { bg = "NONE", bold = true })
				merge_hls("diffRemoved", "DiffviewStatusDeleted", { bg = "NONE", bold = true })
				merge_hls("diffAdded", "DiffviewStatusAdded", { bg = "NONE", bold = true })
				vim.api.nvim_set_hl(0, "DiffviewFilePanelSelected", { link = "CursorLineNr" })
				vim.api.nvim_set_hl(0, "DiffviewFilePanelFileName", { link = "LineNr" })
				vim.api.nvim_set_hl(0, "DiffviewFilePanelInsertions", { bold = true, fg = "#009900" })
				vim.api.nvim_set_hl(0, "DiffviewFilePanelDeletions", { bold = true, fg = "#990000" })
				vim.api.nvim_set_hl(0, "DiffviewNormal", { link = "LineNr" })
				vim.api.nvim_set_hl(0, "DiffviewDim1", { link = "LineNr" })
				-- X undo cmd in :mess
				-- force to respect unstaged-files flag
				local adapter = require("diffview.vcs.adapters.git").GitAdapter
				local orig = adapter.show_untracked
				adapter.show_untracked = function(self, opt)
					if opt and opt.dv_opt and opt.dv_opt.show_untracked == true then
						return true
					end
					return orig(self, opt)
				end
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
			event = "VeryLazy",
			dependencies = {
				"mason-org/mason.nvim",
				"mason-org/mason-lspconfig.nvim",
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
							return diagnostic.message
						end,
					},
				})

				local capabilities = require("blink.cmp").get_lsp_capabilities()

				vim.lsp.config("lua_ls", {
					capabilities = capabilities,
					settings = {
						Lua = {
							telemetry = { enable = false },
						},
					},
				})
				vim.lsp.config("clangd", { capabilities = capabilities })
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
					init_options = {
						semanticTokens = true,
					},
					on_attach = function(client, _)
						-- disable gopls formatting
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end,
				})

				-- :Mason
				-- require("mason-tool-installer").setup({ ensure_installed = { ... }})
				require("mason").setup({
					ui = {
						border = "rounded",
						backdrop = 100,
					},
				})
				require("mason-lspconfig").setup()
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
					end,
					mode = "",
					desc = "[F]ormat buffer",
				},
			},
			opts = {
				notify_on_error = false,
				format_on_save = function(bufnr)
					local disable_filetypes = { c = true, cpp = true, cs = true } -- .editorconfig
					if disable_filetypes[vim.bo[bufnr].filetype] then
						return nil
					else
						return {
							timeout_ms = 1000, -- blocks for up to 1sec before saves
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
			"Saghen/blink.cmp",
			event = "VeryLazy",
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
					preset = "default", -- "luasnip"
				},
				-- :h blink-cmp-config-fuzzy
				fuzzy = { implementation = "rust" },
				signature = { enabled = true }, -- func signatures
				cmdline = {
					keymap = { preset = "inherit" },
					completion = {
						menu = { auto_show = true },
						list = { selection = { preselect = false, auto_insert = true } },
					},
				},
			},
		},
		-- debuggers
		{
			"mfussenegger/nvim-dap",
			lazy = true,
			keys = { "<leader>b", "<leader>B", "<C-n>" },
			dependencies = {
				{ "rcarriga/nvim-dap-ui", lazy = true },
				{ "nvim-neotest/nvim-nio", lazy = true },
				{ "mfussenegger/nvim-dap-python", lazy = true },
				{ "leoluz/nvim-dap-go", lazy = true },
			},
			config = function()
				local dap = require("dap")
				local dapui = require("dapui")

				local last_args = ""
				-- python
				require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
				table.insert(dap.configurations.python, 1, {
					type = "python",
					request = "launch",
					name = "Launch file + args",
					program = "${file}",
					args = function()
						local args_string = vim.fn.input("Args (empty=reuse, -=clear): ")
						if args_string == "" then
							args_string = last_args
						elseif args_string == "-" then
							last_args = ""
							args_string = ""
						else
							last_args = args_string
						end
						return vim.split(args_string, "%s+", { trimempty = true })
					end,
					pythonPath = function()
						return vim.fn.exepath("python")
					end,
				})
				-- go
				require("dap-go").setup()

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
					layouts = {
						{
							elements = {
								"scopes",
								"stacks", -- 'o'
								"repl",
							},
							size = 72,
							position = "right",
						},
					},
				})
				vim.api.nvim_create_autocmd("FileType", {
					pattern = "dap-float",
					callback = function()
						vim.keymap.set("n", "q", ":q<CR>", {
							buffer = true,
							silent = true,
							nowait = true,
						})
						vim.keymap.set("n", "<Esc>", ":q<CR>", {
							buffer = true,
							silent = true,
							nowait = true,
						})
					end,
				})

				vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
				vim.keymap.set("n", "<leader>B", function()
					dap.set_breakpoint(vim.fn.input("Cond: "))
				end)
				vim.keymap.set("n", "<leader><BS>b", dap.clear_breakpoints)
				local old_K = vim.fn.maparg("K", "n", false, true)
				vim.keymap.set("n", "<C-n>", dap.continue)
				local function set_maps()
					vim.keymap.set("n", "n", dap.step_over)
					vim.keymap.set("n", "N", dap.step_into)
					vim.keymap.set("n", "<BS>", dap.step_out)
					vim.keymap.set("n", "X", dap.terminate)
					vim.keymap.set("n", "K", require("dap.ui.widgets").hover)
				end
				local function unset_maps()
					pcall(vim.keymap.del, "n", "n")
					pcall(vim.keymap.del, "n", "N")
					pcall(vim.keymap.del, "n", "<BS>")
					pcall(vim.keymap.del, "n", "X")
					vim.keymap.set("n", "K", old_K.callback)
				end

				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open({ reset = true })
					set_maps()
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close()
					unset_maps()
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close()
					unset_maps()
				end
			end,
		},
	},
})
