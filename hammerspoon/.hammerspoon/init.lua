local hyper = {"ctrl", "alt", "shift", "cmd"}

-- Key → App name map
local appBindings = {
    D = "Alacritty",
    F = "Brave Browser",
    O = "Obsidian",
}

for key, appName in pairs(appBindings) do
    hs.hotkey.bind(hyper, key, function()
        hs.application.launchOrFocus(appName)
    end)
end

-- Maximize the currently focused window without fullscreen
hs.hotkey.bind({"alt"}, "M", function()
    local win = hs.window.focusedWindow()
    if win then
        local screenFrame = win:screen():frame()
        win:setFrame(screenFrame)
    else
        hs.alert("No focused window")
    end
end)

-- Cycle through windows of the currently focused app
hs.hotkey.bind(hyper, "C", function()
    local app = hs.application.frontmostApplication()
    if not app then return end

    local windows = hs.fnutils.filter(app:allWindows(), function(win)
        return win:isStandard() and win:isVisible()
    end)

    if #windows < 2 then
        return
    end

    -- Sort for stable order (e.g., by window ID or x-position)
    table.sort(windows, function(a, b)
        return a:id() < b:id()
    end)

    local focusedWin = hs.window.focusedWindow()
    local currentIndex = hs.fnutils.indexOf(windows, focusedWin) or 0
    local nextIndex = (currentIndex % #windows) + 1

    windows[nextIndex]:focus()
end)

-- Move window to left half
hs.hotkey.bind(hyper, "H", function()
    local win = hs.window.focusedWindow()
    if win then
        local f = win:screen():frame()
        win:setFrame({x = f.x, y = f.y, w = f.w / 2, h = f.h})
    end
end)

-- Move window to right half
hs.hotkey.bind(hyper, "L", function()
    local win = hs.window.focusedWindow()
    if win then
        local f = win:screen():frame()
        win:setFrame({x = f.x + (f.w / 2), y = f.y, w = f.w / 2, h = f.h})
    end
end)

-- Move window to top half
hs.hotkey.bind(hyper, "K", function()
    local win = hs.window.focusedWindow()
    if win then
        local f = win:screen():frame()
        win:setFrame({x = f.x, y = f.y, w = f.w, h = f.h / 2})
    end
end)

-- Move window to bottom half
hs.hotkey.bind(hyper, "J", function()
    local win = hs.window.focusedWindow()
    if win then
        local f = win:screen():frame()
        win:setFrame({x = f.x, y = f.y + (f.h / 2), w = f.w, h = f.h / 2})
    end
end)

-- option + tab to display list of open windows
local windowModal = nil
local numberedWindows = {}
local dismissTimer = nil

hs.hotkey.bind({"alt"}, "tab", function()
    if windowModal then return end

    numberedWindows = {}
    local choices = {}
    local windows = hs.window.orderedWindows()

    for i = 1, math.min(#windows, 9) do
        local win = windows[i]
        local app = win:application():name()
        local title = win:title()

        table.insert(numberedWindows, win)
        table.insert(choices, string.format("[%d] %s — %s", i, app, title))
    end

    if #choices == 0 then
        hs.alert("No windows")
        return
    end

    hs.alert.closeAll()
    -- local alertId = hs.alert(table.concat(choices, "\n"))
    local alertId = hs.alert(table.concat(choices, "\n"), {}, hs.screen.mainScreen(), 10)

    -- Create modal for 1-9 keys
    windowModal = hs.hotkey.modal.new()
    for i = 1, #numberedWindows do
        windowModal:bind({}, tostring(i), function()
            hs.alert.closeSpecific(alertId)
            if dismissTimer then dismissTimer:stop() end
            local win = numberedWindows[i]
            if win then win:focus() end
            windowModal:exit()
            windowModal = nil
        end)
    end

    -- Escape to cancel
    windowModal:bind({}, "escape", function()
        hs.alert.closeSpecific(alertId)
        if dismissTimer then dismissTimer:stop() end
        windowModal:exit()
        windowModal = nil
    end)

    windowModal:enter()
end)
