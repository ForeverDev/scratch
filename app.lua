local function App()

  local self = G.CLASSES.BASE()

  local app_launch_time = G.TIMER.getTime()
  local keys_down = {}


  function self.Exit()
    love.event.quit()
  end

  function self.GetElapsedTime()
    return G.TIMER.getTime() - app_launch_time
  end

  function self.Update(dt)

  end

  function self.Draw()

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

  return self

end

return App
