local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end

opt('o', 'hlsearch', false)
opt('o', 'incsearch', true)
opt('o', 'scrolloff', 8)
opt('o', 'sidescrolloff', 8 )
opt('o', 'sidescrolloff', 8 )

vim.o.cindent = true
vim.o.cino = 'j1,(0,ws,Ws,l1'

vim.opt.guicursor = ""
vim.diagnostic.config ({ 
    virtual_lines = {
        current_line = true,
    },
    virtual_text = true,
})

vim.lsp.log.set_level(vim.log.levels.OFF)
vim.lsp.enable("clangd")

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = {buffer = event.buf}
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gR', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})

-- vim.api.nvim_create_autocmd('LspAttach', {
--     callback = function(ev)
--         local client = vim.lsp.get_client_by_id(ev.data.client_id)
--         if client:supports_method('textDocument/completion') then
--             vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'pop' }
--             vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--             vim.keymap.set('i', '<C-Space>', function()
--                 vim.lsp.completion.get()
--             end)
--         end
--     end
-- })

vim.keymap.set('n', '<F9>', vim.cmd.make)

if vim.loader then
	vim.loader.enable()
end
vim.opt.swapfile = false
vim.wo.relativenumber = true
vim.wo.number = true

vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.winborder = 'rounded'
vim.wo.wrap = false
vim.opt.makeprg = "u.cmd"
vim.o.guifont = "JetBrainsMono Nerd Font:h16" 
vim.g.mapleader = " "
vim.g.maplocalleader = ","


-- Bootstrap lazy.nvim
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

return require('lazy').setup({
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
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

		config = function()
			require'nvim-treesitter.configs'.setup {
				-- A list of parser names, or "all" (the five listed parsers should always be installed)
				ensure_installed = { "c", "cpp", "rust", "lua", "zig", "glsl"},

				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,

				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = false,

				-- List of parsers to ignore installing (or "all")
				ignore_install = { "javascript" },

				---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
				-- parser_install_dir = "C:\\Users\\phill\\AppData\\local\\nvim-data\\parsers\\", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

				highlight = {
					enable = true,
					additional_vim_regex_highlighting = true,
				},
			}
		end
	},

	{
		'mbbill/undotree',
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end
	},

	{
        'Mofiqul/vscode.nvim',
		lazy = false,
		config = function()
			vim.cmd("colorscheme vscode")
            vim.o.background = "dark"
		end
	},

    {
        'stevearc/oil.nvim',
        config = function()
            require("oil").setup({
                -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
                -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
                default_file_explorer = true,
                -- Id is automatically added at the beginning, and name at the end
                -- See :help oil-columns
                columns = {
                    "icon",
                    -- "permissions",
                    -- "size",
                    -- "mtime",
                },
                -- Buffer-local options to use for oil buffers
                buf_options = {
                    buflisted = false,
                    bufhidden = "hide",
                },
                -- Window-local options to use for oil buffers
                win_options = {
                    wrap = false,
                    signcolumn = "no",
                    cursorcolumn = false,
                    foldcolumn = "0",
                    spell = false,
                    list = false,
                    conceallevel = 3,
                    concealcursor = "nvic",
                },
                -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
                delete_to_trash = false,
                -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
                skip_confirm_for_simple_edits = false,
                -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
                -- (:help prompt_save_on_select_new_entry)
                prompt_save_on_select_new_entry = true,
                -- Oil will automatically delete hidden buffers after this delay
                -- You can set the delay to false to disable cleanup entirely
                -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
                cleanup_delay_ms = 2000,
                lsp_file_methods = {
                    -- Enable or disable LSP file operations
                    enabled = true,
                    -- Time to wait for LSP file operations to complete before skipping
                    timeout_ms = 1000,
                    -- Set to true to autosave buffers that are updated with LSP willRenameFiles
                    -- Set to "unmodified" to only save unmodified buffers
                    autosave_changes = false,
                },
                -- Constrain the cursor to the editable parts of the oil buffer
                -- Set to `false` to disable, or "name" to keep it on the file names
                constrain_cursor = "editable",
                -- Set to true to watch the filesystem for changes and reload oil
                watch_for_changes = true,
                -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
                -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
                -- Additionally, if it is a string that matches "actions.<name>",
                -- it will use the mapping at require("oil.actions").<name>
                -- Set to `false` to remove a keymap
                -- See :help oil-actions for a list of all available actions
                keymaps = {
                    ["g?"] = { "actions.show_help", mode = "n" },
                    ["<CR>"] = "actions.select",
                    ["<C-s>"] = { "actions.select", opts = { vertical = true } },
                    ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
                    ["<C-t>"] = { "actions.select", opts = { tab = true } },
                    ["<C-p>"] = "actions.preview",
                    ["<Esc>"] = { "actions.close", mode = "n" },
                    ["<C-l>"] = "actions.refresh",
                    ["-"] = { "actions.parent", mode = "n" },
                    ["_"] = { "actions.open_cwd", mode = "n" },
                    ["`"] = { "actions.cd", mode = "n" },
                    ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
                    ["gs"] = { "actions.change_sort", mode = "n" },
                    ["gx"] = "actions.open_external",
                    ["g."] = { "actions.toggle_hidden", mode = "n" },
                    ["g\\"] = { "actions.toggle_trash", mode = "n" },
                },
                -- Set to false to disable all of the above keymaps
                use_default_keymaps = true,
                view_options = {
                    -- Show files and directories that start with "."
                    show_hidden = false,
                    -- This function defines what is considered a "hidden" file
                    is_hidden_file = function(name, bufnr)
                        local m = name:match("^%.")
                        return m ~= nil
                    end,
                    -- This function defines what will never be shown, even when `show_hidden` is set
                    is_always_hidden = function(name, bufnr)
                        return false
                    end,
                    -- Sort file names with numbers in a more intuitive order for humans.
                    -- Can be "fast", true, or false. "fast" will turn it off for large directories.
                    natural_order = "fast",
                    -- Sort file and directory names case insensitive
                    case_insensitive = false,
                    sort = {
                        -- sort order can be "asc" or "desc"
                        -- see :help oil-columns to see which columns are sortable
                        { "type", "asc" },
                        { "name", "asc" },
                    },
                    -- Customize the highlight group for the file name
                    highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
                        return nil
                    end,
                },
                -- Extra arguments to pass to SCP when moving/copying files over SSH
                extra_scp_args = {},
                -- EXPERIMENTAL support for performing file operations with git
                git = {
                    -- Return true to automatically git add/mv/rm files
                    add = function(path)
                        return false
                    end,
                    mv = function(src_path, dest_path)
                        return false
                    end,
                    rm = function(path)
                        return false
                    end,
                },
                -- Configuration for the floating window in oil.open_float
                float = {
                    -- Padding around the floating window
                    padding = 2,
                    -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                    max_width = 0,
                    max_height = 0,
                    border = "rounded",
                    win_options = {
                        winblend = 0,
                    },
                    -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
                    get_win_title = nil,
                    -- preview_split: Split direction: "auto", "left", "right", "above", "below".
                    preview_split = "auto",
                    -- This is the config that will be passed to nvim_open_win.
                    -- Change values here to customize the layout
                    override = function(conf)
                        return conf
                    end,
                },
                -- Configuration for the file preview window
                preview_win = {
                    -- Whether the preview window is automatically updated when the cursor is moved
                    update_on_cursor_moved = true,
                    -- How to open the preview window "load"|"scratch"|"fast_scratch"
                    preview_method = "fast_scratch",
                    -- A function that returns true to disable preview on a file e.g. to avoid lag
                    disable_preview = function(filename)
                        return false
                    end,
                    -- Window-local options to use for preview window buffers
                    win_options = {},
                },
                -- Configuration for the floating action confirmation window
                confirmation = {
                    -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                    -- min_width and max_width can be a single value or a list of mixed integer/float types.
                    -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
                    max_width = 0.9,
                    -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
                    min_width = { 40, 0.4 },
                    -- optionally define an integer/float for the exact width of the preview window
                    width = nil,
                    -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                    -- min_height and max_height can be a single value or a list of mixed integer/float types.
                    -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
                    max_height = 0.9,
                    -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
                    min_height = { 5, 0.1 },
                    -- optionally define an integer/float for the exact height of the preview window
                    height = nil,
                    border = "rounded",
                    win_options = {
                        winblend = 0,
                    },
                },
                -- Configuration for the floating progress window
                progress = {
                    max_width = 0.9,
                    min_width = { 40, 0.4 },
                    width = nil,
                    max_height = { 10, 0.9 },
                    min_height = { 5, 0.1 },
                    height = nil,
                    border = "rounded",
                    minimized_border = "none",
                    win_options = {
                        winblend = 0,
                    },
                },
                -- Configuration for the floating SSH window
                ssh = {
                    border = "rounded",
                },
                -- Configuration for the floating keymaps help window
                keymaps_help = {
                    border = "rounded",
                },
            })
            vim.keymap.set("n", "<leader>pv", '<cmd>Oil --float<CR>')
        end
    },

    {
        'ojroques/nvim-hardline',
        config = function()
            require('hardline').setup {
                bufferline = false,  -- disable bufferline
                bufferline_settings = {
                    exclude_terminal = false,  -- don't show terminal buffers in bufferline
                    show_index = false,        -- show buffer indexes (not the actual buffer numbers) in bufferline
                },
                theme = 'default',   -- change theme
                sections = {         -- define sections
                    {class = 'mode', item = require('hardline.parts.mode').get_item},
                    {class = 'high', item = require('hardline.parts.git').get_item, hide = 100},
                    {class = 'med', item = require('hardline.parts.filename').get_item},
                    '%<',
                    {class = 'med', item = '%='},
                    {class = 'error', item = require('hardline.parts.lsp').get_error},
                    {class = 'warning', item = require('hardline.parts.lsp').get_warning},
                    {class = 'high', item = require('hardline.parts.filetype').get_item, hide = 60},
                    {class = 'mode', item = require('hardline.parts.line').get_item},
                },
            } 
        end,
    },

    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = {
            bind = true,
            handler_opts = {
                border = "rounded"
            }
        },
    },
    {
        'andweeb/presence.nvim',
        config = function()
            -- The setup config table shows all available config options with their default values:
            require("presence").setup({
                -- General options
                auto_update         = true,                        -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
                neovim_image_text   = "work for once in your life",-- Text displayed when hovered over the Neovim image
                main_image          = "file",                      -- Main image display (either "neovim" or "file")
                client_id           = "793271441293967371",        -- Use your own Discord application client id (not recommended)
                log_level           = nil,                         -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
                debounce_timeout    = 10,                          -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
                enable_line_number  = false,                       -- Displays the current line number instead of the current project
                blacklist           = {},                          -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
                buttons             = true,                        -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
                file_assets         = {},                          -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
                show_time           = true,                        -- Show the timer
                enable_line_number  = true,

                -- Rich Presence text options
                editing_text        = "Editing %s",                -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
                file_explorer_text  = "Browsing %s",               -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
                git_commit_text     = "Committing changes",        -- Format string rendered when committing changes in git (either string or function(filename: string): string)
                plugin_manager_text = "Managing plugins",          -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
                reading_text        = "Reading %s",                -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
                workspace_text      = "Working on %s",             -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
                line_number_text    = "Line %s out of %s",         -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
            })
        end,
    },
})

