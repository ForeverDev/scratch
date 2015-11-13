local BaseBlock = {}

function BaseBlock.new(ssx, sox, ssy, soy, psx, pox, psy, poy)

  local self = G.CLASSES.FRAME.new(ssx, sox, ssy, soy, psx, pox, psy, poy)
  self.classname = "BaseBlock"

  local is_selected = false

  function self.SetSelect(s)
    is_selected = s and true or false
  end

  function self.GetSelect()
    return is_selected
  end

  function self.Draw()

  end

  function self.Update(dt)
    if is_selected then
      self.SetPosition(G.MOUSE:getX(), G.MOUSE:getY())
    end
  end

  return self

end

return BaseBlock
