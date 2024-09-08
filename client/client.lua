CreateThread(function()
    while true do
        PlayerData = exports.qbx_core:GetPlayerData()
        if PlayerData.citizenid ~= nil then
            break
        end
        Wait(100)
    end
end
)

local function isDisabled(name, level) --function to check if a floor/elevator is job locked in config.lua
    if name.JobLocked then --checks if elevator is job locked
        for _,jobname in pairs(name.JobAccess) do
            if PlayerData.job.name == jobname then
                return false
            end
        end
    end
    if level.Floorlock then --checks if floor is job locked
        for _,jobname in pairs(level.JobFAccess) do
                if QBX.PlayerData.job.name == jobname then
                    return false
                end
        end
    end
    return true
end

local function liftMove(level) --function to move the ped
    local ped = PlayerPedId()
    DoScreenFadeOut(1500)
    while not IsScreenFadedOut() do
        Wait(10)
    end
    RequestCollisionAtCoord(level.Coords.x, level.Coords.y, level.Coords.z)
    SetEntityCoords(ped, level.Coords.x, level.Coords.y, level.Coords.z, false, false, false, false)
    SetEntityHeading(ped, level.Heading)
    Wait(Config.PullUpTime)
    DoScreenFadeIn(1500)
end


local function floorMenu(name) --function to draw the context menu
    local options = {}

    for index,level in pairs(Config.Elevators[name].Floors) do
        options[#options+1] = {
            title = level.Label,
            description = level.Desc,
            disabled = isDisabled(name, level),
            onSelect = function ()
                liftMove(level)
            end
        }
    end

    lib.registerContext({
        id = 'dark-lifts_oxlib',
        options = options,
        title = Config.Elevators[name].Name,
        position = 'top-right',
    }, function(selected, scrollIndex, args)
    end
)

    lib.showContext('dark-lifts_oxlib') --displays the menu after clicking the target option
end


CreateThread(function() --creates target zones by using data from config.lua
    for name, elevatordata in pairs(Config.Elevators) do
        for index, floordata in pairs(elevatordata.Floors) do
            exports.ox_target:addSphereZone({
                coords = floordata.Coords,
                radius = 1.5,
                debug = Config.PolyDebug,
                options = {
                    {
                        name = ("%s%s"):format(name, index),
                        icon = "fas fa-hand-point-up",
                        label = 'Use Elevator',
                        onSelect = function()
                            floorMenu(name)
                        end
                    }
                }
            })
        end
    end
end)