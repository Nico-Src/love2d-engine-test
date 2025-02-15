io.stdout:setvbuf("no")

function love.load()
    Object = require "libs/classic"
    require "util/Vector2D"
    require "util/Cursor"
    require "util/EffectManager"
    require "ui/UIManager"
    require "ui/Label"
    require "ui/Button"
    require "ui/UILayer"
    require "classes/player"

    player = Player(50,50)
    cursor = Cursor()
    font = love.graphics.newFont("fonts/PixelGame.ttf", 16)
    ui_manager = UIManager()
    effect_manager = EffectManager()
    game_paused = false
end

function love.update(dt)
    effect_manager:update(dt)
    ui_manager:update(dt)
   
    if(not game_paused) then
        player:update(dt)
    end

    if(love.keyboard.isDown("escape")) then
        love.event.quit()
    end
end

function love.draw()
    effect_manager:getEffect("main")(function()
        -- draw black background
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

        player:draw();

        love.graphics.setFont(font)
        love.graphics.print("FPS: "..love.timer.getFPS(), 30, 30)
        -- output position of player
        love.graphics.print("X: "..(math.floor(player.pos.x + 0.5))..", Y: "..(math.floor(player.pos.y + 0.5)), 30, 45)

        ui_manager:draw()

        -- draw cursor
        cursor:draw()
    end)
end