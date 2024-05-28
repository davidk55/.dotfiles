local function prompt_url()
  local co = coroutine.running()
  return coroutine.create(function()
    vim.ui.input({
      prompt = "Enter URL: ",
      default = "http://localhost:3000",
    }, function(url)
      if url == nil or url == "" then
        return
      else
        coroutine.resume(co, url)
      end
    end)
  end)
end
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "jbyuki/one-small-step-for-vimkind",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local dapvt = require("nvim-dap-virtual-text")
    -- =============== SETUP ===============
    dapui.setup()
    dapvt.setup()

    -- =============== DAP UI ===============
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- =============== DEBUG ADAPTERS ===============
    dap.adapters.chrome = {
      type = "executable",
      command = "/home/david/.local/share/nvim/mason/packages/chrome-debug-adapter/chrome-debug-adapter",
    }
    dap.adapters.firefox = {
      type = "executable",
      command = "/home/david/.local/share/nvim/mason/packages/firefox-debug-adapter/firefox-debug-adapter",
    }
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = {
          "/home/david/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
          "${port}",
        },
      },
    }
    dap.adapters.php = {
      type = "executable",
      command = "/home/david/.local/share/nvim/mason/packages/php-debug-adapter/php-debug-adapter",
    }
    dap.adapters.lldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = "/home/david/.local/share/nvim/mason/packages/codelldb/codelldb",
        args = { "--port", "${port}" },
      },
    }
    dap.adapters.python = function(cb, config)
      if config.request == "attach" then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or "127.0.0.1"
        cb({
          type = "server",
          port = assert(port, "`connect.port` is required for a python `attach` configuration"),
          host = host,
          options = {
            source_filetype = "python",
          },
        })
      else
        local virtenvs_path = "/home/david/.local/share/virtualenvs/"
        local cmd = vim.system({ "ls", virtenvs_path }, { text = true }):wait()
        local stdout = cmd.stdout
        local virtenvs = {}
        local msg = "Select Project:\n"
        local counter = 1
        if stdout == nil then
          return
        end
        for s in stdout:gmatch("[^\r\n]+") do
          table.insert(virtenvs, s)
          msg = msg .. "[" .. counter .. "] " .. s .. "\n"
          counter = counter + 1
        end
        print(msg)
        local inp = vim.fn.input(msg)
        local selected = virtenvs[tonumber(inp)]

        cb({
          type = "executable",
          command = virtenvs_path .. selected .. "/bin/python",
          args = { "-m", "debugpy.adapter" },
          options = {
            source_filetype = "python",
          },
        })
      end
    end
    dap.adapters.nlua = function(callback, config)
      callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
    end
    dap.adapters.bashdb = {
      type = "executable",
      command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
      name = "bashdb",
    }
    dap.adapters.delve = {
      type = "server",
      port = "${port}",
      executable = {
        command = "dlv",
        args = { "dap", "-l", "127.0.0.1:${port}" },
      },
    }
    -- =============== DAP CONFIGURATIONS ===============
    local js_based_languages = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
    for _, language in ipairs(js_based_languages) do
      require("dap").configurations[language] = {
        {
          type = "chrome",
          request = "launch",
          sourceMaps = true,
          name = "[DAP] Chromium",
          webRoot = "${workspaceFolder}",
          runtimeExecutable = "/bin/chromium",
          url = prompt_url,
        },
        {
          type = "firefox",
          request = "launch",
          name = "[DAP] Firefox",
          webRoot = "${workspaceFolder}",
          url = prompt_url,
          reAttach = true, -- will keep firefox running when the debugging process is finished (so you can attach later)
          firefoxExecutable = "/usr/bin/firefox",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "[DAP] Node",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "[DAP] Node Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end
    dap.configurations.php = {
      {
        type = "php",
        request = "launch",
        name = "[DAP] Single File",
        program = "${file}",
        cwd = "${fileDirname}",
        port = 0,
        runtimeArgs = { "-dxdebug.start_with_request=yes" },
        env = {
          XDEBUG_MODE = "debug,develop",
          XDEBUG_CONFIG = "client_port=${port}",
        },
      },
    }
    dap.configurations.cpp = {
      {
        name = "[DAP] Launch LLDB",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = {},
        console = "integratedTerminal",
      },
    }
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          local cwd = vim.fn.getcwd()
          if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
            return cwd .. "/venv/bin/python"
          elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
            return cwd .. "/.venv/bin/python"
          else
            return "/usr/bin/python"
          end
        end,
      },
    }
    dap.configurations.lua = {
      {
        type = "nlua",
        request = "attach",
        name = "Attach to running Neovim instance",
      },
    }
    dap.configurations.sh = {
      {
        type = "bashdb",
        request = "launch",
        name = "Launch file",
        showDebugOutput = true,
        pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
        pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
        trace = true,
        file = "${file}",
        program = "${file}",
        cwd = function()
          local path = vim.fn.input("Path where to execute: ")
          if path == nil or path == "" then
            return "${workspaceFolder}"
          end
          return path
        end,
        pathCat = "cat",
        pathBash = "/bin/bash",
        pathMkfifo = "mkfifo",
        pathPkill = "pkill",
        args = function()
          local args = {}
          local inp = vim.fn.input("Arguments: ")
          for i in string.gmatch(inp, "%S+") do
            table.insert(args, i)
          end
          vim.print(args)
          return args
        end,
        env = {},
        terminalKind = "integrated",
      },
    }
    dap.configurations.go = {
      {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}",
      },
      {
        type = "delve",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}",
      },
      -- works with go.mod packages and sub packages
      {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}",
      },
    }

    -- =============== MAPPINGS ===============
    vim.keymap.set("n", "<F5>", function()
      require("dap").continue()
    end, { noremap = true, desc = "[dap] Begin session or continue to next breakpoint" })
    vim.keymap.set("n", "<F6>>", function()
      require("dap").step_over()
    end, { noremap = true, desc = "[dap] Step over" })
    vim.keymap.set("n", "<F7>", function()
      require("dap").step_into()
    end, { noremap = true, desc = "[dap] Step into" })
    vim.keymap.set("n", "<F8>", function()
      require("dap").step_out()
    end, { noremap = true, desc = "[dap] Step out" })
    vim.keymap.set("n", "<Leader>b", function()
      require("dap").toggle_breakpoint()
    end, { noremap = true, desc = "[dap] Toggle breakpoint" })
    vim.keymap.set("n", "<Leader>B", function()
      require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end, { noremap = true, desc = "[dap] Set break point with message" })
    vim.keymap.set("n", "<Leader>dd", function()
      require("dapui").toggle({ reset = true })
    end, { noremap = true, desc = "[dap] Toggle the ui" })
    vim.keymap.set("n", "<Leader>dr", function()
      require("dapui").open({ reset = true })
    end, { noremap = true, desc = "[dap] Reset the ui" })
    vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
      require("dap.ui.widgets").hover()
    end, { noremap = true, desc = "[dap] Show ui widget" })
    vim.keymap.set("n", "<Leader>ds", function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.scopes)
    end, { noremap = true, desc = "[dap] Show floating scope widget" })
    vim.keymap.set("n", "<Leader>df", function()
      local widgets = require("dap.ui.widgets")
      widgets.centered_float(widgets.frames)
    end, { noremap = true, desc = "[dap] Show floating frames widget" })
    vim.keymap.set("n", "<Leader>da", function()
      if vim.fn.filereadable(".vscode/launch.json") then
        local dap_vscode = require("dap.ext.vscode")
        dap_vscode.load_launchjs(nil, {
          ["firefox"] = js_based_languages,
          ["chrome"] = js_based_languages,
          ["pwa-node"] = js_based_languages,
        })
        vim.notify("[dap] A launch.json has been found and added", vim.log.levels.INFO)
      else
        vim.notify("[dap] No launch.json found", vim.log.levels.INFO)
      end
    end, { noremap = true, desc = "[dap] Run js debugger with launch.json" })

    -- =============== ICONS ===============
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped" })
  end,
}
