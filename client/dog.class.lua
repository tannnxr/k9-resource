local dog = {}

local self = {}

function self:__getOwnerPosition(owner)
end

function self:__getOffsetOfPosition(position)
end

function self:sit()
end

function self:setTarget(targetEntity)
	self.target = targetEntity
end

function self:attackTarget()
	
end

setmetatable(dog, self)