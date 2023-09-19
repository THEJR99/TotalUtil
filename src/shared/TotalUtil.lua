local TweenWrapper = require(script.Parent.TweenWrapper)

local util = {}
util.__index = util

function util.Tween(object: any, tweenInfo: TweenInfo, properties: table)
	return TweenWrapper.new(object, tweenInfo, properties)
end


return util