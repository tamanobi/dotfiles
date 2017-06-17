local function keyCode(key, modifiers)
   modifiers = modifiers or {}
   return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(1000)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()      
   end
end

local function remapKey(modifiers, key, keyCode)
   hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

local function disableAllHotkeys()
   for k, v in pairs(hs.hotkey.getHotkeys()) do
      v['_hk']:disable()
   end
end

local function enableAllHotkeys()
   for k, v in pairs(hs.hotkey.getHotkeys()) do
      v['_hk']:enable()
   end
end

local function handleGlobalAppEvent(name, event, app)
   if event == hs.application.watcher.activated then
      -- hs.alert.show(name)
      -- if name ~= "iTerm2" then
      enableAllHotkeys()
      -- else
      --   disableAllHotkeys()
      -- end
   end
end

appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
appsWatcher:start()

-- カーソル移動
remapKey({'alt'}, 'l', keyCode('right'))
remapKey({'alt'}, 'h', keyCode('left'))
remapKey({'alt'}, 'j', keyCode('down'))
remapKey({'alt'}, 'k', keyCode('up'))

-- コマンド
remapKey({'alt'}, '/', keyCode('f', {'cmd'}))
remapKey({'ctrl'}, 'm', keyCode('return'))
remapKey({'alt'}, 'm', keyCode('return'))

-- ページスクロール
remapKey({'alt'}, 'd', keyCode('pagedown'))
remapKey({'alt'}, 'u', keyCode('pageup'))
remapKey({'alt', 'shift'}, 'u', keyCode('home'))
remapKey({'alt', 'shift'}, 'd', keyCode('end'))

local fastKeyStroke = function(modifiers, character)
  local event = require("hs.eventtap").event
  event.newKeyEvent(modifiers, string.lower(character), true):post()
  event.newKeyEvent(modifiers, string.lower(character), false):post()
end

modal = hs.hotkey.modal.new( {}, 'f20' );

-- Mostly for debug reason: shows when the modal is active
--function modal:entered() hs.alert.closeAll(); hs.alert.show( "Vim mode active", 999999 ) end
--function modal:exited() hs.alert.closeAll() end

-- Goes to beginning of the line; ensure that we select if shift is pressed
modal:bind( '', 'u', function() modal.triggered = true; fastKeyStroke( {}, 'home' ) end )
-- modal:bind( { 'shift' }, 'u', function() fastKeyStroke( { 'shift', 'ctrl' }, 'a' ) end )

-- Goes to end of the line; ensure that we select if shift is pressed
modal:bind( '', 'o', function() modal.triggered = true; fastKeyStroke( {}, 'end' ) end )
-- modal:bind( { 'shift' }, 'o', function() modal.triggered = true; fastKeyStroke( { 'shift', 'ctrl' }, 'e' ) end )

-- Goes to end of the line; ensure that we select if shift is pressed
modal:bind( '', 'w', function() modal.triggered = true; fastKeyStroke( {'alt'}, 'delete' ) end )

-- PageUp / PageDown
-- modal:bind( '', 'y', function() fastKeyStroke( {}, 'pageup' ) end )
-- modal:bind( '', 'n', function() fastKeyStroke( {}, 'pagedown' ) end )

-- Delete... Seems like I also do that right after selecting while still holding shift so need to cover this case too
modal:bind( '', 'p', function() modal.triggered = true; fastKeyStroke( {}, 'delete' ) end )
modal:bind( 'shift', 'p', function() modal.triggered = true; fastKeyStroke( { 'shift' }, 'delete' ) end )

--  Vim like directions: hjkl
--   ensure that selection is made if shift is pressed
modal:bind( '', 'j', function() modal.triggered = true; fastKeyStroke( {}, 'down' ) end, nil, function() fastKeyStroke( {}, 'down' ) end )
modal:bind( { 'shift' }, 'j', function() modal.triggered = true; fastKeyStroke( { 'shift' }, 'down' ) end, nil, function() fastKeyStroke( { 'shift' }, 'down' ) end )

modal:bind( '', 'k', function() modal.triggered = true; fastKeyStroke( {}, 'up' ) end, nil, function() fastKeyStroke( {}, 'up' ) end )
modal:bind( { 'shift' }, 'k', function() modal.triggered = true; fastKeyStroke( { 'shift' }, 'up' ) end, nil, function() fastKeyStroke( { 'shift' }, 'up' ) end )
modal:bind( '', 'h', function() modal.triggered = true; fastKeyStroke( {}, 'left' ) end, nil, function() fastKeyStroke( {}, 'left' ) end )
modal:bind( { 'shift' }, 'h', function() modal.triggered = true; fastKeyStroke( { 'shift' }, 'left' ) end, nil, function() fastKeyStroke( { 'shift' }, 'left' ) end )

modal:bind( '', 'l', function() modal.triggered = true; fastKeyStroke( {}, 'right' ) end, nil, function() fastKeyStroke( {}, 'right' ) end )
modal:bind( { 'shift' }, 'l', function() modal.triggered = true; fastKeyStroke( { 'shift' }, 'right' ) end, nil, function() fastKeyStroke( { 'shift' }, 'right' ) end )

-- Space
modal:bind( '', 'b', function() modal.triggered = true; space:disable(); fastKeyStroke( {}, 'space' ); space:enable() end, nil, function() space:disable(); fastKeyStroke( {}, 'space' ); space:enable() end )

-- Escape
modal:bind( '', '[', function() modal.triggered = true; fastKeyStroke( {}, 'escape' ) end )

-- Return
modal:bind( '', 'm', function() modal.triggered = true; fastKeyStroke( {}, 'return' ) end )

-- Enter Hyper Mode when Spacebar is pressed
pressedSpace = function()
  modal.triggered = false
  modal:enter()
end

-- Leave Hyper Mode when Spacebar is pressed,
--   send space if no other keys are pressed.
releasedSpace = function()
  modal:exit()
  if not modal.triggered then
    space:disable() -- hs seems to be triggered by his onw keyStroke, so needs to be disables before we can emit the space
    fastKeyStroke( {}, 'space' )
    space:enable()
  end
end

-- Main binding on spacebar
space = hs.hotkey.bind( {}, 'space', pressedSpace, releasedSpace )
