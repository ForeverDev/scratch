local Button = {}

function Button.new(ssx, sox, ssy, soy, psx, pox, psy, poy, text)

  local self = G.CLASSES.UI.new(ssx, sox, ssy, soy, psx, pox, psy, poy)
  self.classname = "Button"
  self.text = text or ""

  local events = {
    Mouse1Click = nil;
    Mouse1Down = nil;
    Mouse1Up = nil;
    Mouse2Click = nil;
    Mouse2Down = nil;
    MouseEnter = nil;
    MouseLeave = nil;
  }

  function self.HookEvent(event_name, f)
    events[event_name] = f
  end

  function self.FireMouseEvent(event_name, mx, my)
    if not events[event_name] then
      return
    end
    events[event_name](self, mx, my)
  end

  function self.Draw()
    G.DRAW.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
    G.DRAW.rectangle("fill", self.abs_position.x, self.abs_position.y, self.abs_size.x, self.abs_size.y)
    G.DRAW.setColor(0, 0, 0)
    G.DRAW.printf(self.text, self.abs_position.x - self.abs_size.x/2, self.abs_position.y + self.abs_size.y/2 - G.DRAW.getFont():getHeight()/2, 200, "center")
  end

  return self

end

return Button
