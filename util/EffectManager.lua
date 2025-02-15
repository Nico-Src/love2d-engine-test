local moonshine = require 'libs/moonshine'

EffectManager = Object.extend(Object)

function EffectManager:new()
    mainEffect = moonshine(moonshine.effects.crt).chain(moonshine.effects.scanlines).chain(moonshine.effects.filmgrain)
    mainEffect.crt.distortionFactor = {1.05, 1.055}
    mainEffect.scanlines.frequency = 80
    mainEffect.scanlines.opacity = 0.25
    mainEffect.scanlines.phase = 1
    mainEffect.scanlines.thickness = 1
    mainEffect.scanlines.color = {40, 40, 40}

    self.effects = {
        main = mainEffect
    }

    self.phase = 0
end

function EffectManager:update(dt)
    self.phase = (self.phase + (dt * 10)) % 100
    self.effects['main'].scanlines.phase = phase
end

function EffectManager:getEffect(id)
    return self.effects[id]
end