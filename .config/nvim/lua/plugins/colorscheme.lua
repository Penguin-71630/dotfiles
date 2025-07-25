return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_colors = function(colors)
        local wal_colors = {}
        local wal_path = vim.fn.expand("~/.cache/wal/colors.sh")

        local file = io.open(wal_path, "r")
        if file then
          for line in file:lines() do
            local key, value = line:match("^(%w+)=['\"]?(#%x+)['\"]?$")
            if key and value then
              wal_colors[key] = value
            end
          end
          file:close()
        end

        colors.bg = wal_colors.background or colors.bg
        colors.bg_dark = wal_colors.color0 or colors.bg_dark
        colors.bg_float = wal_colors.color0 or colors.bg_float
        colors.bg_sidebar = wal_colors.color0 or colors.bg_sidebar
        colors.fg = wal_colors.foreground or colors.fg
        colors.fg_dark = wal_colors.color8 or colors.fg_dark
        colors.comment = wal_colors.color8 or colors.comment
        colors.hint = wal_colors.color4 or colors.hint
        colors.error = wal_colors.color1 or colors.error
        colors.warning = wal_colors.color3 or colors.warning
        colors.info = wal_colors.color4 or colors.info
        colors.git = {
          change = wal_colors.color5 or colors.git.change,
          add = wal_colors.color2 or colors.git.add,
          delete = wal_colors.color1 or colors.git.delete,
        }
      end,
      -- on_highlights = function(highlights, c)
      --   local my_magenta = "#bf2162"
      --   local my_blue = "#3ab2f2"
      --   local my_light_green = "#73d45d"
      --   highlights["@number"] = { fg = c.magenta }
      --   highlights["@boolean"] = { fg = c.magenta }
      --   highlights["@keyword"] = {
      --     fg = my_magenta,
      --     style = { italic = true, bold = true },
      --   }
      --   highlights["@operator"] = { fg = c.yellow }
      --   highlights["@type.builtin"] = {
      --     fg = my_magenta,
      --     style = { italic = true, bold = true },
      --   }
      --   highlights["@function"] = { fg = my_light_green }
      --   highlights["@keyword.repeat"] = {
      --     fg = my_blue,
      --     style = { bold = true },
      --   }
      --   highlights["@keyword.conditional"] = {
      --     fg = my_blue,
      --     style = { bold = true },
      --   }
      --   highlights.Constant = { fg = c.white }
      -- end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#000000", -- 原本你寫成 5 個 0
    },
  },
}
