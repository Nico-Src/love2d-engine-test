Label = Object.extend(Object)

function Label:new(x,y,size,text)
    self.pos = Vector2D(x or 0, y or 0)
    self.size = size
    self.text = text
end

function Label:update(dt)
    
end

function Label:updateUI(dt)
    
end

function Label:draw()
    local textSize = {love.graphics.getFont():getWidth(self.text), love.graphics.getFont():getHeight()}
    -- draw in center
    love.graphics.print(self.text, self.pos.x + (self.size.x / 2) - (textSize[1] / 2), self.pos.y + (self.size.y / 2) - (textSize[2] / 2))
end