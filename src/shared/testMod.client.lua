local TotalUtil = require(script.Parent:waitForChild('init'))

task.wait(3)

local tweenInfo = TweenInfo.new(3)

TotalUtil.NumberTween(1, tweenInfo, 10):ValueChanged(function()
    
end)