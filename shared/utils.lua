local function validateNonNil(value, errorMessage)
	if value == nil then return error(errorMessage) end
end

local function validateTypeAndNonNil(value, type, errorMessage)
	validateNonNil(value, "Value is nil.")
	if type(value) ~= type then return error(errorMessage) end
end

exports('validateNonNil', validateNonNil)

exports('validateTypeAndNonNil', validateTypeAndNonNil)