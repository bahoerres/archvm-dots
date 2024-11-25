return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { 
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      dapui.setup()
      
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      
      vim.keymap.set("n", "<Leader>dt", ':DapToggleBreakpoint<CR>')
      vim.keymap.set("n", "<Leader>dx", ':DapTerminate<CR>')
      vim.keymap.set("n", "<Leader>do", ':DapStepOver<CR>')
    end
  }
}
