Vector2D = Object.extend(Object)

function Vector2D:new(x, y)
    self.x = x or 0
    self.y = y or 0
end

function Vector2D:normalize()
    local length = math.sqrt(self.x * self.x + self.y * self.y)
    self.x = self.x / length
    self.y = self.y / length
end

function Vector2D:__tostring()
    return string.format("(%.2f, %.2f)", self.x, self.y)
end