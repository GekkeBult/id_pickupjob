Config = {}

Config.Vehicles = { -- Vehicles for pickup (you can add as much as you want)
  "infernus",
  "sultan", 
  "blista",
  "t20",
  "burrito",
  "zentorno",
  "patriot",
  "mesa"
}

Config.TransferVehicle = "bati" -- Vehicle obtained for transport to pick-up vehicles

Config.RandomLocations = { -- Random locations where the random vehicles will spawn (you can add as much as you want)
  vector3(-98.3785, 6342.671, 31.490),
  vector3(500.0166, -2981.13, 5.3931)
}

Config.ServerName = "Server Name" -- Your servers name

Config.JobEnd = vector3(880.4930, -3100.54, 5.9007) -- Where the job ends
Config.JobStart = vector3(876.2905, -3105.64, 4.9008) -- Where the job starts

Config.MinAmount = 500 -- The minimum amount of money that a player will receive after the job is completed
Config.MaxAmount = 1000 -- The maximum amount of money that a player will receive after the job is completed

Config.EnableNPC = false
Config.NPCcoords = vector3(876.3229, -3106.54, 5.9008 - 1) -- Location (coords and heading) where the NPC will spawn
Config.NPCheading = 500

Config.EnableBlip = true
Config.BlipName = "Pickup Job"