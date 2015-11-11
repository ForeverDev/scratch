function love.load()

  -- G is a global table that contains the Love2D modules.  It
  -- also conains a classes table and a core table.  The classes
  -- table contains the loaded class files and the core table
  -- contains the functions loaded from corefunc.lua
  G = setmetatable({}, {__index = {
    DRAW        = love.graphics;
    WINDOW      = love.window;
    TIMER       = love.timer;
    IMAGE       = love.image;
    FILESYSTEM  = love.filesystem;
    CLASSES     = {};
    CORE        = {}
  }})

  -- dofile corefunc.lua
  -- this loads corefunc.lua's functions into G.CORE
  G.FILESYSTEM.load("corefunc.lua")()

  -- load classes
  G.CLASSES.BASE        = G.CORE.LOADFILE("baseclass.lua")
  G.CLASSES.APP         = G.CORE.LOADFILE("app.lua")

  -- define an instance of App.  This instance is where all
  -- of the work of the program is done.
  G.MAIN                = G.CLASSES.APP()

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
