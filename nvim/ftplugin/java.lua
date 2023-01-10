local util = require 'lspconfig.util'
local handlers = require 'vim.lsp.handlers'

local env = {
  HOME = vim.loop.os_homedir(),
  XDG_CACHE_HOME = os.getenv 'XDG_CACHE_HOME',
  JDTLS_JVM_ARGS = os.getenv 'JDTLS_JVM_ARGS',
}

local function get_cache_dir()
  return env.XDG_CACHE_HOME and env.XDG_CACHE_HOME or util.path.join(env.HOME, '.cache')
end

local function get_jdtls_cache_dir()
  return util.path.join(get_cache_dir(), 'jdtls')
end

local function get_jdtls_config_dir()
  return util.path.join(get_jdtls_cache_dir(), 'config')
end

local function get_jdtls_workspace_dir()
  return util.path.join(get_jdtls_cache_dir(), 'workspace')
end

local function get_jdtls_jvm_args()
  local args = {}
  for a in string.gmatch((env.JDTLS_JVM_ARGS or ''), '%S+') do
    local arg = string.format('--jvm-arg=%s', a)
    table.insert(args, arg)
  end
  return unpack(args)
end

-- TextDocument version is reported as 0, override with nil so that
-- the client doesn't think the document is newer and refuses to update
-- See: https://github.com/eclipse/eclipse.jdt.ls/issues/1695
local function fix_zero_version(workspace_edit)
  if workspace_edit and workspace_edit.documentChanges then
    for _, change in pairs(workspace_edit.documentChanges) do
      local text_document = change.textDocument
      if text_document and text_document.version and text_document.version == 0 then
        text_document.version = nil
      end
    end
  end
  return workspace_edit
end

local function on_textdocument_codeaction(err, actions, ctx)
  for _, action in ipairs(actions) do
    -- TODO: (steelsojka) Handle more than one edit?
    if action.command == 'java.apply.workspaceEdit' then -- 'action' is Command in java format
      action.edit = fix_zero_version(action.edit or action.arguments[1])
    elseif type(action.command) == 'table' and action.command.command == 'java.apply.workspaceEdit' then -- 'action' is CodeAction in java format
      action.edit = fix_zero_version(action.edit or action.command.arguments[1])
    end
  end

  handlers[ctx.method](err, actions, ctx)
end

local function on_textdocument_rename(err, workspace_edit, ctx)
  handlers[ctx.method](err, fix_zero_version(workspace_edit), ctx)
end

local function on_workspace_applyedit(err, workspace_edit, ctx)
  handlers[ctx.method](err, fix_zero_version(workspace_edit), ctx)
end

-- Non-standard notification that can be used to display progress
local function on_language_status(_, result)
  local command = vim.api.nvim_command
  command 'echohl ModeMsg'
  command(string.format('echo "%s"', result.message))
  command 'echohl None'
end

local root_files = {
  -- Single-module projects
  {
    'build.xml', -- Ant
    'pom.xml', -- Maven
    'settings.gradle', -- Gradle
    'settings.gradle.kts', -- Gradle
  },
  -- Multi-module projects
  { 'build.gradle', 'build.gradle.kts' },
}

return {
  default_config = {
    cmd = {
      'jdtls',
      '-configuration',
      get_jdtls_config_dir(),
      '-data',
      get_jdtls_workspace_dir(),
      get_jdtls_jvm_args(),
    },
    filetypes = { 'java' },
    root_dir = function(fname)
      for _, patterns in ipairs(root_files) do
        local root = util.root_pattern(unpack(patterns))(fname)
        if root then
          return root
        end
      end
    end,
    single_file_support = true,
    init_options = {
      workspace = get_jdtls_workspace_dir(),
      jvm_args = {},
      os_config = nil,
    },
    handlers = {
      -- Due to an invalid protocol implementation in the jdtls we have to conform these to be spec compliant.
      -- https://github.com/eclipse/eclipse.jdt.ls/issues/376
      ['textDocument/codeAction'] = on_textdocument_codeaction,
      ['textDocument/rename'] = on_textdocument_rename,
      ['workspace/applyEdit'] = on_workspace_applyedit,
      ['language/status'] = vim.schedule_wrap(on_language_status),
      ['$/progress'] = vim.schedule_wrap(on_language_status),
    },
  },
  docs = {
    description = [[
https://projects.eclipse.org/projects/eclipse.jdt.ls

Language server for Java.

IMPORTANT: If you want all the features jdtls has to offer, [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)
is highly recommended. If all you need is diagnostics, completion, imports, gotos and formatting and some code actions
you can keep reading here.

For manual installation you can download precompiled binaries from the
[official downloads site](http://download.eclipse.org/jdtls/snapshots/?d)
and ensure that the `PATH` variable contains the `bin` directory of the extracted archive.

```lua
  -- init.lua
  require'lspconfig'.jdtls.setup{}
```

You can also pass extra custom jvm arguments with the JDTLS_JVM_ARGS environment variable as a space separated list of arguments,
that will be converted to multiple --jvm-arg=<param> args when passed to the jdtls script. This will allow for example tweaking
the jvm arguments or integration with external tools like lombok:

```sh
export JDTLS_JVM_ARGS="-javaagent:$HOME/.local/share/java/lombok.jar"
```

For automatic installation you can use the following unofficial installers/launchers under your own risk:
  - [jdtls-launcher](https://github.com/eruizc-dev/jdtls-launcher) (Includes lombok support by default)
    ```lua
      -- init.lua
      require'lspconfig'.jdtls.setup{ cmd = { 'jdtls' } }
    ```
    ]],
    default_config = {
      root_dir = [[{
        -- Single-module projects
        {
          'build.xml', -- Ant
          'pom.xml', -- Maven
          'settings.gradle', -- Gradle
          'settings.gradle.kts', -- Gradle
        },
        -- Multi-module projects
        { 'build.gradle', 'build.gradle.kts' },
      } or vim.fn.getcwd()]],
    },
  },
}
-- local home = os.getenv('HOME')
-- local jdtls = require('jdtls')
--
-- -- File types that signify a Java project's root directory. This will be
-- -- used by eclipse to determine what constitutes a workspace
-- local root_markers = {'gradlew', 'mvnw', '.git'}
-- local root_dir = require('jdtls.setup').find_root(root_markers)
--
-- -- eclipse.jdt.ls stores project specific data within a folder. If you are working
-- -- with multiple different projects, each project must use a dedicated data directory.
-- -- This variable is used to configure eclipse to use the directory name of the
-- -- current project found using the root_marker as the folder for project specific data.
-- local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
--
-- -- Helper function for creating keymaps
-- function nnoremap(rhs, lhs, bufopts, desc)
--   bufopts.desc = desc
--   vim.keymap.set("n", rhs, lhs, bufopts)
-- end
--
-- -- The on_attach function is used to set key maps after the language server
-- -- attaches to the current buffer
-- local on_attach = function(client, bufnr)
--   -- Regular Neovim LSP client keymappings
--   local bufopts = { noremap=true, silent=true, buffer=bufnr }
--   nnoremap('gD', vim.lsp.buf.declaration, bufopts, "Go to declaration")
--   nnoremap('gd', vim.lsp.buf.definition, bufopts, "Go to definition")
--   nnoremap('gi', vim.lsp.buf.implementation, bufopts, "Go to implementation")
--   nnoremap('K', vim.lsp.buf.hover, bufopts, "Hover text")
--   nnoremap('<C-k>', vim.lsp.buf.signature_help, bufopts, "Show signature")
--   nnoremap('<space>wa', vim.lsp.buf.add_workspace_folder, bufopts, "Add workspace folder")
--   nnoremap('<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts, "Remove workspace folder")
--   nnoremap('<space>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, bufopts, "List workspace folders")
--   nnoremap('<space>D', vim.lsp.buf.type_definition, bufopts, "Go to type definition")
--   nnoremap('<space>rn', vim.lsp.buf.rename, bufopts, "Rename")
--   nnoremap('<space>ca', vim.lsp.buf.code_action, bufopts, "Code actions")
--   vim.keymap.set('v', "<space>ca", "<ESC><CMD>lua vim.lsp.buf.range_code_action()<CR>",
--     { noremap=true, silent=true, buffer=bufnr, desc = "Code actions" })
--   nnoremap('<space>f', function() vim.lsp.buf.format { async = true } end, bufopts, "Format file")
--
--   -- Java extensions provided by jdtls
--   nnoremap("<C-o>", jdtls.organize_imports, bufopts, "Organize imports")
--   nnoremap("<space>ev", jdtls.extract_variable, bufopts, "Extract variable")
--   nnoremap("<space>ec", jdtls.extract_constant, bufopts, "Extract constant")
--   vim.keymap.set('v', "<space>em", [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
--     { noremap=true, silent=true, buffer=bufnr, desc = "Extract method" })
-- end
--
-- local config = {
--   flags = {
--     debounce_text_changes = 80,
--   },
--   on_attach = on_attach,  -- We pass our on_attach keybindings to the configuration map
--   root_dir = root_dir, -- Set the root directory to our found root_marker
--   -- Here you can configure eclipse.jdt.ls specific settings
--   -- These are defined by the eclipse.jdt.ls project and will be passed to eclipse when starting.
--   -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--   -- for a list of options
--   settings = {
--     java = {
--       format = {
--         settings = {
--           -- Use Google Java style guidelines for formatting
--           -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
--           -- and place it in the ~/.local/share/eclipse directory
--           url = "/.local/share/eclipse/eclipse-java-google-style.xml",
--           profile = "GoogleStyle",
--         },
--       },
--       signatureHelp = { enabled = true },
--       contentProvider = { preferred = 'fernflower' },  -- Use fernflower to decompile library code
--       -- Specify any completion options
--       completion = {
--         favoriteStaticMembers = {
--           "org.hamcrest.MatcherAssert.assertThat",
--           "org.hamcrest.Matchers.*",
--           "org.hamcrest.CoreMatchers.*",
--           "org.junit.jupiter.api.Assertions.*",
--           "java.util.Objects.requireNonNull",
--           "java.util.Objects.requireNonNullElse",
--           "org.mockito.Mockito.*"
--         },
--         filteredTypes = {
--           "com.sun.*",
--           "io.micrometer.shaded.*",
--           "java.awt.*",
--           "jdk.*", "sun.*",
--         },
--       },
--       -- Specify any options for organizing imports
--       sources = {
--         organizeImports = {
--           starThreshold = 9999;
--           staticStarThreshold = 9999;
--         },
--       },
--       -- How code generation should act
--       codeGeneration = {
--         toString = {
--           template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
--         },
--         hashCodeEquals = {
--           useJava7Objects = true,
--         },
--         useBlocks = true,
--       },
--       -- If you are developing in projects with different Java versions, you need
--       -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
--       -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--       -- And search for `interface RuntimeOption`
--       -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
--       configuration = {
--         runtimes = {
--           {
--             name = "JavaSE-17",
--             path = home .. "/.asdf/installs/java/corretto-17.0.4.9.1",
--           },
--           {
--             name = "JavaSE-11",
--             path = home .. "/.asdf/installs/java/corretto-11.0.16.9.1",
--           },
--           {
--             name = "JavaSE-1.8",
--             path = home .. "/.asdf/installs/java/corretto-8.352.08.1"
--           },
--         }
--       }
--     }
--   },
--   -- cmd is the command that starts the language server. Whatever is placed
--   -- here is what is passed to the command line to execute jdtls.
--   -- Note that eclipse.jdt.ls must be started with a Java version of 17 or higher
--   -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
--   -- for the full list of options
--   cmd = {
--     home .. "/.asdf/installs/java/corretto-17.0.4.9.1/bin/java",
--     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--     '-Dosgi.bundles.defaultStartLevel=4',
--     '-Declipse.product=org.eclipse.jdt.ls.core.product',
--     '-Dlog.protocol=true',
--     '-Dlog.level=ALL',
--     '-Xmx4g',
--     '--add-modules=ALL-SYSTEM',
--     '--add-opens', 'java.base/java.util=ALL-UNNAMED',
--     '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
--     -- If you use lombok, download the lombok jar and place it in ~/.local/share/eclipse
--     '-javaagent:' .. home .. '/.local/share/eclipse/lombok.jar',
--
--     -- The jar file is located where jdtls was installed. This will need to be updated
--     -- to the location where you installed jdtls
--     '-jar', vim.fn.glob('/opt/homebrew/Cellar/jdtls/1.18.0/libexec/plugins/org.eclipse.equinox.launcher_*.jar'),
--
--     -- The configuration for jdtls is also placed where jdtls was installed. This will
--     -- need to be updated depending on your environment
--     '-configuration', '/opt/homebrew/Cellar/jdtls/1.18.0/libexec/config_mac',
--
--     -- Use the workspace_folder defined above to store data for this project
--     '-data', workspace_folder,
--   },
-- }
--
-- -- Finally, start jdtls. This will run the language server using the configuration we specified,
-- -- setup the keymappings, and attach the LSP client to the current buffer
-- jdtls.start_or_attach(config)
