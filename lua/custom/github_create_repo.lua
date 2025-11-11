-- 🧩 Plugin: GitHub Repo Creator para LazyVim
-- Autor: ChatGPT (ajustado para Datzten)
-- Cria automaticamente um repositório GitHub a partir do seu projeto atual.

vim.api.nvim_create_user_command("CreateGitHubRepo", function()
  local cwd = vim.fn.getcwd()
  local folder = vim.fn.fnamemodify(cwd, ":t")

  -- Pergunta nome e visibilidade
  local repo_name = vim.fn.input("Nome do repositório GitHub (default: " .. folder .. "): ")
  if repo_name == "" then
    repo_name = folder
  end

  local visibility = vim.fn.input("Repositório público? (y/n): ")
  local visibility_flag = (visibility == "y" or visibility == "Y") and "--public" or "--private"

  -- Cria README.md se não existir
  local readme_path = cwd .. "/README.md"
  if vim.fn.filereadable(readme_path) == 0 then
    local readme = io.open(readme_path, "w")
    readme:write("# " .. repo_name .. "\n\nCriado automaticamente pelo LazyVim 🚀\n")
    readme:close()
  end

  -- Cria .gitignore básico se não existir
  local gitignore_path = cwd .. "/.gitignore"
  if vim.fn.filereadable(gitignore_path) == 0 then
    local gitignore = io.open(gitignore_path, "w")
    gitignore:write([[
# Diretórios comuns
node_modules/
dist/
build/
.vscode/
.DS_Store
.env
]])
    gitignore:close()
  end

  -- Inicializa repositório git se não existir
  if vim.fn.isdirectory(cwd .. "/.git") == 0 then
    vim.fn.system("git init")
    vim.fn.system("git add .")
    vim.fn.system('git commit -m "Primeiro commit automático 🚀"')
  end

  -- Remove remoto antigo se houver
  local remotes = vim.fn.systemlist("git remote")
  if vim.tbl_contains(remotes, "origin") then
    vim.fn.system("git remote remove origin")
  end

  -- Verifica se o GitHub CLI está instalado
  if vim.fn.executable("gh") == 0 then
    vim.notify(
      "❌ GitHub CLI (gh) não encontrado.\nInstale com: brew install gh | sudo apt install gh | winget install GitHub.cli",
      vim.log.levels.ERROR
    )
    return
  end

  -- Cria repositório remoto no GitHub
  local create_cmd = string.format("gh repo create %s %s --source=. --remote=origin --push", repo_name, visibility_flag)
  local output = vim.fn.system(create_cmd)

  if vim.v.shell_error ~= 0 then
    vim.notify("❌ Erro ao criar repositório:\n" .. output, vim.log.levels.ERROR)
    return
  end

  -- Força branch main
  vim.fn.system("git branch -M main")

  -- Push final
  local push_output = vim.fn.system("git push -u origin main")
  vim.notify("✅ Repositório criado com sucesso!\n" .. push_output, vim.log.levels.INFO)
end, {
  desc = "Cria e envia um repositório GitHub automaticamente",
})
