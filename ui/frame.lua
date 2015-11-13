local Frame = {}

function Frame.new(ssx, sox, ssy, soy, psx, pox, psy, poy)

  local self = G.CLASSES.UI.new(ssx, sox, ssy, soy, psx, pox, psy, poy)
  self.classname = "Frame"
  self.children = {}

  local draw_when_invis = false

  function self.GetChildren()
    return self.children
  end

  function self.AddChild(c)
    c.parent = self
    c.UpdateDimensions()
    table.insert(self.children, c)
  end

  function self.GetChild(i)
    return self.children[i]
  end

  function self.RemoveChild(c)
    if type(c) == "table" then
      for i, v in ipairs(self.children) do
        if v == c then
          c.parent = nil
          return table.remove(self.children, i)
        end
      end
    else
      c.parent = nil
      return table.remove(self.children, c)
    end
  end

  function self.DrawChildrenWhenNotVisible(d)
    draw_when_invis = d and true or false
  end

  function self.Draw()
    if not self.visible and not draw_when_invis then
      return
    end
    if self.visible then
      G.DRAW.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
      G.DRAW.rectangle("fill", self.abs_position.x, self.abs_position.y, self.abs_size.x, self.abs_size.y)
    end
    for i, v in ipairs(self.children) do
      v.Draw()
    end
  end

  return self

end

return Frame
