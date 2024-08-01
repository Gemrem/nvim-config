return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
        vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        vim.keymap.set('n', '<leader>fc', builtin.colorscheme, {})

        -- Git mappings
        vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
        vim.keymap.set('n', '<leader>gh', builtin.git_commits, {})
        vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})

        local state = require("telescope.state")
        local action_state = require("telescope.actions.state")

        local slow_scroll = function(prompt_bufnr, direction)
            local previewer = action_state.get_current_picker(prompt_bufnr).previewer
            local status = state.get_status(prompt_bufnr)

            -- Check if we actually have a previewer and a preview window
            if type(previewer) ~= "table" or previewer.scroll_fn == nil or status.preview_win == nil then
                return
            end

            previewer:scroll_fn(1 * direction)
        end

        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = function(bufnr) slow_scroll(bufnr, 1) end,
                        ["<C-k>"] = function(bufnr) slow_scroll(bufnr, -1) end,
                    },
                    n = {
                        ["<C-j>"] = function(bufnr) slow_scroll(bufnr, 1) end,
                        ["<C-k>"] = function(bufnr) slow_scroll(bufnr, -1) end,
                    },
                },
            },
        })
    end
}

