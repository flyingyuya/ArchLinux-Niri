local lsp = {}

-- For instructions on configuration, see official wiki:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
lsp = {
    ["bash-language-server"] = {
        formatter = "shfmt",
    },
    clangd = {},
    ["css-lsp"] = {
        formatter = "prettier",
        setup = {
            settings = {
                css = {
                    validate = true,
                    lint = {
                        unknownAtRules = "ignore",
                    },
                },
                less = {
                    validate = true,
                    lint = {
                        unknownAtRules = "ignore",
                    },
                },
                scss = {
                    validate = true,
                    lint = {
                        unknownAtRules = "ignore",
                    },
                },
            },
        },
    },
    ["emmet-ls"] = {
        setup = {
            filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
        },
    },
    flutter = {
        managed_by_plugin = true,
    },
    gopls = {
        formatter = "gofumpt",
        setup = {
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                },
            },
        },
    },
    ["html-lsp"] = {
        formatter = "prettier",
    },
    ["json-lsp"] = {
        formatter = "prettier",
    },
    ["lua-language-server"] = {
        formatter = "stylua",
        setup = {
            settings = {
                Lua = {
                    runtime = {
                        version = "LuaJIT",
                        path = (function()
                            local runtime_path = vim.split(package.path, ";")
                            table.insert(runtime_path, "lua/?.lua")
                            table.insert(runtime_path, "lua/?/init.lua")
                            return runtime_path
                        end)(),
                    },
                    diagnostics = {
                        globals = { "vim" },
                    },
                    hint = {
                        enable = true,
                    },
                    workspace = {
                        library = {
                            vim.env.VIMRUNTIME,
                            "${3rd}/luv/library",
                        },
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        },
    },
    omnisharp = {
        formatter = "csharpier",
        setup = {
            cmd = {
                "dotnet",
                vim.fs.joinpath(vim.fn.stdpath "data", "mason/packages/omnisharp/libexec/Omnisharp.dll"),
            },
            on_attach = function(client, _)
                client.server_capabilities.semanticTokensProvider = nil
            end,
        },
    },
    pyright = {
        formatter = "black",
    },
    rust = {
        managed_by_plugin = true,
    },
    tinymist = {
        -- Does not need a formatter as it is included in tinymist
        setup = {
            settings = {
                formatterMode = "typstyle",
                formatterPrintWidth = 120,
                formatterProseWrap = true,
            },
        },
    },
    texlab = {
        -- Optional: install `latexindent` via mason for formatting (requires perl)
        -- formatter = "latexindent",
        -- Optional: chktex linting on open/save (requires `chktex` on system, Arch: part of texlive-binextra)
        setup = {
            settings = {
                texlab = {
                    chktex = {
                        onOpenAndSave = true,
                        onEdit = false,
                    },
                },
            },
        },
    },
    ["typescript-language-server"] = {
        formatter = "prettier",
        setup = {
            root_dir = function(_, on_dir)
                on_dir(require("core.utils").get_root())
            end,
            flags = lsp.flags,
            on_attach = function(client)
                if #vim.lsp.get_clients { name = "denols" } > 0 then
                    client.stop()
                end
            end,
        },
    },
    verible = {
        formatter = "verible_verilog_format",
        setup = {
            -- 默认 root_markers 为 { ".git" },这里改用 get_root 以便在任意目录都能启动
            root_dir = function(_, on_dir)
                on_dir(require("core.utils").get_root())
            end,
            cmd = { "verible-verilog-ls", "--rules_config_search" },
        },
    },
}

-- 批量启用全部语言服务
-- (见 docs/customization/plugins.md)
for _, name in pairs(vim.tbl_keys(lsp)) do
    lsp[name].enabled = true
end

-- 平时不用的语言单独关闭(Go / C#)
lsp.gopls.enabled = false
lsp.omnisharp.enabled = false

Ice.lsp = lsp
