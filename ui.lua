local UI = {}

function UI.new(x, y, sx, sy)

  local self = G.CLASSES.BASE()
  self.classname = "UI"
  self.x = x
  self.y = y
  self.absolute_x = x
  self.absolute_y = y
  self.sx = sx
  self.sy = sy
  self.parent = nil
  self.visible = true
  self.color = {
    r = 255;
    g = 255;
    b = 255;
    a = 255;
  }

  function self.MouseIsInBounds(mx, my)
    return (
      mx > self.absolute_x and mx < self.absolute_x + self.sx and
      my > self.absolute_y and my < self.absolute_y + self.sy
    )
  end

  function self.Translate(x, y)
    self.x = self.x + x
    self.y = self.y + y
    self.absolute_x = self.absolute_x + x
    self.absolute_y = self.absolute_y + y
  end

  function self.SetPosition(x, y)

  end

  function self.SetColor(r, g, b, a)
    self.color.r = r
    self.color.g = g
    self.color.b = b
    self.color.a = a
  end

  function self.SetVisible(v)
    self.visible = v
  end

  return self

end

return UI
