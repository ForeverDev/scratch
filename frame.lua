local Frame = {}

function Frame.new(ssx, sox, ssy, soy, psx, pox, psy, poy)

  local self = G.CLASSES.UI.new(ssx, sox, ssy, soy, psx, pox, psy, poy)
  self.classname = "Frame"

  local children = {}

  function self.GetChildren()
    local copy = {}
    for i, v in ipairs(children) do
      table.insert(copy, v)
    end
    return copy
  end

  function self.AddChild(c)
    c.parent = self
    c.UpdateDimensions()
    table.insert(children, c)
  end

  function self.GetChild(i)
    return children[i]
  end

  function self.RemoveChild(c)
    if type(c) == "table" then
      for i, v in ipairs(children) do
        if v == c then
          c.parent = nil
          return table.remove(children, i)
        end
      end
    else
      c.parent = nil
      return table.remove(children, c)
    end
  end

  function self.Draw()
    if not self.visible then
      return
    end
    G.DRAW.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
    G.DRAW.rectangle("fill", self.abs_position.x, self.abs_position.y, self.abs_size.x, self.abs_size.y)
    for i, v in ipairs(children) do
      v.Draw()
    end
  end

  return self

end

return Frame
