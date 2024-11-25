-- lua/plugins/gp.lua
return {
    "robitx/gp.nvim",
    config = function()
        local home = vim.fn.expand("~")
        local chat_vault_dir = home .. "/Documents/chat-vault"

        require("gp").setup({
            providers = {
                openai = {
                    secret = os.getenv("OPENAI_API_KEY") or os.getenv("OPENAI_KEY"),
                },
                anthropic = {
                    endpoint = "https://api.anthropic.com/v1/messages",
                    secret = os.getenv("ANTHROPIC_API_KEY") or os.getenv("ANTHROPIC_KEY"),
                    api_headers = {
                        ["anthropic-version"] = "2024-02-29", -- Updated to latest API version
                        ["content-type"] = "application/json",
                    },
                    -- Specify response format for Anthropic
                    parameters = {
                        max_tokens = 4000,
                        temperature = 0.7,
                    },
                },
            },

            storage = {
                chat_dir = chat_vault_dir .. "/chats",
                -- Specify default file type for new buffers
                default_filetype = "markdown",
            },

            chat_topic_gen_model = "gpt-4-turbo-preview",
            chat_confirm_delete = true,
            chat_max_messages = 100,
            chat_shortcuts_enabled = true,

            -- Define default target behavior
            default_target = {
                type = 4, -- enew by default
                filetype = "markdown",
            },

            agents = {
                {
                    name = "ChatGPT4-Turbo",
                    provider = "openai",
                    model = "gpt-4-turbo-preview",
                    chat = true,
                    system_prompt = "You are a helpful assistant with a focus on clear, accurate responses.",
                },
                {
                    name = "Claude3.5-Sonnet",
                    provider = "anthropic",
                    model = "claude-3-5-sonnet-20241022",
                    chat = true,
                    system_prompt = "You are a helpful assistant with a focus on clear, accurate responses.",
                    parameters = {
                        max_tokens = 4000,
                        temperature = 0.7,
                    },
                    -- For Anthropic, system prompt needs to be part of the first message
                    messages = {
                        {
                            role = "user",
                            content = "You are a helpful assistant focusing on efficient, practical responses. Please acknowledge this role.",
                        },
                    },
                },
                -- Additional agents with similar structure...
                {
                    name = "CodeAssist",
                    provider = "anthropic",
                    model = "claude-3-5-sonnet-20241022",
                    chat = false,
                    system_prompt = "You are a helpful assistant with a focus on clear, accurate responses.",
                    parameters = {
                        max_tokens = 4000,
                        temperature = 0.7,
                    },
                    messages = {
                        {
                            role = "user",
                            content = "You are a coding assistant. Provide clear, efficient, and well-documented solutions. Please acknowledge this role.",
                        },
                    },
                },
            },

            -- Add hooks for custom behavior
            hooks = {
                -- Example hook for markdown output
                MarkdownChat = function(gp, params)
                    local agent = gp.get_chat_agent()
                    gp.cmd.ChatNew(params, nil, agent, gp.Target.enew("markdown"))
                end,
            },
        })
    end,
}
