if not lib.checkDependency('qbx_core', '1.15.0') then lib.print.error('qbx_core v1.15.0 is required for dark-lifts') return end

local function isDisabled(name, level) --function to check if a floor/elevator is job locked in config.lua
    if name.JobLocked then --checks if elevator is job locked
        return not exports.qbx_core:HasGroup(name.JobAccess)
    end
    if level.Floorlock then --checks if floor is job locked
        return not exports.qbx_core:HasGroup(level.JobFAccess)
    end
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
    for i = 1, #Config.Elevators[name].Floors do
        local floorConfig = Config.Elevators[name].Floors[i]
        local floorUnlocked = name.JobLocked and exports.qbx_core:HasGroup(name.JobAccess) or floorConfig.Floorlock and exports.qbx_core:HasGroup(floorConfig.JobFAccess) or true
        if floorUnlocked then
            options[#options+1] = {
                title = floorConfig.Label,
                description = floorConfig.Desc,
                onSelect = function ()
                    liftMove(floorConfig)
                end
            }
        end
    end

    lib.registerContext({
        id = 'dark-lifts_oxlib',
        options = options,
        title = Config.Elevators[name].Name,
        position = 'top-right',
    })

    lib.showContext('dark-lifts_oxlib') --displays the menu after clicking the target option
end


CreateThread(function() --creates target zones by using data from config.lua
    for name, elevatordata in Config.Elevators do
        for i = 1, #elevatordata.Floors do
            local floordata = elevatordata.Floors[i]
            exports.ox_target:addSphereZone({
                coords = floordata.Coords,
                radius = 1.5,
                debug = Config.PolyDebug,
                options = {
                    {
                        name = ("%s%s"):format(name, i),
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
