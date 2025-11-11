return {
  "barrett-ruth/live-server.nvim",
  build = "npm install -g live-server", -- instala automaticamente o live-server globalmente
  config = function()
    require("live-server").setup({
      port = 5500, -- porta padrão
      browser_command = "", -- use navegador padrão do sistema
      quiet = false,
    })
  end,
}
