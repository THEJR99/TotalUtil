-- Create a new module
local TweenWrapper = {}
TweenWrapper.__index = TweenWrapper

-- Constructor
function TweenWrapper.new(object, tweenInfo, properties)
    local self = setmetatable({}, TweenWrapper)
    self.object = object
    self.tweenInfo = tweenInfo
    self.properties = properties
    self.events = {}
    self.finishedCallback = nil
    self.heartbeatConnection = nil
    self.finishedConnection = nil
    return self
end

-- Function to add a new event to the chain
function TweenWrapper:andThen(callback)
    table.insert(self.events, callback)
    return self -- Return self to allow chaining
end

-- Function to add the Changed event
function TweenWrapper:Changed(callback)
    self.heartbeatConnection = game:GetService("RunService").Heartbeat:Connect(function()
        for i, _ in pairs(self.properties) do
           callback(self.object[i])
        end
    end)
    return self
end

-- Function to add the Finished event
function TweenWrapper:Finished(callback)
    self.finishedCallback = callback

    self.finishedConnection = self.object.AncestryChanged:Connect(function()
        if self.object.Parent == nil then
            callback()
            self.finishedConnection:Disconnect()
        end
    end)
    return self
end

-- Function to start the tween
function TweenWrapper:Start()
    local tween = game:GetService("TweenService"):Create(self.object, self.tweenInfo, self.properties) -- Replace with your target values
    tween:Play()
    tween.Completed:Connect(function()
        if self.heartbeatConnection then
            self.heartbeatConnection:Disconnect()
        end
        if self.finishedConnection then
            self.finishedConnection:Disconnect()
            self.finishedCallback()
        end
        for _, event in ipairs(self.events) do
            event()
        end
    end)
end

-- Function to yield until the tween finishes
function TweenWrapper:Await()
    local tween = game:GetService("TweenService"):Create(self.object, self.tweenInfo, self.properties) -- Replace with your target values
    tween:Play()

    task.wait(self.tweenInfo.Time)

    if self.heartbeatConnection then
        self.heartbeatConnection:Disconnect()
    end
    if self.finishedConnection then
        self.finishedConnection:Disconnect()
        self.finishedCallback()
    end
    for _, event in ipairs(self.events) do
        event()
    end
end

-- Return the module
return TweenWrapper