if not lib.checkDependency('qbx_core', '1.15.0') then lib.print.error('qbx_core v1.15.0 is required for dark-lifts') return end

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
    local elevatorConfig = Config.Elevators[name]
    local options = {}
    for i = 1, #elevatorConfig.Floors do
        local floorConfig = elevatorConfig.Floors[i]
        local floorUnlocked = true
        if floorConfig.Floorlock then
          floorUnlocked = exports.qbx_core:HasGroup(floorConfig.JobFAccess)
        end
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
    for name, elevatordata in pairs(Config.Elevators) do
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
                        groups = elevatordata.JobLocked and elevatordata.JobAccess or nil,
                        onSelect = function()
                            floorMenu(name)
                        end
                    }
                }
            })
        end
    end
end)
