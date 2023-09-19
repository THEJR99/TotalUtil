-- Create a new module
local ActionChain = {}
ActionChain.__index = ActionChain

-- Private variable to store the chained actions
local actions = {}

-- Private variable to track if the chain should execute
local shouldExecute = false

-- Constructor to create a new ActionChain instance
function ActionChain.new()
    local self = setmetatable({}, ActionChain)
    return self
end

-- Function to add an action to the chain
function ActionChain:addAction(actionFunction)
    table.insert(actions, actionFunction)
    return self -- Return self to allow chaining
end

-- Function to add a heartbeat event to the chain
function ActionChain:addHeartbeatEvent(callbackFunction)
    print('HEARTBEAT')
    if shouldExecute then
        -- If the chain should execute, connect the heartbeat event
        local connection
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            callbackFunction()
            connection:Disconnect() -- Disconnect the event after executing once
        end)
    end
    return self -- Return self to allow chaining
end

-- Metamethod to execute the chain when treated as a function
ActionChain.__call = function()
    print('CALLED')
    shouldExecute = true
    for _, action in ipairs(actions) do
        action()
    end
end

-- Return the module
return ActionChain