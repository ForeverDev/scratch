local BaseBlock = {}

function BaseBlock.new(ssx, sox, ssy, soy, psx, pox, psy, poy)

  local self = G.CLASSES.FRAME.new(ssx, sox, ssy, soy, psx, pox, psy, poy)
  self.classname = "BaseBlock"
  self.click_detector = G.CLASSES.BUTTON.new(1, 0, 1, 0, 0, 0, 0, 0)

  local is_selected = false

  function self.SetSelect(s)
    is_selected = s and true or false
  end

  function self.GetSelect()
    return is_selected
  end

  function self.Draw()

  end

  self.AddChild(self.click_detector)
  self.click_detector.SetVisible(false)
  self.click_detector.HookEvent("Mouse1Down", function(s, mx, my)
    self.SetSelect(true)
  end)
  self.click_detector.HookEvent("Mouse1Up", function(s, my, my)
    self.SetSelect(false)
  end)

  return self

end

return BaseBlock
