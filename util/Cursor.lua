Cursor = Object.extend(Object)

function Cursor:new()
    self.sprite = love.graphics.newImage("assets/cursor.png")
    self.size = 0.7;
    love.mouse.setVisible(false)
end

function Cursor:draw()
    love.graphics.draw(self.sprite, love.mouse.getX(), love.mouse.getY(), 0, self.size, self.size)
end