-- prefix: ctrl+b

local RESIZE_STEP = 5

rex.mode("resize", { exclusive = true })

local function resize_action(direction)
  local name = "tmux_resize_" .. direction
  rex.action{
    name = name,
    title = "Resize Pane " .. direction,
    run = function()
      rex.client.queue("pane.resize", { direction = direction, amount = RESIZE_STEP })
      rex.client.queue("client.mode.enter", { name = "resize" })
    end,
  }
  return name
end

-- prefix itself
rex.bind("ctrl+b>ctrl+b", "pane.send_key", { key = "ctrl+b" })

-- config reload
rex.bind("ctrl+b>r", "client.config.reload")

-- split
rex.bind("ctrl+b>shift+\\", "pane.split.right")
rex.bind("ctrl+b>-", "pane.split.down")
rex.bind("ctrl+b>shift+5", "pane.split.right")
rex.bind("ctrl+b>shift+'", "pane.split.down")

-- pane focus
rex.bind("ctrl+b>h", "pane.focus.left")
rex.bind("ctrl+b>j", "pane.focus.down")
rex.bind("ctrl+b>k", "pane.focus.up")
rex.bind("ctrl+b>l", "pane.focus.right")
rex.bind("ctrl+b>o", "pane.focus_next")
rex.bind("ctrl+b>;", "pane.focus_previous")

-- pane resize: first press resizes and enters resize mode
rex.bind("ctrl+b>shift+h", resize_action("left"))
rex.bind("ctrl+b>shift+j", resize_action("down"))
rex.bind("ctrl+b>shift+k", resize_action("up"))
rex.bind("ctrl+b>shift+l", resize_action("right"))

rex.bind("resize/h", "pane.resize", { direction = "left", amount = RESIZE_STEP })
rex.bind("resize/j", "pane.resize", { direction = "down", amount = RESIZE_STEP })
rex.bind("resize/k", "pane.resize", { direction = "up", amount = RESIZE_STEP })
rex.bind("resize/l", "pane.resize", { direction = "right", amount = RESIZE_STEP })
rex.bind("resize/shift+h", "pane.resize", { direction = "left", amount = RESIZE_STEP })
rex.bind("resize/shift+j", "pane.resize", { direction = "down", amount = RESIZE_STEP })
rex.bind("resize/shift+k", "pane.resize", { direction = "up", amount = RESIZE_STEP })
rex.bind("resize/shift+l", "pane.resize", { direction = "right", amount = RESIZE_STEP })
rex.bind("resize/enter", "client.mode.exit")
rex.bind("resize/q", "client.mode.exit")

-- pane
rex.bind("ctrl+b>z", "pane.zoom")
rex.bind("ctrl+b>x", "pane.close")
rex.bind("ctrl+b>shift+1", "pane.move_to_new_tab")

-- window (tmux window = rex tab)
rex.bind("ctrl+b>c", "client.tab.new")
rex.bind("ctrl+b>n", "client.tab.next")
rex.bind("ctrl+b>p", "client.tab.previous")
rex.bind("ctrl+b>,", "client.tab.rename")
rex.bind("ctrl+b>shift+7", "client.tab.close")
for i = 1, 9 do
  rex.bind("ctrl+b>" .. i, "client.tab.goto", { index = i })
end

-- session
rex.bind("ctrl+b>w", "session.switch")
rex.bind("ctrl+b>shift+4", "session.rename")
rex.bind("ctrl+b>shift+9", "session.previous")
rex.bind("ctrl+b>shift+0", "session.next")

-- find
rex.bind("ctrl+b>/", "client.find.open")

-- copy mode (vi keys inside are Rex defaults)
rex.bind("ctrl+b>[", "pane.copy_mode.enter")
rex.bind("ctrl+b>pageup", "pane.copy_mode.enter")
rex.bind("ctrl+b>]", "pane.paste")

-- window
rex.bind("cmd+enter", "client.window.fullscreen.toggle")

