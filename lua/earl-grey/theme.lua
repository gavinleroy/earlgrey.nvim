local M = {}

function M.setup(colors)
	local groups = {
		-- =========================================================================
		--  BASE EDITOR (The Canvas)
		-- =========================================================================
		Normal = { fg = colors.foreground, bg = colors.background },
		NormalNC = { fg = colors.foreground, bg = colors.background }, -- Non-current windows
		NormalFloat = { fg = colors.foreground, bg = colors.background_alt }, -- Floating windows
		FloatBorder = { fg = colors.grey5, bg = colors.background_alt },

		-- Cursor & Line
		Cursor = { fg = colors.background, bg = colors.foreground },
		CursorLine = { bg = colors.grey1 }, -- Subtle highlight for current line
		CursorColumn = { bg = colors.grey1 },
		ColorColumn = { bg = colors.grey1 }, -- 80-char limit column

		-- Selection
		Visual = { bg = colors.grey3 }, -- Selection color
		VisualNOS = { bg = colors.grey3 },

		-- Gutter / Line Numbers
		LineNr = { fg = colors.grey4 },
		CursorLineNr = { fg = colors.grey8, bold = true },
		SignColumn = { bg = colors.background_alt },

		-- Search
		Search = { fg = colors.berry1, bg = colors.berry }, -- Earl Grey spec: Berry for UI
		IncSearch = { fg = colors.berry1, bg = colors.berry },
		CurSearch = { fg = colors.berry1, bg = colors.berry },
		MatchParen = { fg = colors.berry, bold = true, bg = colors.grey2 },

		-- Status Line
		StatusLine = { fg = colors.foreground, bg = colors.grey2 },
		StatusLineNC = { fg = colors.grey5, bg = colors.grey1 },
		WinBar = { fg = colors.foreground, bg = colors.background },
		WinBarNC = { fg = colors.grey5, bg = colors.background },

		-- Splits
		VertSplit = { fg = colors.grey3 },
		WinSeparator = { fg = colors.grey3 },

		-- Popups (Pmenu)
		Pmenu = { fg = colors.foreground, bg = colors.background_alt },
		PmenuSel = { fg = colors.berry1, bg = colors.berry, bold = true },
		PmenuSbar = { bg = colors.grey2 },
		PmenuThumb = { bg = colors.grey4 },

		-- Folds
		Folded = { fg = colors.blue, bg = colors.grey1 },
		FoldColumn = { fg = colors.grey4, bg = colors.background },

		-- Specials
		Directory = { fg = colors.blue },
		Conceal = { fg = colors.grey5 },
		SpecialKey = { fg = colors.grey4 },
		Title = { fg = colors.purple, bold = true },
		Question = { fg = colors.blue },
		MoreMsg = { fg = colors.blue },
		ErrorMsg = { fg = colors.background, bg = colors.red },
		WarningMsg = { fg = colors.orange },

		-- =========================================================================
		--  SYNTAX (Mapping Earl Grey Specs to standard groups)
		-- =========================================================================
		Comment = { fg = colors.comment, italic = true },
		Constant = { fg = colors.teal },
		String = { fg = colors.green },
		Character = { fg = colors.teal },
		Number = { fg = colors.teal },
		Boolean = { fg = colors.teal },
		Float = { fg = colors.teal },

		Identifier = { fg = colors.blue },
		Function = { fg = colors.foreground, italic = true },

		Statement = { fg = colors.purple },
		Conditional = { fg = colors.purple },
		Repeat = { fg = colors.purple },
		Label = { fg = colors.orange, italic = true },
		Operator = { fg = colors.foreground },
		Keyword = { fg = colors.purple },
		Exception = { fg = colors.purple },

		PreProc = { fg = colors.orange },
		Include = { fg = colors.purple },
		Define = { fg = colors.purple },
		Macro = { fg = colors.orange },
		PreCondit = { fg = colors.orange },

		Type = { fg = colors.purple },
		StorageClass = { fg = colors.purple, italic = true },
		Structure = { fg = colors.purple },
		Typedef = { fg = colors.purple },

		Special = { fg = colors.teal },
		SpecialChar = { fg = colors.teal },
		Tag = { fg = colors.purple },
		Delimiter = { fg = colors.foreground },

		Underlined = { underline = true },
		Bold = { bold = true },
		Italic = { italic = true },
		Ignore = { fg = colors.grey5 },
		Error = { fg = colors.red },
		Todo = { fg = colors.orange, bold = true },

		-- =========================================================================
		--  LSP
		-- =========================================================================
		LspCodeLens = { bg = colors.background_alt },
		LspCodeLensSeparator = { bg = colors.background_alt },
		-- Explicitly make inlay hints dimmer than comments
		LspInlayHint = { fg = colors.grey4, bg = colors.background_alt, italic = true },
		LspReferenceRead = { bg = colors.background_alt },
		LspReferenceText = { bg = colors.background_alt },
		LspReferenceWrite = { bg = colors.background_alt },

		-- =========================================================================
		--  TREESITTER
		-- =========================================================================
		-- Punctuation
		["@punctuation.delimiter"] = { fg = colors.foreground },
		["@punctuation.bracket"] = { fg = colors.foreground },
		["@punctuation.special"] = { fg = colors.teal },

		-- Literals
		["@comment"] = { link = "Comment" },
		["@string"] = { link = "String" },
		["@string.regex"] = { fg = colors.orange },
		["@string.escape"] = { fg = colors.teal },
		["@character"] = { link = "Character" },
		["@boolean"] = { link = "Boolean" },
		["@number"] = { link = "Number" },
		["@float"] = { link = "Float" },

		-- Functions
		["@function"] = { fg = colors.foreground, italic = true },
		["@function.builtin"] = { fg = colors.foreground, italic = true },
		["@function.call"] = { fg = colors.foreground, italic = true },
		["@function.macro"] = { fg = colors.orange },
		["@method"] = { fg = colors.foreground, italic = true },
		["@constructor"] = { fg = colors.foreground, italic = true },

		-- Variables
		["@parameter"] = { fg = colors.blue },
		["@variable"] = { fg = colors.blue },
		["@variable.builtin"] = { fg = colors.purple },
		["@variable.member"] = { fg = colors.blue },
		["@property"] = { fg = colors.foreground, italic = true },
		["@field"] = { fg = colors.blue },

		-- Keywords
		["@keyword"] = { link = "Keyword" },
		["@keyword.function"] = { link = "Keyword" },
		["@keyword.operator"] = { fg = colors.foreground },
		["@keyword.return"] = { link = "Keyword" },

		-- Types
		["@type"] = { link = "Type" },
		["@type.builtin"] = { link = "Type" },
		["@type.definition"] = { link = "Type" },
		["@type.qualifier"] = { link = "StorageClass" },

		-- Tags / Labels
		["@label"] = { fg = colors.orange, italic = true },
		["@tag"] = { fg = colors.purple },
		["@tag.attribute"] = { fg = colors.blue },
		["@tag.delimiter"] = { fg = colors.foreground },

		-- Text
		["@text.literal"] = { fg = colors.foreground },
		["@text.reference"] = { fg = colors.teal },
		["@text.title"] = { fg = colors.purple, bold = true },
		["@text.uri"] = { fg = colors.blue, underline = true },
		["@text.strong"] = { bold = true },
		["@text.emphasis"] = { italic = true },

		-- =========================================================================
		--  LSP & DIAGNOSTICS
		-- =========================================================================
		DiagnosticError = { fg = colors.red },
		DiagnosticWarn = { fg = colors.orange },
		DiagnosticInfo = { fg = colors.blue },
		DiagnosticHint = { fg = colors.teal },

		-- Underlines
		DiagnosticUnderlineError = { sp = colors.red, undercurl = true },
		DiagnosticUnderlineWarn = { sp = colors.orange, undercurl = true },
		DiagnosticUnderlineInfo = { sp = colors.blue, undercurl = true },
		DiagnosticUnderlineHint = { sp = colors.teal, undercurl = true },

		-- Semantic Tokens (New Standard)
		["@lsp.type.class"] = { link = "Structure" },
		["@lsp.type.decorator"] = { link = "Function" },
		["@lsp.type.enum"] = { link = "Structure" },
		["@lsp.type.enumMember"] = { link = "Constant" },
		["@lsp.type.function"] = { link = "Function" },
		["@lsp.type.interface"] = { link = "Structure" },
		["@lsp.type.macro"] = { link = "Macro" },
		["@lsp.type.method"] = { link = "Function" },
		["@lsp.type.namespace"] = { link = "Structure" },
		["@lsp.type.parameter"] = { link = "@parameter" },
		["@lsp.type.property"] = { link = "@property" },
		["@lsp.type.struct"] = { link = "Structure" },
		["@lsp.type.type"] = { link = "Type" },
		["@lsp.type.typeParameter"] = { link = "Type" },
		["@lsp.type.variable"] = { link = "@variable" },

		-- =========================================================================
		--  PLUGINS
		-- =========================================================================

		-- Telescope
		TelescopeBorder = { fg = colors.grey5 },
		TelescopePromptBorder = { fg = colors.berry },
		TelescopePromptTitle = { fg = colors.berry },
		TelescopePromptPrefix = { fg = colors.berry },
		TelescopeNormal = { fg = colors.foreground, bg = colors.background },
		TelescopePreviewTitle = { fg = colors.teal },
		TelescopeResultsTitle = { fg = colors.blue },
		TelescopeSelection = { bg = colors.grey2, bold = true },
		TelescopeMatching = { fg = colors.berry, bold = true },

		-- Gitsigns
		GitSignsAdd = { fg = colors.green },
		GitSignsChange = { fg = colors.blue },
		GitSignsDelete = { fg = colors.red },
		GitSignsCurrentLineBlame = { fg = colors.grey5, italic = true },

		-- NeoTree / NvimTree
		NeoTreeNormal = { fg = colors.foreground, bg = colors.background },
		NeoTreeWinSeparator = { fg = colors.background, bg = colors.background },
		NeoTreeDirectoryName = { fg = colors.blue, bold = true },
		NeoTreeGitAdded = { fg = colors.green },
		NeoTreeGitConflict = { fg = colors.red, bold = true },
		NeoTreeGitDeleted = { fg = colors.red },
		NeoTreeGitModified = { fg = colors.orange },
		NeoTreeGitUntracked = { fg = colors.teal },
		NeoTreeIndentMarker = { fg = colors.grey5 },

		-- Cmp (Completion)
		CmpItemAbbrDeprecated = { fg = colors.grey5, strikethrough = true },
		CmpItemAbbrMatch = { fg = colors.berry, bold = true },
		CmpItemAbbrMatchFuzzy = { fg = colors.berry, bold = true },
		CmpItemKindVariable = { fg = colors.blue },
		CmpItemKindInterface = { fg = colors.purple },
		CmpItemKindFunction = { fg = colors.teal },
		CmpItemKindMethod = { fg = colors.teal },
		CmpItemKindKeyword = { fg = colors.purple },

		-- Notify
		NotifyERRORBorder = { fg = colors.red },
		NotifyWARNBorder = { fg = colors.orange },
		NotifyINFOBorder = { fg = colors.blue },
		NotifyDEBUGBorder = { fg = colors.grey5 },
		NotifyTRACEBorder = { fg = colors.purple },
		NotifyERRORIcon = { fg = colors.red },
		NotifyWARNIcon = { fg = colors.orange },
		NotifyINFOIcon = { fg = colors.blue },
		NotifyDEBUGIcon = { fg = colors.grey5 },
		NotifyTRACEIcon = { fg = colors.purple },

		-- WhichKey
		WhichKey = { fg = colors.purple },
		WhichKeyGroup = { fg = colors.blue },
		WhichKeyDesc = { fg = colors.foreground },
		WhichKeySeparator = { fg = colors.grey5 },

		-- Lazy.nvim
		LazyNormal = { bg = colors.background_alt },
		LazyH1 = { fg = colors.berry, bold = true },
		LazyButton = { bg = colors.grey2, fg = colors.foreground },
		LazyButtonActive = { bg = colors.berry, fg = colors.berry1, bold = true },

		-- Mason
		MasonHeader = { fg = colors.berry, bold = true },
		MasonHighlight = { fg = colors.blue },

		-- Indent Blankline
		IblIndent = { fg = colors.grey2 },
		IblScope = { fg = colors.grey4 },

		-- Alpha / Dashboard
		AlphaHeader = { fg = colors.berry },
		AlphaButtons = { fg = colors.blue },
		AlphaFooter = { fg = colors.grey5, italic = true },
	}

	return groups
end

return M
