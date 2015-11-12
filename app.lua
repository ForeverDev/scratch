local App = {}

function App.new()

  local self = G.CLASSES.BASE()

  local app_launch_time = G.TIMER.getTime()
  local keys_down = {}
  local uis = {}

  function self.Exit()
    love.event.quit()
  end

  function self.GetElapsedTime()
    return G.TIMER.getTime() - app_launch_time
  end

  function self.Update(dt)

  end

  function self.Draw()
    for i, v in ipairs(uis) do
      v.Draw()
    end
  end

  function self.KeyPressed(key)
    keys_down[key] = true
    if key == "escape" then
      self.Exit()
    end
  end

  function self.KeyReleased(key)
    keys_down[key] = nil
  end

  do
    local frame = G.CLASSES.FRAME.new(20, 20, 200, 150)
    frame.AddChild(G.CLASSES.FRAME.new(20, 20, 50, 50))
    frame.GetChild(1).SetColor(255, 0, 0)
    frame.GetChild(1).AddChild(G.CLASSES.FRAME.new(20, 20, 25, 25))
    frame.GetChild(1).GetChild(1).SetColor(0, 0, 255)
    table.insert(uis, frame)
  end

  return self

end

return App
