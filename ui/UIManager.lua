UIManager = Object.extend(Object)

function UIManager:new()
    gameUILayer = UILayer("game-ui", false, 0, 0, love.graphics.getWidth(), love.graphics.getHeight(), {}, true)
    gameUIComponents = {
        Button(love.graphics.getWidth() - 70, 30, Vector2D(40,40), "settings", "", function() self:setLayerVisibility("pause-menu", true); game_paused = true; end)
    }
    gameUILayer.components = gameUIComponents

    pauseMenuLayer = UILayer("pause-menu", true, (love.graphics.getWidth() / 2) - 150, 100, 300, 300, {})
    pauseMenuComponents = {
        Label(pauseMenuLayer.pos.x, pauseMenuLayer.pos.y, Vector2D(pauseMenuLayer.size.x, 40), "Paused"),
        Button(pauseMenuLayer.pos.x, pauseMenuLayer.pos.y + 45, Vector2D(pauseMenuLayer.size.x, 40), "empty", "Back to Game", function() self:setLayerVisibility("pause-menu", false); self:setLayerVisibility("game-ui", true); game_paused = false; end),
        Button(pauseMenuLayer.pos.x, pauseMenuLayer.pos.y + 90, Vector2D(pauseMenuLayer.size.x, 40), "empty", "Settings", function() end),
        Button(pauseMenuLayer.pos.x, pauseMenuLayer.pos.y + 135, Vector2D(pauseMenuLayer.size.x, 40), "empty", "Back to Menu", function() end)
    }
    pauseMenuLayer.components = pauseMenuComponents

    self.layers = {
        gameUILayer,
        pauseMenuLayer
    }

    -- set game ui to active layer
    self.activeLayer = self.layers[1]
    self.activeLayer.show = true
end

function UIManager:update(dt)
    -- update every layer
    for i = 1, #self.layers do
        self.layers[i]:update(dt)
    end

    -- only update ui of active layer
    if(self.activeLayer) then
        self.activeLayer:updateUI(dt)
    end
end

function UIManager:draw()
    -- draw each layer
    for i = 1, #self.layers do
        self.layers[i]:draw()
    end
end

function UIManager:setLayerVisibility(id, show)
    -- show/hide layer with given id and hide others
    for i = 1, #self.layers do
        if(self.layers[i].id == id) then
            self.layers[i].show = show
            self.activeLayer = self.layers[i]
        else 
            self.layers[i].show = false
        end
    end
end