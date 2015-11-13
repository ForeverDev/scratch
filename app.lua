local App = {}

function App.new()

  local self = G.CLASSES.BASE()
  self.classname = "App"
  self.screen = G.CLASSES.SCREEN.new(0, G.CONST.WIDTH, 0, G.CONST.HEIGHT, 0, 0, 0, 0)

  local app_launch_time = G.TIMER.getTime()
  local keys_down = {}

  function self.Exit()
    love.event.quit()
  end

  function self.GetElapsedTime()
    return G.TIMER.getTime() - app_launch_time
  end

  function self.Update(dt)
    self.screen.Update(dt)
  end

  function self.Draw()
    self.screen.Draw()
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
    self.screen.RegisterClick(mx, my, b, true)
  end

  function self.MouseReleased(mx, my, b)
    self.screen.RegisterClick(mx, my, b, false)
  end

  function self.MouseMoved(mx, my, dx, dy)
    self.screen.RegisterMouseMove(mx, my, dx, dy)
  end

  do
    self.screen.SetColor(0, 0, 0, 255)
  end

  return self

end

return App
