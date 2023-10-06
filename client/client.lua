local Marker = {
    ["Type"] = 2,
    ["Size"] = {x = 0.30, y = 0.30, z = 0.30},
    ["Colors"] = {
        ["r"] = 255,
        ["g"] = 0,
        ["b"] = 0,
        ["alpha"] = 100
    }
}

local buttonPressed = false -- DONT CHANGE
local item = {}
local ox_inventory = exports.ox_inventory


Citizen.CreateThread(function()
    while true do
        Wait(0)
		local val
        local coords = GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(Config.Location) do
            local dist = #(coords - v.Coords)
            if dist < 3 and buttonPressed == false then
                DrawMarker(Marker.Type, v.Coords.x, v.Coords.y, v.Coords.z, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, Marker.Size.x, Marker.Size.y, Marker.Size.z, Marker.Colors.r, Marker.Colors.g, Marker.Colors.b, Marker.Colors.alpha, false, true, 2, false, false, false, false)
                SetTextComponentFormat("STRING")
                AddTextComponentString(v.text)
                DisplayHelpTextFromStringLabel(0, 0, 1, -1)
                if IsControlJustPressed(1, 38) then
                    TriggerEvent('drug:checkclient',v)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if buttonPressed and Config.checkWeapon then
            SetCurrentPedWeapon(GetPlayerPed(-1), GetHashKey("WEAPON_UNARMED"), true)
            DisablePlayerFiring(GetPlayerPed(-1), true)
        end

        if IsControlJustPressed(1, 323) and buttonPressed then
            exports.rprogress:Stop()
            buttonPressed = false
        end
    end
end)

RegisterNetEvent('refresh:state')
AddEventHandler('refresh:state', function(v)
    buttonPressed = v
end)

RegisterNetEvent('drug:checkclient')
AddEventHandler('drug:checkclient', function(v)
    item = v
    if not buttonPressed then
        buttonPressed = true
        if item.type ~= "process" then
            TriggerServerEvent('drug:Anim')
        else
            TriggerServerEvent('check:item',item.Add,item.Remove,item.Remove2)
        end
    end
end)

RegisterNetEvent('drug:StartAction')
AddEventHandler('drug:StartAction', function()
    LoadAnim("anim@amb@business@coc@coc_unpack_cut_left@")
    TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut_left@", "coke_cut_v4_coccutter", 8.0, 8.0, -1, 50, 0, false, false, false)
    exports.rprogress:Custom({
        Async = true,
        canCancel = true,       -- Allow cancelling
        cancelKey = 323,        -- Custom cancel key
        Duration = Config.progressDuration,
        Label = "",
        Animation = {
            scenario = "", -- https://pastebin.com/6mrYTdQv
        },
        DisableControls = {
            Mouse = false,
            Player = true,
            Vehicle = true
        },
        onComplete = function(cancelled)
            if not cancelled then
                buttonPressed = false
                ClearPedTasks(PlayerPedId())
                if item.type == "collect" and item.Remove == nil then
                    TriggerServerEvent('drug:collect',item.Add)
                elseif item.type == "process" and item.Remove2 == nil then
                    TriggerServerEvent('drug:process',item.Add,item.Remove,nil)
                elseif item.type == "process" and item.Remove2 ~= nil then
                    TriggerServerEvent('drug:process',item.Add,item.Remove,item.Remove2)
                end
            end
        end
    })
end)

function LoadAnim(animDict)
RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(10)
    end
end