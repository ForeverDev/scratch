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
  -- self.contained is a table that contains blocks stored
  -- inside this object.  It is like self.children, but it
  -- only contains other block types.  This is done so that
  -- the children of this object can easily be positioned
  -- based on other children
  self.contained = {}
  -- self.components is a table that contains the positions
  -- of the four frames that are used to draw the
  -- indent block to the screen.  The sizes and positions
  -- are initialized to (0, 0), but are redefined
  -- in self.UpdateComponents()
  self.components = {
    top = G.CLASSES.FRAME.new(0, 0, 0, 0, 0, 0, 0, 0);
    bottom = G.CLASSES.FRAME.new(0, 0, 0, 0, 0, 0, 0, 0);
    left = G.CLASSES.FRAME.new(0, 0, 0, 0, 0, 0, 0, 0);
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
    self.draw_frame.SetSize(1, 0, 1, 0)
    self.draw_frame.UpdateDimensions()
    self.components.top.SetSize(1, 0, 0, IndentBlock.TOP_BORDER)
    self.components.top.SetPosition(0, 0, 0, 0)
    self.components.left.SetSize(0, IndentBlock.LEFT_BORDER, 1, -IndentBlock.TOP_BORDER)
    self.components.left.SetPosition(0, 0, 0, IndentBlock.TOP_BORDER)
    self.components.bottom.SetSize(1, -IndentBlock.LEFT_BORDER, 0, IndentBlock.BOTTOM_BORDER)
    self.components.bottom.SetPosition(0, IndentBlock.LEFT_BORDER, 1, -IndentBlock.BOTTOM_BORDER)
  end

  function self.GetChildrenVerticalSpacing()
    local spacing = 0
    for i, v in ipairs(self.contained) do
      if #v.contained == 0 then
        spacing = spacing + v.abs_size.y
      else
        spacing = spacing + v.GetChildrenVerticalSpacing() + IndentBlock.BOTTOM_BORDER + IndentBlock.TOP_BORDER
      end
    end
    return spacing
  end

  function self.ShiftContainedY()
    local last = IndentBlock.TOP_BORDER
    for i, v in ipairs(self.contained) do
      v.position.y.offset = last
      v.ShiftContainedY()
      last = last + v.abs_size.y
    end
    self.size.y.offset = self.GetChildrenVerticalSpacing() + IndentBlock.TOP_BORDER + IndentBlock.BOTTOM_BORDER
    if (self.size.y.offset <= IndentBlock.TOP_BORDER + IndentBlock.BOTTOM_BORDER) then
      self.size.y.offset = IndentBlock.TOP_BORDER + IndentBlock.BOTTOM_BORDER + 50
    end
    self.UpdateComponents()
  end

  function self.AddChild(c)
    c.parent = self
    c.position.x.scale = 0
    c.position.x.offset = IndentBlock.LEFT_BORDER
    c.position.y.scale = 0
    c.size.x.scale = 1
    c.size.x.offset = -IndentBlock.LEFT_BORDER
    c.size.y.scale = 0
    c.size.y.offset = 0
    if c.InstanceOf("IndentBlock") then
      c.draw_frame.UpdateDimensions()
      table.insert(self.contained, c)
      self.ShiftContainedY()
    else
      table.insert(self.children, c)
    end
  end

  function self.UpdateContained()
    for i, v in ipairs(self.contained) do
      v.UpdateDimensions()
    end
  end

  function self.GetTopLeftInner()
    return self.abs_position.x + IndentBlock.LEFT_BORDER, self.abs_position.y + IndentBlock.TOP_BORDER
  end

  function self.Draw()
    self.draw_frame.Draw()
    for i, v in pairs(self.contained) do
      v.Draw()
    end
  end

  self.AddChild(self.draw_frame)
  self.draw_frame.AddChild(self.components.top)
  self.draw_frame.AddChild(self.components.bottom)
  self.draw_frame.AddChild(self.components.left)
  self.draw_frame.SetVisible(false)
  self.draw_frame.DrawChildrenWhenNotVisible(true)
  self.UpdateComponents()

  return self

end

return IndentBlock
