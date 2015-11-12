local App = {}

function App.new()

  local self = G.CLASSES.BASE()
  self.classname = "App"

  local app_launch_time = G.TIMER.getTime()
  local keys_down = {}
  local screen = G.CLASSES.SCREEN.new(0, 0, G.CONST.WIDTH, G.CONST.HEIGHT)

  function self.Exit()
    love.event.quit()
  end

  function self.GetElapsedTime()
    return G.TIMER.getTime() - app_launch_time
  end

  function self.Update(dt)

  end

  function self.Draw()
    screen.Draw()
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

  function self.MousePressed(mx, my, b)
    screen.RegisterClick(mx, my, b, true)
  end

  function self.MouseReleased(mx, my, b)
    screen.RegisterClick(mx, my, b, false)
  end

  do
    screen.SetColor(0, 0, 0, 255)

    local frame = G.CLASSES.FRAME.new(20, 20, 300, 300)
    local button = G.CLASSES.BUTTON.new(20, 20, 100, 100, "Click me!")
    button.HookEvent("Mouse1Click", function(self, mx, my)
      print(mx, my)
    end)

    frame.AddChild(button)
    screen.AddChild(frame)
  end

  return self

end

return App
