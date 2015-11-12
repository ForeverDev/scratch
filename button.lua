local Button = {}

function Button.new(x, y, sx, sy, text)

  local self = G.CLASSES.UI.new(x, y, sx, sy)
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
    G.DRAW.rectangle("fill", self.absolute_x, self.absolute_y, self.sx, self.sy)
    G.DRAW.setColor(0, 0, 0)
    G.DRAW.printf(self.text, self.absolute_x - self.sx/2, self.absolute_y + self.sy/2, 200, "center")
  end

  return self

end

return Button
