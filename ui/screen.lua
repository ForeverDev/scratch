local Screen = {}

function Screen.new()

  local self = G.CLASSES.FRAME.new(0, G.CONST.WIDTH, 0, G.CONST.HEIGHT, 0, 0, 0, 0)
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
            v.FireMouseEvent(event_type, mx, my)
          end
        elseif v.InstanceOf("Frame") or v.InstanceOf("Screen") then
          scan(v)
        end
      end
    end
    scan(self)
  end

  function self.RegisterMouseMove(mx, my, dx, dy)
    local scan;
    scan = function(p)
      for i, v in ipairs(p.GetChildren()) do
        if v.MouseIsInBounds(mx, my) then
          if not v.mouse_is_in_bounds then
            if v.InstanceOf("Button") then
              v.FireMouseEvent("MouseEnter", mx, my)
            end
          end
          v.mouse_is_in_bounds = true
        elseif v.mouse_is_in_bounds then
          if v.InstanceOf("Button") then
            v.FireMouseEvent("MouseLeave", mx, my)
          end
          v.mouse_is_in_bounds = false
        end
        if v.InstanceOf("Frame") or v.InstanceOf("Screen") then
          scan(v)
        end
      end
    end
    scan(self)
  end

  return self

end

return Screen
