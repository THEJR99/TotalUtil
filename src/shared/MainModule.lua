local TS = game:GetService('TweenService')
local RS = game:GetService('RunService')

local util = {}

function util.Tween()
	--local self = setmetatable(util)
end

function util.NumberTween(startValue: number, tweenInfo: TweenInfo, endValue) : RBXScriptSignal
    local self = {}
    self.__index = self

    print('Start: ' .. startValue .. ' End: ' .. endValue)

    local numberValue = Instance.new('NumberValue')
    numberValue.Value = startValue

    self._RunVariables = {
        RunConnection = false,
        Finished = false
    }

    self._ExecutionList = {
        Changed = false,
        Finished = false
    }


    function self.Changed(_, callbackFunction)
        self._ExecutionList.Changed = true
        local connection
        connection = RS.Heartbeat:Connect(function()
            if not self._RunVariables.RunConnection then return end

            print(numberValue.Value)
            if numberValue.Value ~= endValue then
                callbackFunction(numberValue.Value) -- Returns Value --
            end

            print('END: ' .. numberValue.Value)
            connection:Disconnect()
            callbackFunction(numberValue.Value)
        end)
        return self
    end

    function self.Finished(_, callbackFunction)
        self._ExecutionList.Finished = callbackFunction
        return self
    end

    function self.Start()
        print('Tweening')
        TS:Create(numberValue, tweenInfo, {Value = endValue}):Play()
        self._RunVariables.RunConnection = true

        coroutine.wrap(function()
            task.wait(tweenInfo.Time) -- waits and doesnt yeild until tween finishes --
            print('Finished tweening')
            if self._ExecutionList.Finished then -- Runs :Finished() event if chained --
                self._ExecutionList.Finished()
            end
        end)()

        return
    end

    function self.Await()
        TS:Create(numberValue, tweenInfo, {Value = endValue}):Play()

        task.wait(tweenInfo.Time)
        if self._ExecutionList.Finished then -- Runs :Finished() event if chained --
            self._ExecutionList.Finished('Callback!')
        end
        return
    end

    return self
end

return util