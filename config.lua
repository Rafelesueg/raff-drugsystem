Config = {}

Config.Location = {
    -- COORDS = VEC3, TEXT = NAME OF MARKER, ADD = ITEM TO ADD, REMOVE = ITEM TO REMOVE
    -- REMOVE2 = IN CASE YOU WANT TO REMOVE 2 ITEMS, LEAVE NIL IN CASE YOU DONT NEED IT 

    {   Coords = vector3(2228.426,5576,54), text = "Press [E] collect", Add = "cannabis", Remove = nil ,Remove2 = nil , type = "collect"},
    {   Coords = vector3(2236, 5576, 54), text = "Press [E] to process", Add = "marijuana", Remove = "cannabis",Remove2 = nil ,type = "process"},
}

Config.checkWeapon = true           --SET FALSE, IF YOU DON'T MIND REMOVE WEAPON DURING PROGRESSBAR

Config.progressDuration = 5000      --SET PROGRESSBAR DURATION

Config.removeAmount = 5             --SET HOW MANY ITEM TO REMOVE DURING PROCESS
Config.addAmount = 3                --SET HOW MANY ITEM TO ADD DURING PROCESS

Config.randomMin = 1                --SET MIN VALUE OF RANDOM ADD ITEM
Config.randomMax = 10               --SET MAX VALUE OF RANDOM ADD ITEM