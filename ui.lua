local UI = {}

-- args:
--  x size scale, x size offset,
--  y size scale, y size offset,
--  x position scale, x position offset,
--  y position scale, y position offset
function UI.new(ssx, sox, ssy, soy, psx, pox, psy, poy)

  local self = G.CLASSES.BASE()
  self.classname = "UI"
  self.size = {
    x = {
      scale = ssx;
      offset = sox;
    };
    y = {
      scale = ssy;
      offset = soy;
    };
  }
  self.position = {
    x = {
      scale = psx;
      offset = pox;
    };
    y = {
      scale = psy;
      offset = poy;
    };
  }
  self.mouse_is_in_bounds = false
  self.parent = nil
  self.visible = true
  self.color = {
    r = 255;
    g = 255;
    b = 255;
    a = 255;
  }

  function self.UpdateDimensions()
    if not self.parent then
      self.abs_position = {
        x = self.position.x.scale*G.CONST.WIDTH + self.position.x.offset;
        y = self.position.y.scale*G.CONST.HEIGHT + self.position.y.offset;
      }
      self.abs_size = {
        x = self.size.x.scale*G.CONST.WIDTH + self.size.x.offset;
        y = self.size.y.scale*G.CONST.HEIGHT + self.size.y.offset;
      }
    else
      self.abs_position = {
        x = self.parent.abs_position.x + (self.parent.abs_size.x*self.position.x.scale + self.position.x.offset);
        y = self.parent.abs_position.y + (self.parent.abs_size.y*self.position.y.scale + self.position.y.offset);
      }
      self.abs_size = {
        x = self.parent.abs_size.x*self.size.x.scale + self.size.x.offset;
        y = self.parent.abs_size.y*self.size.y.scale + self.size.y.offset;
      }
    end
    if self.InstanceOf("Frame") then
      for i, v in ipairs(self.GetChildren()) do
        v.UpdateDimensions()
      end
    end
  end

  function self.MouseIsInBounds(mx, my)
    return (
      mx > self.abs_position.x and mx < self.abs_position.x + self.abs_size.x and
      my > self.abs_position.y and my < self.abs_position.y + self.abs_size.y
    )
  end

  function self.Translate(x, y)

  end

  function self.SetPosition(x, y)

  end

  function self.SetColor(r, g, b, a)
    if r and not (g and b) then
      self.color.r = r
      self.color.g = r
      self.color.b = r
      self.color.a = g or 255
    else
      self.color.r = r
      self.color.g = g
      self.color.b = b
      self.color.a = a or 255
    end
  end

  function self.SetVisible(v)
    self.visible = v
  end

  self.UpdateDimensions()

  return self

end

return UI
