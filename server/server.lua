local can = true -- DONT CHANGE

RegisterServerEvent('drug:Anim')
AddEventHandler('drug:Anim', function()
    local src = source
    TriggerClientEvent('drug:StartAction',src)
end)

RegisterServerEvent('drug:collect')
AddEventHandler('drug:collect', function(itemAdd)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local random = math.random(Config.randomMin,Config.randomMax)
    xPlayer.addInventoryItem(itemAdd, random) 
end)

RegisterServerEvent('check:drug')
AddEventHandler('check:drug', function(bool)
    can = bool
end)

RegisterServerEvent('check:item')
AddEventHandler('check:item', function(itemAdd,itemRemove,itemRemove2)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getInventoryItem(itemRemove).count >= Config.removeAmount and itemRemove2 == nil or xPlayer.getInventoryItem(itemRemove).count >= Config.removeAmount and xPlayer.getInventoryItem(itemRemove2).count >= Config.removeAmount then
        TriggerClientEvent('drug:StartAction',src)
    else
        xPlayer.showNotification("You don't have the min amount of item")
        TriggerClientEvent('refresh:state',source,false)
        return
    end
end)

RegisterServerEvent('drug:process')
AddEventHandler('drug:process', function(itemAdd,itemRemove,itemRemove2)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.getInventoryItem(itemRemove).count >= Config.removeAmount and itemRemove2 == nil then
        xPlayer.addInventoryItem(itemAdd, Config.addAmount)
        xPlayer.removeInventoryItem(itemRemove, Config.removeAmount)
    elseif xPlayer.getInventoryItem(itemRemove).count >= Config.removeAmount and itemRemove2 ~= nil then
        xPlayer.addInventoryItem(itemAdd, Config.addAmount)
        xPlayer.removeInventoryItem(itemRemove, Config.removeAmount)
        xPlayer.removeInventoryItem(itemRemove2, Config.removeAmount)
    end
end)
