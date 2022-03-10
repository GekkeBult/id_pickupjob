ESX = nil 
local pickedup = false
local started = false
local sleep = true

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) 
      ESX = obj 
    end)
		Citizen.Wait(0)
	end

	PlayerData = ESX.GetPlayerData()
	done = true
end)

Citizen.CreateThread(function ()
    while true do
    Citizen.Wait(0)
    local distance = #(GetEntityCoords(PlayerPedId()) - Config.JobStart)
      
    if distance < 8 and started == false and pickedup == false then
      sleep = false
      DrawMarker(25, Config.JobStart, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0,0,120, 100, false, true,2,true,false,false,false)
        if distance < 3 then
          ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to start a pickup job")
        end
        if IsControlPressed(0, 38) then
          TriggerEvent("chatMessage", Config.ServerName .. " ^7» ", {0, 128, 255}, "Jimmy gave you a pickup job, pick up the car and bring it to him.")
          started = true
          TriggerEvent("esx:spawnVehicle", Config.TransferVehicle)
          SetNewWaypoint(Config.RandomLocations[math.random(#Config.RandomLocations)])
        end
      else
      end
    end
    if sleep == true then
      Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function ()
    while true do
    Citizen.Wait(0)
    local distance = #(GetEntityCoords(PlayerPedId()) - Config.RandomLocations[math.random(#Config.RandomLocations)])
    if distance < 30 and started == true and pickedup == false then
      sleep = false
        DrawMarker(2, Config.RandomLocations[math.random(#Config.RandomLocations)], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.0, 2.0, 2.0, 0,0,120, 100, false, true,2,true,false,false,false)
        if distance < 3 then
          ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to take the vehicle")
        end
        if IsControlPressed(0, 38) then
          if distance < 5 and started == true and pickedup == false then
            pickedup = true
            SetNewWaypoint(Config.JobEnd)
            SpawnVehicle()
            Citizen.Wait(500)
            started = false
            Citizen.Wait(10000)
            started = true
          end
        end
        else
      end
    end
    if sleep == true then
      Citizen.Wait(1000)
    end
end)

Citizen.CreateThread(function ()
    while true do
    Citizen.Wait(0)
    local distance = #(GetEntityCoords(PlayerPedId()) - Config.JobEnd)
    if distance < 30 and pickedup == true then
      sleep = false
        DrawMarker(2, Config.JobEnd, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 5.0, 5.0, 5.0, 120,0,0, 200, true, false,2,false,false,false,false)
          if distance < 8 and pickedup == true then
            ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to hand over the vehicle")
          end
        if IsControlPressed(0, 38) and pickedup == true and distance < 15 then
          pickedup = true
          EndJobb()
          Citizen.Wait(1000)
          pickedup = false
          started = false
          Citizen.Wait(1000)
          pickedup = false
          started = false
        end
      else
    end
  end
  if sleep == true then
    Citizen.Wait(1000)
  end
end)

function EndJobb()
    TriggerEvent("esx:deleteVehicle")
    TriggerEvent("chatMessage", Config.ServerName .. " ^7» ", {0, 128, 255}, "You have completed the job successfully.")
    TriggerServerEvent("infinity_pickupjob:done")
end

function SpawnVehicle()
    TriggerEvent("esx:deleteVehicle")
    Citizen.Wait(1000)
    TriggerEvent("esx:spawnVehicle", Config.Vehicles[math.random(#Config.Vehicles)])
    TriggerEvent("chatMessage", Config.ServerName .. " ^7» ", {0, 128, 255}, "You picked up the vehicle, now go back and hand it over to Jimmy.")
end

Citizen.CreateThread(function()
  if Config.EnableNPC == true then
    modelHash = GetHashKey("a_m_y_soucent_02")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
         Wait(1)
    end

    createNPC()
  end
end)

function createNPC()
	created_ped = CreatePed(0, modelHash , Config.NPCcoords, Config.NPCheading)
	FreezeEntityPosition(created_ped, true)
	SetEntityInvincible(created_ped, true)
	SetBlockingOfNonTemporaryEvents(created_ped, true)
	TaskStartScenarioInPlace(created_ped, "WORLD_HUMAN_COP_IDLES", 0, true)
end

local blip 

Citizen.CreateThread(function()
  if Config.EnableBlip == true then
      blip = AddBlipForCoord(Config.JobStart)

      SetBlipSprite (blip, 147)
      SetBlipDisplay(blip, 4)
      SetBlipScale  (blip, 0.7)
      SetBlipAsShortRange(blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(Config.BlipName)
      EndTextCommandSetBlipName(blip)
  end
end)

function StopJob()
  if started == true or pickedup == true then
    started = false
    pickedup = false
    TriggerEvent("esx:deleteVehicle")
    TriggerEvent("chatMessage", Config.ServerName .. " ^7» ", {0, 128, 255}, "You have successfully canceled pickup job.")
    DeleteWaypoint()
  end
end

RegisterCommand('canceljob', function(source, args, rawCommand)
  if started == true or pickedup == true then
    StopJob()
  else
    TriggerEvent("chatMessage", Config.ServerName .. " ^7» ", {0, 128, 255}, "You didn\'t start a pickup job.") 
  end
end)