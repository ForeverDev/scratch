local screen = G.MAIN.screen
local width = G.CONST.WIDTH
local height = G.CONST.HEIGHT
local Frame = G.CLASSES.FRAME
local Button = G.CLASSES.BUTTON

-- create a tab on the left side of the screen
-- that holds all of the scratch blocks
do
  local tab = Frame.new(0, 300, 1, 0, 0, 0, 0, 0)
  tab.SetColor(255)
    local bar = Frame.new(1, 0, 0, 50, 0, 0, 0, 0)
    bar.SetColor(255)
      local events = Button.new(0.33, 0, 1, 0, 0, 0, 0, 0, "Events")
      events.SetColor(255, 0, 0)
      events.HookEvent("Mouse1Down", function(self, mx, my)
        print(self, mx, my)
      end)
      bar.AddChild(events)
    tab.AddChild(bar)
  screen.AddChild(tab)
end
