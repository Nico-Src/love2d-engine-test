Button = Object.extend(Object)

function Button:new(x,y,size,file,text,onClick)
    self.pos = Vector2D(x or 0, y or 0)
    self.size = size
    self.scale = Vector2D(1, 1)
    self.sprite = love.graphics.newImage("assets/buttons/"..file..".png")
    self.pressed_sprite = love.graphics.newImage("assets/buttons/"..file.."_pressed.png")
    print(self.sprite:getWidth(), self.sprite:getHeight())
    self.text = text
    self.sprite:setFilter("nearest", "nearest")
    self.pressed_sprite:setFilter("nearest", "nearest")
    -- dont repeat
    self.sprite:setWrap("repeat", "clampzero")
    self.pressed_sprite:setWrap("repeat", "clampzero")
    
    scaleRatioX = self.size.x / self.sprite:getWidth()
    scaleRatioY = self.size.y / self.sprite:getHeight()
    self.scale.x = scaleRatioX
    self.scale.y = scaleRatioY

    self.disabled = false
    self.hovered = false
    self.active = false

    self.color = {1, 1, 1}
    self.hoverColor = {.7, .7, .7}
    self.activeColor = {.5, .5, .5}

    self.onClick = onClick

    self.__btn_cooldown = 0.5
    self.__btn_timer = 0
    self.__mouse_down_prev = false
end

function Button:update(dt)
    -- update button timer
    if(self.__btn_timer > 0) then
        self.__btn_timer = self.__btn_timer - dt
    end

    -- if button is disabled then set active to false
    if(self.disabled) then
        self.active = false
        return
    end
end

function Button:updateUI(dt)
    -- check if mouse is over
    self.hovered = self:mouseInRect(self.pos.x, self.pos.y, self.size.x, self.size.y)

    local mouse_down = love.mouse.isDown(1)

    -- check if mouse is down
    if(mouse_down and self.hovered) then
        self.active = true
    else
        self.active = false
    end

    local was_mouse_down = self.__mouse_down_prev  -- Store the previous state
    self.__mouse_down_prev = love.mouse.isDown(1)  -- Update AFTER storing

    -- if the mouse was just down and the button is hovered (released in this frame) trigger onclick
    if (was_mouse_down and not self.__mouse_down_prev and self.hovered) then
        -- Trigger onclick when the button is released
        if self.__btn_timer <= 0 then
            self.__btn_timer = self.__btn_cooldown
            self.onClick()
        end
    end
end

function Button:draw()
    -- based on hovered and active state choose color
    if(self.active) then
        love.graphics.setColor(unpack(self.activeColor))
    elseif(self.hovered) then
        love.graphics.setColor(unpack(self.hoverColor))
    else
        love.graphics.setColor(unpack(self.color))
    end
    
    -- draw sprite (or pressed sprite if active)
    love.graphics.draw(self.active and self.pressed_sprite or self.sprite, self.pos.x, self.pos.y, 0, self.scale.x, self.scale.y)

    -- draw text if there is any
    if(self.text) then
        -- draw in center of button
        local textSize = {love.graphics.getFont():getWidth(self.text), love.graphics.getFont():getHeight()}
        local yOffset = self.active and 0 or 5 
        love.graphics.print(self.text, self.pos.x + (self.size.x / 2) - (textSize[1] / 2), self.pos.y + (self.size.y / 2) - (textSize[2] / 2) - yOffset)
    end

    love.graphics.setColor(1, 1, 1)
end

-- check if mouse is in rect
function Button:mouseInRect(x,y,w,h)
    return x < love.mouse.getX() and x + w > love.mouse.getX() and y < love.mouse.getY() and y + h > love.mouse.getY()
end