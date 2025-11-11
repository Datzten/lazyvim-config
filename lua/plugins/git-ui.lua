return {
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Abrir LazyGit" },
    },
    config = function()
      -- Configuração opcional do LazyGit
      vim.g.lazygit_floating_window_winblend = 0 -- transparência
      vim.g.lazygit_floating_window_scaling_factor = 0.9
      vim.g.lazygit_floating_window_use_plenary = 1 -- usa janela flutuante elegante
      vim.g.lazygit_use_neovim_remote = 1 -- integração nvim-remote
    end,
  },
}
