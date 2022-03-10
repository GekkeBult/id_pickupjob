ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 

RegisterNetEvent("infinity_pickupjob:done")
AddEventHandler("infinity_pickupjob:done", function()
    local igrac = ESX.GetPlayerFromId(source)
    local distance = #(GetEntityCoords(GetPlayerPed(source)) - Config.JobEnd)
    if distance < 5.0 then
      igrac.addMoney(math.random(Config.MinAmount, Config.MaxAmount))
    end
end)