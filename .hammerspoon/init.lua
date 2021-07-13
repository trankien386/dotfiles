stackline = require "stackline"
stackline:init()

hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

hs.hotkey.bind({"ctrl"}, "c", function()
  hs.osascript.applescript([[
    tell application "System Events"
      tell process "Control Center"
        tell menu bar item "control center" of menu bar 1
          click
        end tell
      end tell
    end tell
  ]])
end)