local screen = G.MAIN.screen
local width = G.CONST.WIDTH
local height = G.CONST.HEIGHT
local Frame = G.CLASSES.FRAME
local Button = G.CLASSES.BUTTON
local Indent = G.CLASSES.INDENTBLOCK

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

  -- create an instance of some block,
  -- sets it to is_active,
  local function spawn(classname)
    for i, v in ipairs(G.MAIN.screen.GetChildren()) do
      if v.InstanceOf("IndentBlock") then
        v.SetSelect(false)
      end
    end
    local object = G.CLASSES[string.upper(classname)].new()
    object.SetPosition(0, G.MOUSE:getX(), 0, G.MOUSE:getY())
    object.SetSelect(true)
    G.MAIN.screen.AddChild(object)
    G.MAIN.SetBlockFocus(object)
    return object
  end

  local colors = {
    events = {47, 158, 237},
    _math = {0, 0, 255}
  }

  local tab = Frame.new(0, 300, 1, 0, 0, 0, 0, 0)
  tab.SetColor(255)
    local bar = Frame.new(1, 0, 0, 100, 0, 0, 0, 0)
    bar.SetColor(255)
      local events = Button.new(0.33, 0, 0.5, 0, 0, 0, 0, 0, "Events")
      events.SetColor(colors.events)
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
      local seperator = Frame.new(1, 0, 0, 2, 0, 0, 1, -2)
      seperator.SetColor(0)
      bar.AddChild(seperator)
    tab.AddChild(bar)
    local event_holder = Frame.new(1, 0, 1, -100, 0, 0, 0, 100)
    event_holder.SetVisible(false)
    holders.event_holder = event_holder
    tab.AddChild(event_holder)
        local on_start = Button.new(0, 100, 0, 50, 0.5, -50, 0, 50, "OnStart")
        on_start.SetColor(colors.events)
        on_start.HookEvent("Mouse1Down", function(self, mx, my)
          spawn("OnStartBlock")
        end)
        event_holder.AddChild(on_start)
    local math_holder = Frame.new(1, 0, 1, -100, 0, 0, 0, 100)
    math_holder.SetColor(0, 255, 0)
    math_holder.SetVisible(false)
    holders.math_holder = math_holder
    tab.AddChild(math_holder)
  screen.AddChild(tab)
end

