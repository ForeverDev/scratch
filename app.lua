local App = {}

function App.new()

  local self = G.CLASSES.BASE()
  self.classname = "App"
  self.screen = G.CLASSES.SCREEN.new(0, G.CONST.WIDTH, 0, G.CONST.HEIGHT, 0, 0, 0, 0)
  self.selected_block = nil

  local app_launch_time = G.TIMER.getTime()
  local keys_down = {}

  function self.Exit()
    love.event.quit()
  end

  function self.GetElapsedTime()
    return G.TIMER.getTime() - app_launch_time
  end

  function self.SetBlockFocus(b)
    if not b then
      if self.selected_block then
        self.selected_block.SetSelect(false)
        self.selected_block = nil
      end
    else
      if not self.selected_block then
        b.SetSelect(true)
        self.selected_block = b
      end
    end
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
    if self.selected_block then
      self.SetBlockFocus(nil)
    end
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
