local TotalUtil = require(game:GetService('ReplicatedStorage'):WaitForChild('Shared'):WaitForChild('MainModule'))
--local TestModule = require(game:GetService('ReplicatedStorage'):WaitForChild('Shared'):WaitForChild('TestModule'))

task.wait(1.5)
print('RUN')

local tweenInfo = TweenInfo.new(3)

TotalUtil.NumberTween(1, tweenInfo, 10):Changed(function(value)
    print(value)
end):Finished(function(re)
    print(re)
end):Start()