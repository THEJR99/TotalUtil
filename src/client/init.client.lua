local TotalUtil = require(game:GetService('ReplicatedStorage'):WaitForChild('Shared'):WaitForChild('TotalUtil'))
--local TestModule = require(game:GetService('ReplicatedStorage'):WaitForChild('Shared'):WaitForChild('TestModule'))
--local TweenWrapper = require(game:GetService('ReplicatedStorage'):WaitForChild('Shared'):WaitForChild('TweenWrapper'))

task.wait(1.5)
print('Init')
local v = Instance.new('NumberValue')
v.Value = 0

TotalUtil.Tween(v, TweenInfo.new(3), {Value = 10}):Changed(function(value)
    print(value)
end):Finished(function()
    print('Done!')
end):Await()