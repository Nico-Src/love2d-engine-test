Player = Object.extend(Object)
ORIENTATION = {LEFT = "-1", RIGHT = "1"}

function Player:new(x, y)
    self.pos = Vector2D(x or 0, y or 0)
    self.offset = Vector2D(0, 0)
    self.vel = Vector2D(0, 0)
    self.orientation = ORIENTATION.RIGHT
    self.speed = 200
    self.sprite = love.graphics.newImage("assets/knight-player.png")
    self.sprite:setFilter("nearest", "nearest")
end

function Player:update(dt)
    -- calculate final speed
    sprinting = love.keyboard.isDown("lshift")
    final_speed = self.speed * (sprinting and 2 or 1)

    self.vel.x = 0
    self.vel.y = 0

    -- set velocity based on input
    if(love.keyboard.isDown("w")) then
        self.vel.y = -1
    end

    if(love.keyboard.isDown("s")) then
        self.vel.y = 1
    end

    if(love.keyboard.isDown("a")) then
        self.vel.x = -1
    end

    if(love.keyboard.isDown("d")) then
        self.vel.x = 1
    end

    -- normalize velocity
    if(self.vel.x ~= 0 or self.vel.y ~= 0) then
        self.vel:normalize()
    end

    -- update orientation
    if(self.vel.x < 0) then
        self.orientation = ORIENTATION.LEFT
    elseif(self.vel.x > 0) then
        self.orientation = ORIENTATION.RIGHT
    end

    -- update offset based on orientation
    if self.orientation == ORIENTATION.LEFT then
        self.offset.x = self.sprite:getWidth()
    else
        self.offset.x = 0
    end

    -- update position
    self.pos.x = self.pos.x + self.vel.x * final_speed * dt
    self.pos.y = self.pos.y + self.vel.y * final_speed * dt
end

function Player:draw()
    -- draw player
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("line", 20, 20, love.graphics.getWidth() - 40, love.graphics.getHeight() - 40)
    love.graphics.draw(self.sprite, self.pos.x + self.offset.x, self.pos.y, 0, self.orientation == ORIENTATION.RIGHT and 1 or -1, 1)
end