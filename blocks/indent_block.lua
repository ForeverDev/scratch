local IndentBlock = {
  TOP_BORDER      = 25;
  LEFT_BORDER     = 25;
  BOTTOM_BORDER   = 25;
  RIGHT_BORDER    = 25;
}

function IndentBlock.new(ssx, sox, ssy, soy, psx, pox, psy, poy)

  -- note that the size of an IndentBlock is the
  -- size BETWEEN the top and bottom component,
  -- it is not the size from the top of the top
  -- component to the bottom of the bottom component.
  -- the top-left position of an IndentBlock is
  -- still the top-left corner, including the
  -- top component
  local self = G.CLASSES.BASEBLOCK.new(ssx, sox, ssy, soy, psx, pox, psy, poy)
  self.classname = "IndentBlock"

  -- components is a table that contains the positions
  -- of the four frames that are used to draw the
  -- indent block to the screen
  local components = {
    top = G.CLASSES.FRAME.new(ssx, sox + IndentBlock.LEFT_BORDER, 0, IndentBlock.TOP_BORDER, psx, pox - IndentBlock.LEFT_BORDER, psy, poy - IndentBlock.TOP_BORDER);
    left = G.CLASSES.FRAME.new(0, IndentBlock.LEFT_BORDER, ssy, soy + IndentBlock.BOTTOM_BORDER, psx, pox - IndentBlock.LEFT_BORDER, psy, poy);
    bottom = G.CLASSES.FRAME.new(ssx, sox, 0, IndentBlock.BOTTOM_BORDER, psx, pox, psy + ssy, poy + soy);
    right = G.CLASSES.FRAME.new(0, IndentBlock.RIGHT_BORDER, 0, 50, psx + ssx, pox + sox - IndentBlock.LEFT_BORDER, psy + ssy, poy + soy - IndentBlock.RIGHT_BORDER);
    middle = G.CLASSES.BUTTON.new(ssx, sox, ssy, soy, psx, pox, psy, poy)
  }

  -- override UI.SetColor(...) to change the colors
  -- of all the components
  function self.SetColor(r, g, b, a)
    for i, v in pairs(components) do
      if i ~= "middle" then
        v.SetColor(r, g, b, a)
      end
    end
  end

  function self.UpdateComponents()
    self.UpdateDimensions()
   -- if not self.parent then
      components.top.SetSize(ssx, sox + IndentBlock.LEFT_BORDER, 0, IndentBlock.TOP_BORDER)
      components.top.SetPosition(psx, pox - IndentBlock.LEFT_BORDER, psy, poy - IndentBlock.TOP_BORDER)
      components.left.SetSize(0, IndentBlock.LEFT_BORDER, ssy, soy + IndentBlock.BOTTOM_BORDER)
      components.left.SetPosition(psx, pox - IndentBlock.LEFT_BORDER, psy, poy)
      components.bottom.SetSize(ssx, sox, 0, IndentBlock.BOTTOM_BORDER)
      components.bottom.SetPosition(psx, pox, psy + ssy, poy + soy)
      components.right.SetSize(0, IndentBlock.RIGHT_BORDER, 0, 50)
      components.right.SetPosition(psx + ssx, pox + sox - IndentBlock.LEFT_BORDER, psy + ssy, poy + soy + IndentBlock.RIGHT_BORDER)
      components.middle.SetSize(ssx, sox, ssy, soy)
      components.middle.SetPosition(psx, pox, psy, poy)
   -- else
   --   components.top.SetPosition
   -- end
  end

  function self.GetTopLeftInner()
    return self.abs_position.x + IndentBlock.LEFT_BORDER, self.abs_position.y + IndentBlock.TOP_BORDER
  end

  function self.AddChild(c)
    c.parent = self
    if c.InstanceOf("IndentBlock") then
      c.UpdateComponents()
    end
    table.insert(self.children, c)
  end

  function self.Draw()
    for i, v in pairs(components) do
      v.Draw()
    end
    for i, v in pairs(self.GetChildren()) do
      v.Draw()
    end
  end

  self.AddChild(components.top)
  self.AddChild(components.bottom)
  self.AddChild(components.left)
  self.AddChild(components.right)

  return self

end

return IndentBlock
