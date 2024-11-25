-- Updated keybindings section for your config
local function keymapOptions(desc)
    return {
        noremap = true,
        silent = true,
        nowait = true,
        desc = "GPT: " .. desc,
    }
end

-- Chat-specific commands
vim.keymap.set({"n", "i"}, "<C-g>n", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
vim.keymap.set({"n", "i"}, "<C-g>t", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
vim.keymap.set({"n", "i"}, "<C-g>f", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))
vim.keymap.set({"n", "i"}, "<C-g>l", "<cmd>GpChatRespond<cr>", keymapOptions("Chat Response")) -- 'l' for 'last/latest'
vim.keymap.set({"n", "i"}, "<C-g>u", "<cmd>lua require('gp').cmd.ChatTitle()<cr>", keymapOptions("Update Chat Title"))

-- Chat layouts
vim.keymap.set({"n", "i"}, "<C-g><C-n>", "<cmd>GpChatNew split<cr>", keymapOptions("New Chat Split"))
vim.keymap.set({"n", "i"}, "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat VSplit"))
vim.keymap.set({"n", "i"}, "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions("New Chat Tab"))
vim.keymap.set({"n", "i"}, "<C-g><C-f>", "<cmd>GpChatFinder tabnew<cr>", keymapOptions("Chat Finder Tab"))

-- Visual mode chat commands
vim.keymap.set("v", "<C-g>n", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual New Chat"))
vim.keymap.set("v", "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))
vim.keymap.set("v", "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Toggle Chat"))

-- Chat with window splits (visual mode)
vim.keymap.set("v", "<C-g><C-n>", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions("Visual Chat Split"))
vim.keymap.set("v", "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions("Visual Chat VSplit"))

-- Iron.nvim keybinds
vim.keymap.set('n', '<leader>is', ':IronRepl<CR>', { noremap = true, silent = true, desc = "Start Iron REPL" })
vim.keymap.set('n', '<leader>ir', ':IronRestart<CR>', { noremap = true, silent = true, desc = "Restart Iron REPL" })
vim.keymap.set('n', '<leader>if', ':IronFocus<CR>', { noremap = true, silent = true, desc = "Focus Iron REPL" })
vim.keymap.set('n', '<leader>ih', ':IronHide<CR>', { noremap = true, silent = true, desc = "Hide Iron REPL" })

-- Vim-test keybinds
vim.keymap.set('n', '<leader>tn', ':TestNearest<CR>', { noremap = true, silent = true, desc = "Run Nearest Test" })
vim.keymap.set('n', '<leader>tf', ':TestFile<CR>', { noremap = true, silent = true, desc = "Run Test File" })
vim.keymap.set('n', '<leader>ts', ':TestSuite<CR>', { noremap = true, silent = true, desc = "Run Test Suite" })
vim.keymap.set('n', '<leader>tl', ':TestLast<CR>', { noremap = true, silent = true, desc = "Run Last Test" })
vim.keymap.set('n', '<leader>tv', ':TestVisit<CR>', { noremap = true, silent = true, desc = "Visit Test File" })

-- Run Python script and close terminal when finished
vim.keymap.set('n', '<leader>rp', ':split | terminal python % && exit<CR>', { noremap = true, silent = true, desc = "Run Python and close on finish" })

-- Force close terminal
vim.keymap.set('n', '<leader>tc', ':bd!<CR>', { noremap = true, silent = true, desc = "Force close terminal" })




-- chat.vim keybinds
-- vim.keymap.set('n', '<leader>cc', ':Chat<CR>', { noremap = true, silent = true, desc = "Open Chat" })
-- vim.keymap.set('n', '<C-g>', ':call LLMResponse()<CR>', { noremap = true, silent = true, desc = "Chat LLM Response" })
-- vim.keymap.set('v', '<C-g>', ':call LLMResponse()<CR>', { noremap = true, silent = true, desc = "Chat LLM Response (Visual)" })


