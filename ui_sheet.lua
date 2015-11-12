local screen = G.MAIN.screen
local width = G.CONST.WIDTH
local height = G.CONST.HEIGHT
local Frame = G.CLASSES.FRAME
local Button = G.CLASSES.BUTTON

-- create a tab on the left side of the screen
-- that holds all of the scratch blocks
do
  local tab = Frame.new(0, 0, 200, height)
  tab.SetColor(255, 0, 0)
    local top_bar = Frame.new(0, 0, 200, 50)
    top_bar.SetColor(255)
    tab.AddChild(top_bar)
      local events = Button.new(0, 0, 100, 50, "events")
      events.SetColor(200)
      tab.AddChild(events)
  screen.AddChild(tab)


end
