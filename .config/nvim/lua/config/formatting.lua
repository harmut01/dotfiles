return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      log_level = vim.log.levels.DEBUG,
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        groovy = { "npm-groovy-lint" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "markdownlint", "prettierd" },
        graphql = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
      },
      format_on_save = function(bufnr)
        local name = vim.api.nvim_buf_get_name(bufnr)
        local ext = name:match("^.+%.([^.]+)$")

        local skip_exts = {
          c = true,
          cpp = true,
          h = true,
          S = true,
          rst = true,
        }

        if ext and skip_exts[ext] then
          return false
        end

        return {
          lsp_fallback = true,
          timeout_ms = 500,
        }
      end,
    })

    -- Format the current buffer only when the user hits <leader>mf
    vim.keymap.set("n", "<leader>cf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = "Format current file" })
  end,
}
