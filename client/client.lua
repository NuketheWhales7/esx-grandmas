---------------------------Grandmas----------------------------
---------------------Made by NuketheWhales7 --------------------
----------------------Development Roleplay----------------------
Keys = {
  ["ESC"]       = 322,  ["F1"]        = 288,  ["F2"]        = 289,  ["F3"]        = 170,  ["F5"]  = 166,  ["F6"]  = 167,  ["F7"]  = 168,  ["F8"]  = 169,  ["F9"]  = 56,   ["F10"]   = 57, 
  ["~"]         = 243,  ["1"]         = 157,  ["2"]         = 158,  ["3"]         = 160,  ["4"]   = 164,  ["5"]   = 165,  ["6"]   = 159,  ["7"]   = 161,  ["8"]   = 162,  ["9"]     = 163,  ["-"]   = 84,   ["="]     = 83,   ["BACKSPACE"]   = 177, 
  ["TAB"]       = 37,   ["Q"]         = 44,   ["W"]         = 32,   ["E"]         = 38,   ["R"]   = 45,   ["T"]   = 245,  ["Y"]   = 246,  ["U"]   = 303,  ["P"]   = 199,  ["["]     = 116,  ["]"]   = 40,   ["ENTER"]   = 18,
  ["CAPS"]      = 137,  ["A"]         = 34,   ["S"]         = 8,    ["D"]         = 9,    ["F"]   = 23,   ["G"]   = 47,   ["H"]   = 74,   ["K"]   = 311,  ["L"]   = 182,
  ["LEFTSHIFT"] = 21,   ["Z"]         = 20,   ["X"]         = 73,   ["C"]         = 26,   ["V"]   = 0,    ["B"]   = 29,   ["N"]   = 249,  ["M"]   = 244,  [","]   = 82,   ["."]     = 81,
  ["LEFTCTRL"]  = 36,   ["LEFTALT"]   = 19,   ["SPACE"]     = 22,   ["RIGHTCTRL"] = 70, 
  ["HOME"]      = 213,  ["PAGEUP"]    = 10,   ["PAGEDOWN"]  = 11,   ["DELETE"]    = 178,
  ["LEFT"]      = 174,  ["RIGHT"]     = 175,  ["UP"]        = 27,   ["DOWN"]      = 173,
  ["NENTER"]    = 201,  ["N4"]        = 108,  ["N5"]        = 60,   ["N6"]        = 107,  ["N+"]  = 96,   ["N-"]  = 97,   ["N7"]  = 117,  ["N8"]  = 61,   ["N9"]  = 118
}


ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

if Config.EnableBlips then
Citizen.CreateThread(function()
    local blip = AddBlipForCoord(2433.91, 4965.50, 42.00)

    SetBlipSprite (blip, 357)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 59)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Grandmas House")
    EndTextCommandSetBlipName(blip)
    
end)
end

local reviving = false
local coords = { x = 2433.91, y = 4965.50, z = 42.00, h = 43.69 }

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local plyCoords = GetEntityCoords(PlayerPedId(), 0)
        local distance = #(vector3(coords.x, coords.y, coords.z) - plyCoords)
        if distance < 10 then

            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                if distance < 3 and not reviving then
			        Draw3DText(coords.x, coords.y, coords.z + 0.5, '[E] - Check in for '..Config.FineAmount)
                        if GetKeyPressed('E') then
                         ESX.TriggerServerCallback('devrp-grandmas:checkBalance', function(canPay)
                            if canPay then
                                reviving = true
                            if (GetEntityHealth(PlayerPedId()) <= 200) then
                                exports['mythic_progbar']:Progress({
                                    name = "grandmas_house",
                                    duration = 10500,
                                    label = "Checking In",
                                    useWhileDead = true,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "missheistdockssetup1clipboard@base",
                                        anim = "base",
                                        flags = 49,
                                    },
                                    prop = {
                                        model = "p_amb_clipboard_01",
                                        bone = 18905,
					                    coords = { x = 0.10, y = 0.02, z = 0.08 },
					                    rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                    propTwo = {
                                        model = "prop_pencil_01",
                                        bone = 58866,
					                    coords = { x = 0.12, y = 0.0, z = 0.001 },
					                    rotation = { x = -150.0, y = 0.0, z = 0.0 },
                                    },
                                }, function(status)
                                    if not status then
                                        exports['progressBars']:startUI(60000, "Treating, Do not move")
                                        Citizen.Wait(60000)
                                        --your revive script code goes here
                                        TriggerEvent('esx_ambulancejob:revive')
                                        --end revive code
                                        TriggerServerEvent('drp-grandmas:payBill')
                                        reviving = false
                                    end
                                end)
                            else
                                exports['mythic_notify']:DoHudText('error', 'You do not need medical attention')
                            end
                        else
                            exports['mythic_notify']:DoHudText('error', 'You do not have enough in your bank account')
                        end
                        end)
                     end  

                    end
                end
            else
                Citizen.Wait(1000)
            end
    end
end)

function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 68)
end

function GetKeyPressed(key)
  if not key then return false; end
  if (IsDisabledControlJustPressed(0, Keys[key]) or IsControlJustPressed(0, Keys[key])) then return true
  else return false; end
end
---------------------------Grandmas----------------------------
---------------------Made by NuketheWhales7 --------------------
----------------------Development Roleplay----------------------