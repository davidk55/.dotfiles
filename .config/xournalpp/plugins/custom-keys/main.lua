function initUi()
  app.registerUi({ ["menu"] = "ToggleEraser", ["callback"] = "ToggleEraser", ["accelerator"] = "<Alt>F1" })
  app.registerUi({ ["menu"] = "ToggleHighlighter)", ["callback"] = "ToggleHighlighter", ["accelerator"] = "<Alt>F2" })
  app.registerUi({ ["menu"] = "DeletePage", ["callback"] = "DeletePage", ["accelerator"] = "<Alt>F3" })
  app.registerUi({ ["menu"] = "ToggleFullScreen", ["callback"] = "ToggleFullScreen", ["accelerator"] = "<Alt>F4" })
end

local currentTool = "pen"

function ToggleEraser()
  if currentTool == "pen" or currentTool == "highlighter" then
    app.uiAction({ ["action"] = "ACTION_TOOL_ERASER_SIZE_MEDIUM" })
    app.uiAction({ ["action"] = "ACTION_TOOL_ERASER" })
    currentTool = "eraser"
  else
    app.uiAction({ ["action"] = "ACTION_TOOL_PEN_SIZE_THICK" })
    app.uiAction({ ["action"] = "ACTION_TOOL_PEN" })
    currentTool = "pen"
  end
end

function ToggleHighlighter()
  if currentTool == "pen" or currentTool == "eraser" then
    app.uiAction({ ["action"] = "ACTION_TOOL_HIGHLIGHTER" })
    app.uiAction({ ["action"] = "ACTION_TOOL_HIGHLIGHTER_SIZE_MEDIUM" })
    currentTool = "highlighter"
  else
    app.uiAction({ ["action"] = "ACTION_TOOL_PEN_SIZE_THICK" })
    app.uiAction({ ["action"] = "ACTION_TOOL_PEN" })
    currentTool = "pen"
  end
end

function ToggleFullScreen()
  app.uiAction({ ["action"] = "ACTION_FULLSCREEN" })
  app.uiAction({ ["action"] = "ACTION_ZOOM_FIT" })
end

function DeletePage()
  app.layerAction("ACTION_DELETE_LAYER")
end
