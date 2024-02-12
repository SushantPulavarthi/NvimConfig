return {
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("neorg").setup {
                load = {
                    ["core.defaults"] = {}, -- Loads default behaviour
                    ["core.concealer"] = {
                        config = {
                            icon_preset = "basic",
                        },
                    },        -- Adds pretty icons to your documents
                    ["core.dirman"] = { -- Manages Neorg workspaces
                        config = {
                            workspaces = {
                                notes = "~/Notes",
                            },
                        },
                    },
                    ["core.summary"] = {},
                    ["core.completion"] = {
                        config = {
                            engine = "nvim-cmp",
                        }
                    },
                    ["core.keybinds"] = {
                        config = {
                            hook = function(keybinds)
                                local local_leader = keybinds.leader
                                keybinds.map_to_mode("all", {
                                    n = {
                                        { local_leader .. "gi", ":Neorg index<CR>", opts = { desc = "Go to index" } },
                                    },
                                })
                            end,
                        },
                    },
                },
            }
        end,
    },
}
