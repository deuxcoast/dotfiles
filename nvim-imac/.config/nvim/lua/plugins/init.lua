return {
    { "bluz71/vim-moonfly-colors", name = "moonfly",                          lazy = false, priority = 1000 },
    { "kana/vim-textobj-entire",   dependencies = { "kana/vim-textobj-user" } }, -- select entire buffer
    { "kana/vim-textobj-line",     dependencies = { "kana/vim-textobj-user" } }, -- select entire line
    {
        "kazhala/close-buffers.nvim",
        config = function()
            vim.keymap.set("n", "<leader>q", function()
                require("close_buffers").delete({ type = "this" }) -- Delete the current buffer
            end)
        end,
    },
    { "nvim-lua/plenary.nvim" }, -- useful lua functions
    --[[ { "unblevable/quick-scope" }, -- highlight unique chars ]]
    { "nvim-lua/popup.nvim" },
    { "tpope/vim-fugitive" },
    { "tpope/vim-rhubarb" },
    { "tpope/vim-unimpaired" },
    { "machakann/vim-sandwich" }, -- vim surround alternative
    { "mg979/vim-visual-multi" },
    { "lambdalisue/suda.vim" },
    { "sindrets/diffview.nvim", opts = { file_panel = { win_config = { position = "left" } } } },
    {
        "rhysd/accelerated-jk",
        lazy = true,
        event = "BufEnter",
    },
    {
        "max397574/better-escape.nvim",
        lazy = true,
        event = "BufEnter",
        config = function()
            require("better_escape").setup()
        end,
    },
    {
        "hrsh7th/vim-eft",
        lazy = true,
        event = "BufEnter",
    },
    {
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(require("alpha.themes.dashboard").config)
        end,
    },
    {
        "szw/vim-maximizer",
        lazy = true,
        event = "BufEnter",
        init = function()
            vim.keymap.set("n", "<leader>mm", ":MaximizerToggle!<CR>")
        end,
    }, -- maximize and restore windows
    --[[ { ]]
    --[[     "feline-nvim/feline.nvim", ]]
    --[[     lazy = true, ]]
    --[[     config = function() ]]
    --[[         require("plugins.feline.feline") ]]
    --[[     end, ]]
    --[[ }, ]]
    --[[ { "knubie/vim-kitty-navigator", build = "cp ./*.py ~/.config/kitty/" }, -- consistent navigation between vim and terminal splits ]]
    --[[ { "fladson/vim-kitty" },                                             -- syntax highlighting for Kitty config ]]
    {
        "natecraddock/workspaces.nvim",
        lazy = true,
        opts = { hooks = { open = { "NvimTreeOpen", "Telescope find_files" } } },
    },
    {
        "gabrielpoca/replacer.nvim",
        init = function()
            vim.api.nvim_set_keymap("n", "<Leader>gr", ':lua require("replacer").run()<cr>', { silent = true })
        end,
    },
    --[[ { ]]
    --[[ 	"RRethy/vim-illuminate", ]]
    --[[ 	config = function() ]]
    --[[ 		require("illuminate").configure({}) ]]
    --[[ 	end, ]]
    --[[ }, ]]
    {
        "mbbill/undotree",
        lazy = true,
        event = "BufEnter",
    },
    -- Treesitter Components
    {
        "mfussenegger/nvim-treehopper",
        lazy = true,
        event = "InsertEnter",
    },
    { "kyazdani42/nvim-web-devicons" },
    -- THEMES
    {
        "nyoom-engineering/oxocarbon.nvim",
        lazy = false,
        priority = 1000,
    },
    { "lukas-reineke/indent-blankline.nvim" }, -- indentation guides
    { "RishabhRD/nvim-cheat.sh",            dependencies = "RishabhRD/popfix" },
    -- { "nanotee/sqls.nvim", ft = "sql" },
    { "weilbith/nvim-code-action-menu" },
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    { "nvim-lua/lsp-status.nvim" }, -- generate statusline components from the LSP client.
    { "jose-elias-alvarez/typescript.nvim" },
    { "jose-elias-alvarez/null-ls.nvim" },
    { "ThePrimeagen/refactoring.nvim",     config = true },
    --[[ { "m4xshen/autoclose.nvim", opts = { {} } }, ]]
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "SmiteshP/nvim-navic",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
    },
    {
        "simrat39/symbols-outline.nvim",
        opts = { highlight_hovered_item = true },
        init = function()
            vim.keymap.set("n", "<leader>xo", "<cmd>SymbolsOutline<CR>")
        end,
    },
    { "folke/todo-comments.nvim",        dependencies = "nvim-lua/plenary.nvim",    config = true },
    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui",            dependencies = { "mfussenegger/nvim-dap" } },
    { "theHamsta/nvim-dap-virtual-text", config = true },
    { "leoluz/nvim-dap-go" },
    { "mxsdev/nvim-dap-vscode-js",       dependencies = { "mfussenegger/nvim-dap" } },
    {
        "microsoft/vscode-js-debug",
        opt = true,
        build = "npm install --legacy-peer-deps && npm run compile",
    },
    { "preservim/vim-markdown" },
    { "mattn/emmet-vim",       lazy = true, event = "BufEnter" },
    --[[ { ]]
    --[[     "Exafunction/codeium.vim", ]]
    --[[     init = function() ]]
    --[[         vim.keymap.set("i", "<c-.>", function() ]]
    --[[             return vim.fn["codeium#CycleCompletions"](1) ]]
    --[[         end, { expr = true }) ]]
    --[[         vim.keymap.set("i", "<c-,>", function() ]]
    --[[             return vim.fn["codeium#CycleCompletions"](-1) ]]
    --[[         end, { expr = true }) ]]
    --[[         vim.keymap.set("i", "<c-x>", function() ]]
    --[[             return vim.fn["codeium#Clear"]() ]]
    --[[         end, { expr = true }) ]]
    --[[         vim.keymap.set("i", "<c-cr>", function() ]]
    --[[             return vim.fn["codeium#Accept"]() ]]
    --[[         end, { expr = true }) ]]
    --[[     end, ]]
    --[[ }, ]]
}
