local Frame = {}

function Frame.new(x, y, sx, sy)

  local self = G.CLASSES.UI.new(x, y, sx, sy)
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
    c.absolute_x = self.absolute_x + c.x
    c.absolute_y = self.absolute_y + c.y
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

  function self.RegisterClickInChildren(mx, my)
    for i, v in ipairs(children) do
      if v.InstanceOf("Frame") then
        v.RegisterClickInChildren(mx, my)
      elseif v.InstanceOf("Button") then
        v.RegusterClick()
      end
    end
  end

  function self.Draw()
    if not self.visible then
      return
    end
    G.DRAW.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
    G.DRAW.rectangle("fill", self.absolute_x, self.absolute_y, self.sx, self.sy)
    for i, v in ipairs(children) do
      v.Draw()
    end
  end

  return self

end

return Frame
