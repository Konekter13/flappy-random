--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}
medal = ""
local gold = love.graphics.newImage('medal1.png')
local silver = love.graphics.newImage('medal2.png')
local bronze = love.graphics.newImage('medal3.png')
--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:giveMedal()
    local medal = ""
    if self.score >= 20 then
        medal = "Gold Medal"
    elseif self.score >= 10 then
        medal = "Silver Medal"
    else
        medal = "Bronze Medal"
    end
    return medal
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    local medal = self:giveMedal()
    love.graphics.printf('You won a  ' .. medal, 0, 120, VIRTUAL_WIDTH, 'center')

    if medal == "Gold Medal" then
        love.graphics.draw(gold, VIRTUAL_WIDTH/2-25, 140)
    elseif medal == "Silver Medal" then
        love.graphics.draw(silver, VIRTUAL_WIDTH/2-25, 140)
    else
        love.graphics.draw(bronze,VIRTUAL_WIDTH/2-25, 140)
    end
    
    love.graphics.printf('Press Enter to Play Again!', 0, 200, VIRTUAL_WIDTH, 'center')
end