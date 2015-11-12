function love.load()

  -- G is a global table that contains the Love2D modules.  It
  -- also conains a classes table and a core table.  The classes
  -- table contains the loaded class files and the core table
  -- contains the functions loaded from corefunc.lua
  G = setmetatable({}, {__index = {
    DRAW        = love.graphics;
    FONT        = love.font;
    WINDOW      = love.window;
    MOUSE       = love.mouse;
    TIMER       = love.timer;
    IMAGE       = love.image;
    FILESYSTEM  = love.filesystem;
    CLASSES     = {};
    CORE        = {};
    CONST       = {
      WIDTH       = love.graphics.getWidth();
      HEIGHT      = love.graphics.getHeight();
    };
  }})

  -- dofile corefunc.lua
  -- this loads corefunc.lua's functions into G.CORE
  G.FILESYSTEM.load("corefunc.lua")()

  -- load classes
  G.CLASSES.BASE        = G.CORE.LOADFILE("baseclass.lua")
  G.CLASSES.UI          = G.CORE.LOADFILE("ui.lua")
  G.CLASSES.BUTTON      = G.CORE.LOADFILE("button.lua")
  G.CLASSES.FRAME       = G.CORE.LOADFILE("frame.lua")
  G.CLASSES.SCREEN      = G.CORE.LOADFILE("screen.lua")
  G.CLASSES.APP         = G.CORE.LOADFILE("app.lua")

  -- define an instance of App.  This instance is where all
  -- of the work of the program is done.
  G.MAIN                = G.CLASSES.APP.new()

  -- load the ui_sprite.lua file.  Doing so loads all UIs into
  -- G.MAIN's screen
  G.CORE.LOADFILE("ui_sheet.lua")

end

function love.update(dt)
  G.MAIN.Update(dt)
end

function love.draw()
  G.MAIN.Draw()
end

function love.keypressed(key)
  G.MAIN.KeyPressed(key)
end

function love.keyreleased(key)
  G.MAIN.KeyReleased(key)
end

function love.mousepressed(mx, my, b)
  G.MAIN.MousePressed(mx, my, b)
end

function love.mousereleased(mx, my, b)
  G.MAIN.MouseReleased(mx, my, b)
end
