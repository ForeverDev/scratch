local Screen = {}

function Screen.new()

  local self = G.CLASSES.FRAME.new(0, 0, G.CONST.WIDTH, G.CONST.HEIGHT)
  self.classname = "Screen"

  function self.RegisterClick(mx, my, b, was_down)
    local scan;
    scan = function(p)
      for i, v in ipairs(p.GetChildren()) do
        if v.InstanceOf("Button") then
          if v.MouseIsInBounds(mx, my) then
            local event_type = (
              (b == "l" and was_down) and "Mouse1Down" or
              (b == "l") and "Mouse1Up" or
              (b == "r" and was_down) and "Mouse2Down" or
              (b == "r") and "Mouse2Up" or "Unknown"
            )
            print(event_type)
            v.FireMouseEvent(event_type, mx, my)
          end
        elseif v.InstanceOf("Frame") or v.InstanceOf("Screen") then
          scan(v)
        end
      end
    end
    scan(self)
  end

  return self

end

return Screen
