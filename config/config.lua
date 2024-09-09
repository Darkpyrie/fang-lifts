
Config = {}
Config.PolyDebug = false
Config.PullUpTime = 3000 -- how long the screen will be black for 1000 = 1 second
Config.Elevators = {
    --[[ 
    ELEVATOR FORMAT
    ["name"] = { -- Make sure this has no spaces or anything, like policeDept, fibBuilding, etc etc
    Name = 'Mt. Zonah PD', -- This will be on the top of the context menu
    JobLocked = false,-- Set to false to disable restrictions. Locks entire elevator to defined jobs below
    JobAccess = {
        'police',
        'ambulance',
        },
    id = 'name', --mainly used for target zone IDs, just keep the same as your ["name"]
    Floors = {
        {
            Label = 'Floor -1',
            Desc = 'PD Garage & Cells',
            Coords = vec3(-593.08, -430.82, 31.17), --coordinate of target zone
            Heading = 270, --direction ped is facing on exit
            Floorlock = true, --locks this floor to defined jobs below (can delete the JobFAccess table if this is false)
            JobFAccess = {
                'police',
                'ambulance',
            },
        },
        {
            Label = 'Lobby',
            Desc = 'Reception and Outside Air',
            Coords = vec3(-590.17, -430.76, 35.18),
            Heading = 270,
            Floorlock = false, --locks this floor to defined jobs below
            JobFAccess = {
            },
        },
        {
            Label = 'Floor 1',
            Desc = 'Offices & Kitchen',
            Coords = vec3(-590.13, -430.83, 39.64),
            Heading = 270,
            Floorlock = false, --locks this floor to defined jobs below
            JobFAccess = {
            },
        },
        {
            Label = 'Floor 2',
            Desc = 'Forensics & Roof',
            Coords = vec3(-589.79, -431.03, 45.64),
            Heading = 270,
            Floorlock = true, --locks this floor to defined jobs below
            JobFAccess = {
                'police',
                'ambulance',
            },
        }
    },
    ]]

    ["zpdl"] = { -- Make sure this has no spaces or anything, like policeDept, fibBuilding, etc etc
    Name = 'Mt. Zonah PD', -- This will be on the top of the menu
    JobLocked = false,-- Set to false to disable restrictions. Locked entire elevator to defined jobs below
    JobAccess = {  -- Job lock for entire elevator. ignored if joblocked is false
        'police',
        'ambulance',
        },
    id = 'zpdl',
    Floors = {
        {
            Label = 'Floor -1',
            Desc = 'PD Garage & Cells',
            Coords = vec3(-593.08, -430.82, 31.17),
            Heading = 270,
            Floorlock = true, --locks this floor to defined jobs below
            JobFAccess = {
                'police',
                'ambulance',
            },
        },
        {
            Label = 'Lobby',
            Desc = 'Reception and Society... yuckie',
            Coords = vec3(-590.17, -430.76, 35.18),
            Heading = 270,
            Floorlock = false, --locks this floor to defined jobs below
            JobFAccess = {
            },
        },
        {
            Label = 'Floor 1',
            Desc = 'Offices & Kitchen',
            Coords = vec3(-590.13, -430.83, 39.64),
            Heading = 270,
            Floorlock = false, --locks this floor to defined jobs below
            JobFAccess = {
            },
        },
        {
            Label = 'Floor 2',
            Desc = 'Forensics & Roof',
            Coords = vec3(-589.79, -431.03, 45.64),
            Heading = 270,
            Floorlock = true, --locks this floor to defined jobs below
            JobFAccess = {
                'police',
                'ambulance',
            },
        }
    },
}
}