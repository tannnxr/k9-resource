local DOG_SPAWNED = false

local noDogMenu = MenuV:CreateMenu('K9 Spawn Menu', 'You don\'t have a dog yet, spawn one in with the button.',
	'topright', 255, 0, 0, 'size-125', 'default', 'menuv',
	'SpawnDogMenu', 'native');

local spawnDogBtn = noDogMenu:AddButton({
	icon = '🐕‍🦺',
	label = 'Spawn K9',
	value = nil,
	description = 'Spawn in K9'
});

local k9Menu = MenuV:CreateMenu('K9 Menu', 'Manage your K9 in this menu', 'topright', 255, 0, 0, 'size-125', 'default',
	'menuv',
	'K9ManagementMenu', 'native');


k9Menu:AddButton({ icon = '', label = 'Dog State', description = 'The current K9 state.', disabled = true })
k9Menu:AddCheckbox({ icon = '', label = 'Defend Handler', description = 'Make your K9 defend you from threats.', value = false, disabled = false })
k9Menu:AddSlider({
	icon = '',
	label = 'K9 States',
	description = 'Change your K9\'s state',
	values = {
		{ label = 'Defend Handler', description = 'Set your dog to defend you. [Follows]' }
	}
})
function getPlayerCoordsWithOffset()
	return GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
end

function requestModel(modelName)
	RequestModel(modelName)
	while not HasModelLoaded(modelName) do
		Wait(1)
	end
end

local function createBlip(entity, dogName)
	local blip = AddBlipForEntity(entity)
	SetBlipAsFriendly(blip, true)
	SetBlipSprite(blip, 144)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("[K9] " .. dogName)
	EndTextCommandSetBlipName(blip)
	return blip
end

function spawnDog(name)
	local playerOffset = getPlayerCoordsWithOffset()
	PED_NAME = 'a_c_shepherd'
	requestModel(PED_NAME)
	local dog = CreatePed(28, PED_NAME, playerOffset.x, playerOffset.y, playerOffset.z, GetEntityHeading(PlayerPedId()),
		false, true)
	createBlip(dog, name)
end

function SpawnK9Selected()
	local dogName = nil
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
	while UpdateOnscreenKeyboard() == 0 do
		DisableAllControlActions(0);
		Wait(0);
	end

	if GetOnscreenKeyboardResult() then
		dogName = GetOnscreenKeyboardResult()
	end

	spawnDog(dogName)
	noDogMenu:Close()
	DOG_SPAWNED = true
	noDogMenu:OpenWith(nil, nil)
end

function authorize()

end

RegisterCommand('spawnk9', function()
	if DOG_SPAWNED == true then return end
	authorize()
	noDogMenu:Open()
end, false)

spawnDogBtn:On('OnSelect', SpawnK9Selected)


Citizen.CreateThread(function()
	while DOG_SPAWNED == false do
		Citizen.Wait(500)
	end

	k9Menu:OpenWith('KEYBOARD', 'F6')
end)


print(noDogMenu);
print(k9Menu);
