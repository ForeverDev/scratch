local screen = G.MAIN.screen
local width = G.CONST.WIDTH
local height = G.CONST.HEIGHT
local Frame = G.CLASSES.FRAME
local Button = G.CLASSES.BUTTON

-- create a tab on the left side of the screen
-- that holds all of the scratch blocks
do
  local holders = {}
  local function swap_holder(holder)
    for i, v in pairs(holders) do
      if i == holder then
        v.SetVisible(true)
      else
        v.SetVisible(false)
      end
    end
  end

  local tab = Frame.new(0, 300, 1, 0, 0, 0, 0, 0)
  tab.SetColor(255)
    local bar = Frame.new(1, 0, 0, 100, 0, 0, 0, 0)
    bar.SetColor(255)
      local events = Button.new(0.33, 0, 0.5, 0, 0, 0, 0, 0, "Events")
      events.SetColor(255, 0, 0)
      events.HookEvent("Mouse1Down", function(self, mx, my)
        swap_holder("event_holder")
      end)
      bar.AddChild(events)
      local _math = Button.new(0.33, 0, 0.5, 0, 0.33, 0, 0, 0, "Math")
      _math.SetColor(0, 0, 255)
      _math.HookEvent("Mouse1Down", function(self, mx, my)
        swap_holder("math_holder")
      end)
      bar.AddChild(_math)
    tab.AddChild(bar)
    local event_holder = Frame.new(1, 0, 1, -100, 0, 0, 0, 100)
    event_holder.SetColor(0, 255, 0)
    event_holder.SetVisible(false)
    holders.event_holder = event_holder
    tab.AddChild(event_holder)
    local math_holder = Frame.new(1, 0, 1, -100, 0, 0, 0, 100)
    math_holder.SetColor(0, 255, 0)
    math_holder.SetVisible(false)
    holders.math_holder = math_holder
      local test_block = Button.new(0, 100, 0, 50, 0.5, -50, 0, 50, "Testing button")
      test_block.SetColor(0, 0, 255)
      math_holder.AddChild(test_block)
    tab.AddChild(math_holder)
  screen.AddChild(tab)
end
