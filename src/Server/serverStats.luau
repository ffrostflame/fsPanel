local RunService = game:GetService("RunService")
local Stats = game:GetService("Stats")

local enums = require(script.Parent.Parent.enums)

local function floatToString(number: number, place: number?)
	local split = string.split(tostring(number), ".")
	local wholeNumber = split[1]
	if place == nil then
		return wholeNumber
	else
		return wholeNumber .. "." .. string.sub(split[2] or "", 1, place)
	end
end

local serverStats = {}

local currentFps = 60

function serverStats.init()
	RunService.Heartbeat:Connect(function(deltaTime)
		-- 1 / deltaTime is the reverse of 1 / 60
		currentFps = 1 / deltaTime
	end)
end

function serverStats._getServerStatsArray()
	return {
		[enums.ServerStatItems.DataReceiveKbps] = floatToString(Stats.DataReceiveKbps, 3),
		[enums.ServerStatItems.DataSendKbps] = floatToString(Stats.DataSendKbps, 3),
		[enums.ServerStatItems.HeartbeatTimeMs] = floatToString(Stats.HeartbeatTimeMs, 3),
		[enums.ServerStatItems.PhysicsStepTimeMs] = floatToString(Stats.PhysicsStepTimeMs, 3),
		[enums.ServerStatItems.ServerFps] = floatToString(currentFps, 3),
		[enums.ServerStatItems.TotalMemoryUsageMb] = floatToString(Stats:GetTotalMemoryUsageMb())
	}
end

function serverStats.getServerStats()
	return {
		DataReceiveKbps = floatToString(Stats.DataReceiveKbps, 3),
		DataSendKbps = floatToString(Stats.DataSendKbps, 3),
		HeartbeatTimeMs = floatToString(Stats.HeartbeatTimeMs, 3),
		PhysicsStepTimeMs = floatToString(Stats.PhysicsStepTimeMs, 3),
		ServerFps = floatToString(currentFps, 3),
		TotalMemoryUsageMb = floatToString(Stats:GetTotalMemoryUsageMb())
	}
end

return serverStats