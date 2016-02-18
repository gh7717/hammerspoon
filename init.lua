--------------------------------------------------------------------------------
-- rtoshiro - https://github.com/rtoshiro
-- You should see: http://www.hammerspoon.org/docs/index.html
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- CONSTANTS
--------------------------------------------------------------------------------
local cmd_alt = {"cmd", "alt"}
local cmd_alt_ctrl = {"cmd", "alt", "ctrl"}
local main_monitor = "Color LCD" 
local second_monitor = "B246WL"

--------------------------------------------------------------------------------
-- CONFIGURATIONS
--------------------------------------------------------------------------------
hs.window.animationDuration = 0

--------------------------------------------------------------------------------
-- LAYOUTS
-- SINTAX:
--  {
--    name = "App name" ou { "App name", "App name" }
--    func = function(index, win)
--      COMMANDS
--    end
--  },
--
-- It searches for application "name" and call "func" for each window object
--------------------------------------------------------------------------------
-- Debug. Count of monitors.
hs.hotkey.bind(cmd_alt, "W", function ()
  hs.notify.new({title="Debug", informativeText=#hs.screen.allScreens()}):send()
end) 

-- Maximize and move Mail, Calendar, Messages and Skype to the laptop screen
local layouts = {
  {
    name = {"Mail", "Calendar", "Messages", "Skype"},
    func = function(index, win)
      win:moveToScreen(hs.screen.get(main_monitor))
      win:maximize()
    end
  },
  -- if connected second monitor move Evenote and Slack to this and maximize window
  {
    name = {"Evernote", "Slack"},
    func = function(index, win)
      if (#hs.screen.allScreens() > 1) then
        win:moveToScreen(hs.screen.get(second_monitor))
        hs.window.fullscreenCenter(win)
      else
        win:maximize()
      end
    end
  },
  {
    name = "Finder",
    func = function(index, win)

      if (index == 1) then
        if (#hs.screen.allScreens() > 1) then
          win:moveToScreen(hs.screen.get(second_monitor))
        end

        win:upLeft()
      elseif (index == 2) then
        if (#hs.screen.allScreens() > 1) then
          win:moveToScreen(hs.screen.get(second_monitor))
        end

        win:downLeft()
      elseif (index == 3) then
        if (#hs.screen.allScreens() > 1) then
          win:moveToScreen(hs.screen.get(second_monitor))
        end

        win:downRight()
      elseif (index == 4) then
        if (#hs.screen.allScreens() > 1) then
          win:moveToScreen(hs.screen.get(second_monitor))
        end

        win:upRight()
      elseif (index == 5) then
        win:moveToScreen(hs.screen.get(main_monitor))

        win:upLeft()
      elseif (index == 6) then
        win:moveToScreen(hs.screen.get(main_monitor))

        win:downLeft()
      elseif (index == 7) then
        win:moveToScreen(hs.screen.get(main_monitor))

        win:downRight()
      elseif (index == 8) then
        win:moveToScreen(hs.screen.get(main_monitor))

        win:upRight()
      else
        win:close()
      end
    end
  },
  {
    name = "iTerm",
    func = function(index, win)
      if (#hs.screen.allScreens() > 1) then
        win:moveToScreen(hs.screen.get(main_monitor))
      end

      if (index == 1) then
        win:left()
      elseif (index == 2) then
        win:right()
      end
    end
  },
}

local closeHome = {
  "Skype",
  "Viber",
  "Safari"
}

local openHome = {
  "Skype",
  "Viber",
  "Safari"
}
local openWorkApp = {
  "Slack",
  "Google Chrome",
  "Mail",
  "Calendar"
}
local closeWorkApp = {
  "Slack",
  "Google Chrome",
  "Mail",
  "Calendar"
}

function config()
  hs.hotkey.bind(cmd_alt, "l", function()
    local win = hs.window.focusedWindow()
    win:right()
  end)

  hs.hotkey.bind(cmd_alt, "h", function()
    local win = hs.window.focusedWindow()
    win:left()
  end)
  hs.hotkey.bind(cmd_alt, "k", function()
    local win = hs.window.focusedWindow()
    win:up()
  end)

  hs.hotkey.bind(cmd_alt, "j", function()
    local win = hs.window.focusedWindow()
    win:down()
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "h", function()
    local win = hs.window.focusedWindow()
    win:upLeft()
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "j", function()
    local win = hs.window.focusedWindow()
    win:downLeft()
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "l", function()
    local win = hs.window.focusedWindow()
    win:downRight()
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "k", function()
    local win = hs.window.focusedWindow()
    win:upRight()
  end)

  hs.hotkey.bind(cmd_alt, "c", function()
    local win = hs.window.focusedWindow()
    hs.window.fullscreenCenter(win)
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "c", function()
    local win = hs.window.focusedWindow()
    hs.window.fullscreenAlmostCenter(win)
  end)

  hs.hotkey.bind(cmd_alt, "f", function()
    local win = hs.window.focusedWindow()
    win:maximize()
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "f", function()
    local win = hs.window.focusedWindow()
    if (win) then
      hs.window.fullscreenWidth(win)
    end
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "m", function()
    hs.hints.windowHints()
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "1", function()
    local win = hs.window.focusedWindow()
    if (win) then
      win:moveToScreen(hs.screen.get(second_monitor))
    end
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "2", function()
    local win = hs.window.focusedWindow()
    if (win) then
      win:moveToScreen(hs.screen.get(main_monitor))
    end
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "R", function()
    hs.reload()
    hs.alert.show("Config loaded")
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "P", function()
    hs.alert.show("Closing")
    for i,v in ipairs(closeWork) do
      local app = hs.application(v)
      if (app) then
        if (app.name) then
          hs.alert.show(app:name())
        end
        if (app.kill) then
        app:kill()
      end
      end
    end
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "O", function()
    hs.alert.show("Openning")
    for i,v in ipairs(openWork) do
      hs.alert.show(v)
      hs.application.open(v)
    end
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "3", function()
    applyLayouts(layouts)
  end)

  hs.hotkey.bind(cmd_alt_ctrl, "4", function()

    local focusedWindow = hs.window.focusedWindow()
    local app = focusedWindow:application()
    if (app) then
      applyLayout(layouts, app)
    end
  end)
end
--------------------------------------------------------------------------------
-- END CONFIGURATIONS
--------------------------------------------------------------------------------










--------------------------------------------------------------------------------
-- METHODS - BECAREFUL :)
--------------------------------------------------------------------------------
function applyLayout(layouts, app)
  if (app) then
    local appName = app:title()
    for i, layout in ipairs(layouts) do
      if (type(layout.name) == "table") then
        for i, layAppName in ipairs(layout.name) do
          if (layAppName == appName) then
            local wins = app:allWindows()
            local counter = 1
            for j, win in ipairs(wins) do
              if (win:isVisible() and layout.func) then
                layout.func(counter, win)
                counter = counter + 1
              end
            end
          end
        end
      elseif (type(layout.name) == "string") then
        if (layout.name == appName) then
          local wins = app:allWindows()
          local counter = 1
          for j, win in ipairs(wins) do
            if (win:isVisible() and layout.func) then
              layout.func(counter, win)
              counter = counter + 1
            end
          end
        end
      end
    end
  end
end

function applyLayouts(layouts)
  for i, layout in ipairs(layouts) do
    if (type(layout.name) == "table") then
      for i, appName in ipairs(layout.name) do
        local app = hs.appfinder.appFromName(appName)
        if (app) then
          local wins = app:allWindows()
          local counter = 1
          for j, win in ipairs(wins) do
            if (win:isVisible() and layout.func) then
              layout.func(counter, win)
              counter = counter + 1
            end
          end
        end
      end
    elseif (type(layout.name) == "string") then
      local app = hs.appfinder.appFromName(layout.name)
      if (app) then
        local wins = app:allWindows()
        local counter = 1
        for j, win in ipairs(wins) do
          if (win:isVisible() and layout.func) then
            layout.func(counter, win)
            counter = counter + 1
          end
        end
      end
    end
  end
end

function hs.screen.get(screen_name)
  local allScreens = hs.screen.allScreens()
  for i, screen in ipairs(allScreens) do
    if screen:name() == screen_name then
      return screen
    end
  end
end

-- Returns the width of the smaller screen size
-- isFullscreen = false removes the toolbar
-- and dock sizes
function hs.screen.minWidth(isFullscreen)
  local min_width = math.maxinteger
  local allScreens = hs.screen.allScreens()
  for i, screen in ipairs(allScreens) do
    local screen_frame = screen:frame()
    if (isFullscreen) then
      screen_frame = screen:fullFrame()
    end
    min_width = math.min(min_width, screen_frame.w)
  end
  return min_width
end

-- isFullscreen = false removes the toolbar
-- and dock sizes
-- Returns the height of the smaller screen size
function hs.screen.minHeight(isFullscreen)
  local min_height = math.maxinteger
  local allScreens = hs.screen.allScreens()
  for i, screen in ipairs(allScreens) do
    local screen_frame = screen:frame()
    if (isFullscreen) then
      screen_frame = screen:fullFrame()
    end
    min_height = math.min(min_height, screen_frame.h)
  end
  return min_height
end

-- If you are using more than one monitor, returns X
-- considering the reference screen minus smaller screen
-- = (MAX_REFSCREEN_WIDTH - MIN_AVAILABLE_WIDTH) / 2
-- If using only one monitor, returns the X of ref screen
function hs.screen.minX(refScreen)
  local min_x = refScreen:frame().x
  local allScreens = hs.screen.allScreens()
  if (#allScreens > 1) then
    min_x = refScreen:frame().x + ((refScreen:frame().w - hs.screen.minWidth()) / 2)
  end
  return min_x
end

-- If you are using more than one monitor, returns Y
-- considering the focused screen minus smaller screen
-- = (MAX_REFSCREEN_HEIGHT - MIN_AVAILABLE_HEIGHT) / 2
-- If using only one monitor, returns the Y of focused screen
function hs.screen.minY(refScreen)
  local min_y = refScreen:frame().y
  local allScreens = hs.screen.allScreens()
  if (#allScreens > 1) then
    min_y = refScreen:frame().y + ((refScreen:frame().h - hs.screen.minHeight()) / 2)
  end
  return min_y
end

-- If you are using more than one monitor, returns the
-- half of minX and 0
-- = ((MAX_REFSCREEN_WIDTH - MIN_AVAILABLE_WIDTH) / 2) / 2
-- If using only one monitor, returns the X of ref screen
function hs.screen.almostMinX(refScreen)
  local min_x = refScreen:frame().x
  local allScreens = hs.screen.allScreens()
  if (#allScreens > 1) then
    min_x = refScreen:frame().x + (((refScreen:frame().w - hs.screen.minWidth()) / 2) - ((refScreen:frame().w - hs.screen.minWidth()) / 4))
  end
  return min_x
end

-- If you are using more than one monitor, returns the
-- half of minY and 0
-- = ((MAX_REFSCREEN_HEIGHT - MIN_AVAILABLE_HEIGHT) / 2) / 2
-- If using only one monitor, returns the Y of ref screen
function hs.screen.almostMinY(refScreen)
  local min_y = refScreen:frame().y
  local allScreens = hs.screen.allScreens()
  if (#allScreens > 1) then
    min_y = refScreen:frame().y + (((refScreen:frame().h - hs.screen.minHeight()) / 2) - ((refScreen:frame().h - hs.screen.minHeight()) / 4))
  end
  return min_y
end

-- Returns the frame of the smaller available screen
-- considering the context of refScreen
-- isFullscreen = false removes the toolbar
-- and dock sizes
function hs.screen.minFrame(refScreen, isFullscreen)
  return {
    x = hs.screen.minX(refScreen),
    y = hs.screen.minY(refScreen),
    w = hs.screen.minWidth(isFullscreen),
    h = hs.screen.minHeight(isFullscreen)
  }
end

-- +-----------------+
-- |        |        |
-- |        |  HERE  |
-- |        |        |
-- +-----------------+
function hs.window.right(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  minFrame.x = minFrame.x + (minFrame.w/2)
  minFrame.w = minFrame.w/2
  win:setFrame(minFrame)
end

-- +-----------------+
-- |        |        |
-- |  HERE  |        |
-- |        |        |
-- +-----------------+
function hs.window.left(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  minFrame.w = minFrame.w/2
  win:setFrame(minFrame)
end

-- +-----------------+
-- |      HERE       |
-- +-----------------+
-- |                 |
-- +-----------------+
function hs.window.up(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  minFrame.h = minFrame.h/2
  win:setFrame(minFrame)
end

-- +-----------------+
-- |                 |
-- +-----------------+
-- |      HERE       |
-- +-----------------+
function hs.window.down(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  minFrame.y = minFrame.y + minFrame.h/2
  minFrame.h = minFrame.h/2
  win:setFrame(minFrame)
end

-- +-----------------+
-- |  HERE  |        |
-- +--------+        |
-- |                 |
-- +-----------------+
function hs.window.upLeft(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  minFrame.w = minFrame.w/2
  minFrame.h = minFrame.h/2
  win:setFrame(minFrame)
end

-- +-----------------+
-- |                 |
-- +--------+        |
-- |  HERE  |        |
-- +-----------------+
function hs.window.downLeft(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame({
    x = minFrame.x,
    y = minFrame.y + minFrame.h/2,
    w = minFrame.w/2,
    h = minFrame.h/2
  })
end

-- +-----------------+
-- |                 |
-- |        +--------|
-- |        |  HERE  |
-- +-----------------+
function hs.window.downRight(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame({
    x = minFrame.x + minFrame.w/2,
    y = minFrame.y + minFrame.h/2,
    w = minFrame.w/2,
    h = minFrame.h/2
  })
end

-- +-----------------+
-- |        |  HERE  |
-- |        +--------|
-- |                 |
-- +-----------------+
function hs.window.upRight(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame({
    x = minFrame.x + minFrame.w/2,
    y = minFrame.y,
    w = minFrame.w/2,
    h = minFrame.h/2
  })
end

-- +------------------+
-- |                  |
-- |    +--------+    +--> minY
-- |    |  HERE  |    |
-- |    +--------+    |
-- |                  |
-- +------------------+
-- Where the window's size is equal to
-- the smaller available screen size
function hs.window.fullscreenCenter(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame(minFrame)
end

-- +------------------+
-- |                  |
-- |  +------------+  +--> minY
-- |  |    HERE    |  |
-- |  +------------+  |
-- |                  |
-- +------------------+
function hs.window.fullscreenAlmostCenter(win)
  local offsetW = hs.screen.minX(win:screen()) - hs.screen.almostMinX(win:screen())
  win:setFrame({
    x = hs.screen.almostMinX(win:screen()),
    y = hs.screen.minY(win:screen()),
    w = hs.screen.minWidth(isFullscreen) + (2 * offsetW),
    h = hs.screen.minHeight(isFullscreen)
  })
end

-- It like fullscreen but with minY and minHeight values
-- +------------------+
-- |                  |
-- +------------------+--> minY
-- |       HERE       |
-- +------------------+--> minHeight
-- |                  |
-- +------------------+
function hs.window.fullscreenWidth(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame({
    x = win:screen():frame().x,
    y = minFrame.y,
    w = win:screen():frame().w,
    h = minFrame.h
  })
end

function applicationWatcher(appName, eventType, appObject)
  if (eventType == hs.application.watcher.activated) then
    if (appName == "iTerm") then
        appObject:selectMenuItem({"Window", "Bring All to Front"})
    elseif (appName == "Finder") then
        appObject:selectMenuItem({"Window", "Bring All to Front"})
    end
  end

  if (eventType == hs.application.watcher.launched) then
    os.execute("sleep " .. tonumber(3))
    applyLayout(layouts, appObject)
  end
end

config()
local appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()