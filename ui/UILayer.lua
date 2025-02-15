UILayer = Object.extend(Object)

function UILayer:new(id,overlay,x,y,width,height,components,permanent)
    self.id = id
    self.pos = Vector2D(x or 0, y or 0)
    self.size = Vector2D(width or 0, height or 0)
    self.scale = Vector2D(1, 1)
    self.show = false
    self.components = components
    self.opacity = 0
    self.overlay = overlay
    self.permanent = permanent or false
end

function UILayer:update(dt)
    -- calc opacity change rate
    local transitionTime = 0.125
    local opacityChangeRate = 0.5 / transitionTime -- This is 1.0

    -- fade in/out
    if(self.show and self.opacity < .5) then
        self.opacity = self.opacity + (dt * opacityChangeRate)
    elseif(not self.show and self.opacity > 0) then
        self.opacity = self.opacity - (dt * opacityChangeRate)
    end

    -- cap opacity between 0 and .5
    if(self.opacity < 0) then self.opacity = 0 end
    if(self.opacity > .5) then self.opacity = .5 end

    -- update each component
    for i = 1, #self.components do
        self.components[i]:update(dt)
    end
end

function UILayer:updateUI(dt)
    -- update each component
    for i = 1, #self.components do
        self.components[i]:updateUI(dt)
    end
end

function UILayer:draw()
    -- draw bg overlay
    if(self.overlay) then
        love.graphics.setColor(0, 0, 0, self.opacity)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(1, 1, 1)
    end

    -- if show then draw window
    if(self.show or self.permanent) then
        -- draw each component
        for i = 1, #self.components do
            self.components[i]:draw()
        end
    end
end