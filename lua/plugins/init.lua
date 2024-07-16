return {
	'nvim-lua/plenary.nvim',
	{
		'hrsh7th/cmp-vsnip',
		dependencies {
			'hrsh7th/nvim-cmp',
		},
	},
	{
		'hrsh7th/vim-vsnip',
		dependencies {
			'hrsh7th/nvim-cmp',
		},
	},
	'williamboman/mason.nvim',
	'williamboman/mason-lspconfig.nvim',
	'neovim/nvim-lspconfig',
	"luisiacc/handmade-hero-theme",
	{
		'hrsh7th/nvim-cmp',
		as = 'cmp',
	},
	{
		'hrsh7th/cmp-buffer'
		dependencies = {
			'hrsh7th/nvim-cmp',
		},
	},
	{
		'hrsh7th/cmp-path',
		dependencies = {
			'hrsh7th/nvim-cmp',
		},
	},
	{
		'hrsh7th/cmp-nvim-lsp',
		dependencies = {
			'hrsh7th/nvim-cmp',
		},
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		dependencies = {
			--- Uncomment these if you want to manage LSP servers from neovim
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			-- LSP Support
			'neovim/nvim-lspconfig',
		}

		config = function()_
			require('mason').setup()
			require('mason-lspconfig').setup({
				ensure_installed = {"clangd", "rust_analyzer"}
			})

			local lsp = require('lspconfig')
			lsp.clangd.setup {}
			lsp.rust_analyzer.setup {}

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
			vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					local keymap = vim.keymap
					local opts = { noremap = true, silent = true }

					opts.desc = "Show LSP references"
					keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

					opts.desc = "Go to declaration"
					keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

					opts.desc = "Show LSP definitions"
					keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

					opts.desc = "Show LSP implementations"
					keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

					opts.desc = "Show LSP type definitions"
					keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

					opts.desc = "See available code actions"
					keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

					opts.desc = "Smart rename"
					keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

					opts.desc = "Show buffer diagnostics"
					keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

					opts.desc = "Show line diagnostics"
					keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

					opts.desc = "Go to previous diagnostic"
					keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

					opts.desc = "Go to next diagnostic"
					keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

					opts.desc = "Show documentation for what is under cursor"
					keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

					opts.desc = "Restart LSP"
					keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

				end,
			})
		end
	},
	{
		"ray-x/lsp_signature.nvim",
		config = function()_
			cfg = {

				debug = false, -- set to true to enable debug logging
				log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
				-- default is  ~/.cache/nvim/lsp_signature.log
				verbose = false, -- show debug line number

				bind = true, -- This is mandatory, otherwise border config won't get registered.
				-- If you want to hook lspsaga or other signature handler, pls set to false
				doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
				-- set to 0 if you DO NOT want any API comments be shown
				-- This setting only take effect in insert mode, it does not affect signature help in normal
				-- mode, 10 by default

				max_height = 30, -- max height of signature floating_window
				max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
				-- the value need >= 40
				wrap = false, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
				floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

				floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
				-- will set to true when fully tested, set to false will use whichever side has more space
				-- this setting will be helpful if you do not want the PUM and floating win overlap

				floating_window_off_x = 1, -- adjust float windows x position.
				-- can be either a number or function
				floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
				-- can be either number or function, see examples

				close_timeout = 4000, -- close floating window after ms when laster parameter is entered
				fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
				hint_enable = true, -- virtual hint enable
				hint_prefix = "",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
				hint_scheme = "String",
				hint_inline = function() return false end,  -- should the hint be inline(nvim 0.10 only)?  default false
				-- return true | 'inline' to show hint inline, return 'eol' to show hint at end of line, return false to disable
				-- return 'right_align' to display hint right aligned in the current line
				hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
				handler_opts = {
					border = "shadow"   -- double, rounded, single, shadow, none, or a table of borders
				},

				always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

				auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
				extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
				zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

				padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

				transparency = nil, -- disabled by default, allow floating win transparent value 1~100
				shadow_blend = 36, -- if you using shadow as border use this set the opacity
				shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
				timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
				toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
				toggle_key_flip_floatwin_setting = false, -- true: toggle floating_windows: true|false setting after toggle key pressed
				-- false: floating_windows setup will not change, toggle_key will pop up signature helper, but signature
				-- may not popup when typing depends on floating_window setting

				select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
				move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
			}  -- add your config here

			require "lsp_signature".setup(cfg)

		end
	},
	{
		'andweeb/presence.nvim',
		config = function()_ 
			require("presence").setup({

				auto_update         = true,                       
				neovim_image_text   = "Niovim", 
				main_image          = "file",                   
				client_id           = "793271441293967371",       
				log_level           = nil,                        
				debounce_timeout    = 10,                         
				enable_line_number  = false,                      
				blacklist           = {},                         
				buttons             = true,                       
				file_assets         = {},                         
				show_time           = false,                       


				editing_text        = "Editing %s",               
				file_explorer_text  = "Browsing %s",              
				git_commit_text     = "Committing changes",       
				plugin_manager_text = "Managing plugins",         
				reading_text        = "Reading %s",               
				workspace_text      = "Working on %s",            
				line_number_text    = "Line %s out of %s",        
			})
		end
	},
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		dependencies = { 'nvim-lua/plenary.nvim' }
		config = function()_
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
			vim.keymap.set('n', '<C-e>', builtin.oldfiles, {})
			vim.keymap.set('n', '<leader>fs', builtin.git_files, {})
			vim.keymap.set('n', '<leader>ps', function() 
				builtin.grep_string({ search = vim.fn.input("Grep > ") });
			end)
		end
	},
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',

		config = function()_
			require'nvim-treesitter.configs'.setup {
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = { "c", "cpp", "rust" },

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = false,

				-- List of parsers to ignore installing (or "all")
				ignore_install = { "javascript" },

				---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
				parser_install_dir = "C:\\Users\\phill\\AppData\\local\\nvim-data\\parsers\\", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = true,
				},
			}
		end
	},
	{
		'mbbill/undotree',
		config = function() _
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end
	},
	{
		'ThePrimeagen/harpoon',
		branch = "harpoon2",
		dependencies  = { 'nvim-lua/plenary.nvim' },
		config = function()_
			local harpoon = require("harpoon")
			harpoon:setup()

			vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
			vim.keymap.set("n", "<C-p>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

			vim.keymap.set("n", "<C-2>", function() harpoon:list():select(1) end)
			vim.keymap.set("n", "<C-3>", function() harpoon:list():select(2) end)
			vim.keymap.set("n", "<C-8>", function() harpoon:list():select(3) end)
			vim.keymap.set("n", "<C-9>", function() harpoon:list():select(4) end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
			vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
		end
	},
	{
		"luisiacc/handmade-hero-theme",

		-- setup must be called before loading
		--vim.cmd("colorscheme kanagawa")
		config = function()_
			vim.cmd("colorscheme handmade-hero-theme")
		end

	},
	{
		'tpope/vim-fugitive',
		dependencies = {
			'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
		}
		config = function()_
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
		end
	},
	{
		'hrsh7th/nvim-cmp',
		config = function()_
			local cmp = require('cmp')

			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-d>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'vsnip' }, -- For vsnip users.
					{ name = 'path' },
					-- { name = 'luasnip' }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, {
					{ name = 'buffer' },
				}),
			})

		end
	},
}

