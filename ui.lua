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
      mx > self.x and mx < self.x + self.sx and
      my > self.y and my < self.y + self.sy
    )
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
