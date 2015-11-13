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
  self.draw_frame = G.CLASSES.FRAME.new(1, 0, 1, 0, 0, 0, 0, 0)
  -- self.components is a table that contains the positions
  -- of the four frames that are used to draw the
  -- indent block to the screen.  The sizes and positions
  -- are initialized to (0, 0), but are redefined
  -- in self.UpdateComponents()
  self.components = {
    top = G.CLASSES.FRAME.new(0, 0, 0, 0, 0, 0, 0, 0);
    bottom = G.CLASSES.FRAME.new(0, 0, 0, 0, 0, 0, 0, 0);
    left = G.CLASSES.FRAME.new(0, 0, 0, 0, 0, 0, 0, 0);
    right = G.CLASSES.FRAME.new(0, 0, 0, 0, 0, 0, 0, 0);
  }

  -- override UI.SetColor(...) to change the colors
  -- of all the self.components
  function self.SetColor(r, g, b, a)
    for i, v in pairs(self.components) do
      if i ~= "middle" then
        v.SetColor(r, g, b, a)
      end
    end
  end

  function self.UpdateComponents()
    self.UpdateDimensions()
    self.components.top.SetSize(1, 0, 0, IndentBlock.TOP_BORDER)
    self.components.top.SetPosition(0, 0, 0, 0)
    self.components.left.SetSize(0, IndentBlock.LEFT_BORDER, 1, -IndentBlock.TOP_BORDER)
    self.components.left.SetPosition(0, 0, 0, IndentBlock.TOP_BORDER)
    self.components.bottom.SetSize(1, -IndentBlock.LEFT_BORDER, 0, IndentBlock.BOTTOM_BORDER)
    self.components.bottom.SetPosition(0, IndentBlock.LEFT_BORDER, 1, -IndentBlock.BOTTOM_BORDER)
    self.components.right.SetSize(0, IndentBlock.LEFT_BORDER, 0, 50)
    self.components.right.SetPosition(1, -IndentBlock.LEFT_BORDER, 1, -50)
  end

  function self.AddChild(c)
    c.parent = self
    c.position.x.scale = 0
    c.position.x.offset = IndentBlock.LEFT_BORDER
    c.position.y.scale = 0
    c.position.y.offset = IndentBlock.TOP_BORDER
    c.size.x.scale = 1
    c.size.x.offset = -IndentBlock.LEFT_BORDER
    c.size.y.scale = 1
    c.size.y.offset = -(IndentBlock.BOTTOM_BORDER + IndentBlock.TOP_BORDER + 25)
    c.UpdateDimensions()
    if c.InstanceOf("IndentBlock") then
      c.draw_frame.UpdateDimensions()
    end
    table.insert(self.children, c)
  end

  function self.GetTopLeftInner()
    return self.abs_position.x + IndentBlock.LEFT_BORDER, self.abs_position.y + IndentBlock.TOP_BORDER
  end

  function self.Draw()
    for i, v in pairs(self.GetChildren()) do
      v.Draw()
    end
  end

  self.AddChild(self.draw_frame)
  self.draw_frame.AddChild(self.components.top)
  self.draw_frame.AddChild(self.components.bottom)
  self.draw_frame.AddChild(self.components.left)
  self.draw_frame.AddChild(self.components.right)
  self.draw_frame.SetVisible(false)
  self.draw_frame.DrawChildrenWhenNotVisible(true)
  self.UpdateComponents()

  return self

end

return IndentBlock
