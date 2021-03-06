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
    if not events[event_name] or not self.CheckIfVisible() then
      return
    end
    events[event_name](self, mx, my)
  end

  function self.Draw()
    if not self.visible then
      return
    end
    G.DRAW.setColor(self.color.r, self.color.g, self.color.b, self.color.a)
    G.DRAW.rectangle("fill", self.abs_position.x, self.abs_position.y, self.abs_size.x, self.abs_size.y)
    G.DRAW.setColor(0, 0, 0)
    G.DRAW.printf(self.text, self.abs_position.x - self.abs_size.x/2, self.abs_position.y + self.abs_size.y/2 - G.DRAW.getFont():getHeight()/2, 200, "center")
  end

  self.HookEvent("MouseEnter", function(self, mx, my)
    self.color.a = math.max(self.color.a - 80, 0)
  end)

  self.HookEvent("MouseLeave", function(self, mx, my)
    self.color.a = math.min(self.color.a + 80, 255)
  end)

  return self

end

return Button
