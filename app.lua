local function App()

  local self = G.CLASSES.BASE()

  local keys_down = {}

  function self.Exit()

  end

  function self.GetElapsedTime()

  end

  function self.Update(dt)

  end

  function self.Draw()

  end

  function self.KeyPressed(key)
    keys_down[key] = true
    if key == "escape" then
      love.event.quit()
    end
  end

  function self.KeyReleased(key)
    keys_down[key] = nil
  end

  return self

end

return App
