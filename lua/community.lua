-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- { import = "astrocommunity.pack.lua" },
  -- { import = "astrocommunity.recipes.heirline-mode-text-statusline" },
  -- { import = "astrocommunity.editing-support.conform-nvim" },
  { import = "astrocommunity.completion.copilot-cmp" },
  -- { import = "astrocommunity.completion.codeium-nvim" },
  { import = "astrocommunity.utility.noice-nvim" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.git.diffview-nvim" },
  -- { import = "astrocommunity.pack.vue" },
  -- { import = "astrocommunity.pack.php" },
  { import = "astrocommunity.pack.blade" },
  { import = "astrocommunity.recipes.neovide" },
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },
  { import = "astrocommunity.recipes.telescope-nvchad-theme" },
  { import = "astrocommunity.color.modes-nvim" },
  { import = "astrocommunity.syntax.vim-easy-align" },
  -- { import = "astrocommunity.indent.indent-rainbowline" },
  { import = "astrocommunity.scrolling.vim-smoothie" },
  { import = "astrocommunity.scrolling.nvim-scrollbar" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  -- { import = "astrocommunity.editing-support.undotree" },
  -- { import = "astrocommunity.colorscheme.github-nvim-theme" },
  -- { import = "astrocommunity.keybinding.nvcheatsheet-nvim" },
  -- { import = "astrocommunity.terminal-integration.vim-tmux-navigator" },
  -- import/override with your plugins folder
}
