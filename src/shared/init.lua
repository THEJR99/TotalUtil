local TS = game:GetService('TweenService')
local RS = game:GetService('RunService')

local util = {}
util.__index = util

function util.Tween()
	--local self = setmetatable(util)
end

function util.NumberTween(startValue: number, tweenInfo: TweenInfo, endValue) : RBXScriptSignal
    local self = setmetatable(util)

    local numberValue = Instance.new('NumberValue')
        numberValue.Value = startValue

    self._ExecutionList = {
        Connection = nil
    }






    function self.Start()
        TS:Create(numberValue, tweenInfo, {Value = endValue}):Play()
    end

    function self.ValueChanged()
        local connection
        connection = RS.Heartbeat:Connect(function()
            if numberValue.Value ~= endValue then
                print()
            end
            connection:Disconnect()
        end)
        return connection
    end


    return self
end

return util