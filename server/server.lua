ESX             = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('devrp-grandmas:payBill')
AddEventHandler('devrp-grandmas:payBill', function()
    local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	--change price here for revive
	xPlayer.removeAccountMoney('bank', 1000)
  --  TriggerClientEvent('esx:showNotification', src, '~w~You Were Billed For ~r~$1,000~w~.')
  TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You paid $1000 in medical supplies', length = 2500 })
end)


ESX.RegisterServerCallback('devrp-grandmas:checkBalance', function(source, cb)
local xPlayer = ESX.GetPlayerFromId(source)
local bankBalance = xPlayer.getAccount('bank').money

cb(bankBalance >= Config.FineAmount)
end)