-- {{{ LSP

  -- {{{ lspconfig
  -- Setup language servers
  local lspconfig = require('lspconfig')
  -- }}}
  -- {{{ Python
  lspconfig.pyright.setup {}
  -- }}}
  -- {{{ TypeScript
  lspconfig.tsserver.setup {}
  -- }}}
  -- {{{ Bicep
  local bicep_lsp_bin = "/usr/local/bin/bicep-langserver/Bicep.LangServer.dll"
  vim.cmd [[ autocmd BufNewFile,BufRead *.bicep set filetype=bicep ]]
  vim.cmd [[ autocmd BufNewFile,BufRead *.bicepparam set filetype=bicep ]]
  require'lspconfig'.bicep.setup{
      cmd = { "dotnet", bicep_lsp_bin };
      ...
  }
  -- }}}
  -- {{{ Lua
  lspconfig.lua_ls.setup {
    on_init = function(client)
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
        return
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using
          -- (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT'
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
            -- Depending on the usage, you might want to add additional paths here.
            -- "${3rd}/luv/library"
            -- "${3rd}/busted/library",
          }
          -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
          -- library = vim.api.nvim_get_runtime_file("", true)
        }
      })
    end,
    settings = {
      Lua = {}
    }
  }
  -- }}}
  -- {{{ Rust
  lspconfig.rust_analyzer.setup {
    -- Server-specific settings. See `:help lspconfig-setup
    settings = {
      ['rust-analyzer'] = {}
    }
  }
  -- }}}

  -- {{{ Keybinds
  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
      vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format { async = true }
      end, opts)
    end,
  })
  -- }}}

-- }}}
-- {{{ GPT
  -- {{{ Config
  local gptconf = {
    openai_api_key = os.getenv("OPENAI_API_KEY"),
    agents = {
      {
        name = "ChatGPT3-5", -- Only name disables ChatGPT3.5
      },
      {
        name = "ChatGPT4",
        chat = true,
        command = false,
        model = { model = "gpt-4-0125-preview", temperature = 1.0, top_p = 1 },

        system_prompt = [[
You are an AI designed to support a seasoned developer with in-depth tech insight across various domains, including but not limited to containerization, cloud computing, and software architecture. The user has a strong command line preference, requires concise and precise answers that bypass basic conventions, and seeks a foundational understanding over high-level summaries.

**Response Guidance:**
- **Present concise, accurate insights with a priority on depth and CLI-centric solutions**. Ensure responses are tailored to an experienced audience, skipping basic explanations.
- **Include code snippets or commands when coding or CLI interaction is primary**, maintaining clarity and direct applicability. Prefer self-documenting principles for code snippets or commands. Omit basic code snippets or commands if this is secondary to the task at hand.
- **Always gauge the user's expectaions of response length and respond appropriately**. Favor short and to-the-point responses if the user is commanding, makes direct requests or otherwise indicate that an explaination is not warranted. Shorten responses by omitting basic explainations where appropriate
- **When delving into new or complex topics, offer foundational perspectives over superficial summaries**.
- **Adapt responses to include emerging technologies where relevant**, staying abreast of the latest innovations in the covered domains. Highlight noteworthy shifts or advancements that could influence best practices or introduce new solutions to common problems.
- **Recommend pertinent resources or theoretical principles in situations of ambiguity or extensive depth**, preferring actionable starting points. Include links to authoritative resources, documentation, and further reading materials that are recognized for their reliability and comprehensiveness.

**Expectations:**
- Responses should be applicable in a Linux CLI context, reflecting the user's preference and professional environment.
- Guidance should reflect the latest technological trends, updates, and best practices within the specified domains.
- **Facilitate a deeper understanding** when addressing new or complex topics by grounding explanations in theoretical fundamentals and offering resources for further exploration.

This streamlined guidance aims to match the user's demand for thorough, practical input while ensuring essential coding elements are not omitted.
]],
      },
    },
  }
  -- }}}
  -- {{{ Setup
  require("gp").setup(gptconf)
  -- }}}
  -- {{{ Keybinds
  local function keymapOptions(desc)
      return {
          noremap = true,
          silent = true,
          nowait = true,
          desc = "GPT prompt " .. desc,
      }
  end

  -- Chat commands
  vim.keymap.set({"n", "i"}, "<C-g>c", "<cmd>GpChatNew<cr>", keymapOptions("New Chat"))
  vim.keymap.set({"n", "i"}, "<C-g>t", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
  vim.keymap.set({"n", "i"}, "<C-g>f", "<cmd>GpChatFinder<cr>", keymapOptions("Chat Finder"))

  vim.keymap.set("v", "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions("Visual Chat New"))
  vim.keymap.set("v", "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions("Visual Chat Paste"))
  vim.keymap.set("v", "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions("Visual Toggle Chat"))

  vim.keymap.set({ "n", "i" }, "<C-g><C-x>", "<cmd>GpChatNew split<cr>", keymapOptions("New Chat split"))
  vim.keymap.set({ "n", "i" }, "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat vsplit"))
  vim.keymap.set({ "n", "i" }, "<C-g><C-q>", "<cmd>GpChatNew vsplit<cr>", keymapOptions("New Chat vsplit")) -- For windows terminals (C-v collides)
  vim.keymap.set({ "n", "i" }, "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions("New Chat tabnew"))

  vim.keymap.set("v", "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions("Visual Chat New split"))
  vim.keymap.set("v", "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions("Visual Chat New vsplit"))
  vim.keymap.set("v", "<C-g><C-q>", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions("Visual Chat New vsplit")) -- For windows terminal (C-v collides)
  vim.keymap.set("v", "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions("Visual Chat New tabnew"))

  -- Prompt commands
  vim.keymap.set({"n", "i"}, "<C-g>r", "<cmd>GpRewrite<cr>", keymapOptions("Inline Rewrite"))
  vim.keymap.set({"n", "i"}, "<C-g>a", "<cmd>GpAppend<cr>", keymapOptions("Append (after)"))
  vim.keymap.set({"n", "i"}, "<C-g>b", "<cmd>GpPrepend<cr>", keymapOptions("Prepend (before)"))

  vim.keymap.set("v", "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
  vim.keymap.set("v", "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", keymapOptions("Visual Append (after)"))
  vim.keymap.set("v", "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions("Visual Prepend (before)"))
  vim.keymap.set("v", "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("Implement selection"))

  vim.keymap.set({"n", "i"}, "<C-g>gp", "<cmd>GpPopup<cr>", keymapOptions("Popup"))
  vim.keymap.set({"n", "i"}, "<C-g>ge", "<cmd>GpEnew<cr>", keymapOptions("GpEnew"))
  vim.keymap.set({"n", "i"}, "<C-g>gn", "<cmd>GpNew<cr>", keymapOptions("GpNew"))
  vim.keymap.set({"n", "i"}, "<C-g>gv", "<cmd>GpVnew<cr>", keymapOptions("GpVnew"))
  vim.keymap.set({"n", "i"}, "<C-g>gt", "<cmd>GpTabnew<cr>", keymapOptions("GpTabnew"))

  vim.keymap.set("v", "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions("Visual Popup"))
  vim.keymap.set("v", "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", keymapOptions("Visual GpEnew"))
  vim.keymap.set("v", "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", keymapOptions("Visual GpNew"))
  vim.keymap.set("v", "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", keymapOptions("Visual GpVnew"))
  vim.keymap.set("v", "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", keymapOptions("Visual GpTabnew"))

  vim.keymap.set({"n", "i"}, "<C-g>x", "<cmd>GpContext<cr>", keymapOptions("Toggle Context"))
  vim.keymap.set("v", "<C-g>x", ":<C-u>'<,'>GpContext<cr>", keymapOptions("Visual Toggle Context"))

  vim.keymap.set({"n", "i", "v", "x"}, "<C-g>s", "<cmd>GpStop<cr>", keymapOptions("Stop"))
  vim.keymap.set({"n", "i", "v", "x"}, "<C-g>n", "<cmd>GpNextAgent<cr>", keymapOptions("Next Agent"))

  -- optional Whisper commands with prefix <C-g>w
  vim.keymap.set({"n", "i"}, "<C-g>ww", "<cmd>GpWhisper<cr>", keymapOptions("Whisper"))
  vim.keymap.set("v", "<C-g>ww", ":<C-u>'<,'>GpWhisper<cr>", keymapOptions("Visual Whisper"))

  vim.keymap.set({"n", "i"}, "<C-g>wr", "<cmd>GpWhisperRewrite<cr>", keymapOptions("Whisper Inline Rewrite"))
  vim.keymap.set({"n", "i"}, "<C-g>wa", "<cmd>GpWhisperAppend<cr>", keymapOptions("Whisper Append (after)"))
  vim.keymap.set({"n", "i"}, "<C-g>wb", "<cmd>GpWhisperPrepend<cr>", keymapOptions("Whisper Prepend (before) "))

  vim.keymap.set("v", "<C-g>wr", ":<C-u>'<,'>GpWhisperRewrite<cr>", keymapOptions("Visual Whisper Rewrite"))
  vim.keymap.set("v", "<C-g>wa", ":<C-u>'<,'>GpWhisperAppend<cr>", keymapOptions("Visual Whisper Append (after)"))
  vim.keymap.set("v", "<C-g>wb", ":<C-u>'<,'>GpWhisperPrepend<cr>", keymapOptions("Visual Whisper Prepend (before)"))

  vim.keymap.set({"n", "i"}, "<C-g>wp", "<cmd>GpWhisperPopup<cr>", keymapOptions("Whisper Popup"))
  vim.keymap.set({"n", "i"}, "<C-g>we", "<cmd>GpWhisperEnew<cr>", keymapOptions("Whisper Enew"))
  vim.keymap.set({"n", "i"}, "<C-g>wn", "<cmd>GpWhisperNew<cr>", keymapOptions("Whisper New"))
  vim.keymap.set({"n", "i"}, "<C-g>wv", "<cmd>GpWhisperVnew<cr>", keymapOptions("Whisper Vnew"))
  vim.keymap.set({"n", "i"}, "<C-g>wt", "<cmd>GpWhisperTabnew<cr>", keymapOptions("Whisper Tabnew"))

  vim.keymap.set("v", "<C-g>wp", ":<C-u>'<,'>GpWhisperPopup<cr>", keymapOptions("Visual Whisper Popup"))
  vim.keymap.set("v", "<C-g>we", ":<C-u>'<,'>GpWhisperEnew<cr>", keymapOptions("Visual Whisper Enew"))
  vim.keymap.set("v", "<C-g>wn", ":<C-u>'<,'>GpWhisperNew<cr>", keymapOptions("Visual Whisper New"))
  vim.keymap.set("v", "<C-g>wv", ":<C-u>'<,'>GpWhisperVnew<cr>", keymapOptions("Visual Whisper Vnew"))
  vim.keymap.set("v", "<C-g>wt", ":<C-u>'<,'>GpWhisperTabnew<cr>", keymapOptions("Visual Whisper Tabnew"))
  -- }}}
-- }}}
-- {{{ Git
require('gitsigns').setup()
-- }}}
-- {{{ Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- }}}
