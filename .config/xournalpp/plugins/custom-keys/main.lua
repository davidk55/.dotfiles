function initUi()
  app.registerUi({ ["menu"] = "ToggleEraser", ["callback"] = "ToggleEraser", ["accelerator"] = "<Alt>F1" })
  app.registerUi({ ["menu"] = "ToggleHighlighter", ["callback"] = "ToggleHighlighter", ["accelerator"] = "<Alt>F2" })
  app.registerUi({ ["menu"] = "DeletePage", ["callback"] = "DeletePage", ["accelerator"] = "<Alt>F3" })
  app.registerUi({ ["menu"] = "EnableZoomFit", ["callback"] = "EnableZoomFit", ["accelerator"] = "<Alt>F4" })
  app.registerUi({ ["menu"] = "ToggleHand", ["callback"] = "ToggleHand", ["accelerator"] = "<Alt>F5" })
end

local currentTool = "pen"

function ToggleEraser()
  if currentTool == "eraser" then
    app.uiAction({ ["action"] = "ACTION_TOOL_PEN_SIZE_THICK" })
    app.uiAction({ ["action"] = "ACTION_TOOL_PEN" })
    currentTool = "pen"
  else
    app.uiAction({ ["action"] = "ACTION_TOOL_ERASER_SIZE_MEDIUM" })
    app.uiAction({ ["action"] = "ACTION_TOOL_ERASER" })
    currentTool = "eraser"
  end
end

function ToggleHighlighter()
  if currentTool == "highlighter" then
    app.uiAction({ ["action"] = "ACTION_TOOL_PEN_SIZE_THICK" })
    app.uiAction({ ["action"] = "ACTION_TOOL_PEN" })
    currentTool = "pen"
  else
    app.uiAction({ ["action"] = "ACTION_TOOL_HIGHLIGHTER_SIZE_MEDIUM" })
    app.uiAction({ ["action"] = "ACTION_TOOL_HIGHLIGHTER" })
    currentTool = "highlighter"
  end
end

function ToggleHand()
  if currentTool == "hand" then
    app.uiAction({ ["action"] = "ACTION_TOOL_PEN_SIZE_THICK" })
    app.uiAction({ ["action"] = "ACTION_TOOL_PEN" })
    currentTool = "pen"
  else
    app.uiAction({ ["action"] = "ACTION_TOOL_HAND" })
    currentTool = "hand"
  end
end

function EnableZoomFit()
  app.uiAction({ ["action"] = "ACTION_ZOOM_FIT" })
end

function DeletePage()
  app.layerAction("ACTION_DELETE_LAYER")
end
