-----------------  origineel

-- return {
--     {  
--         {
--             level = 1,
--             ped = vec4(-674.3380, 323.7354, 139.1227, 181.7134),
--             target = {
--                 coords = vec3(-675.1, 324.1, 140.35),
--                 radius = 0.2,
--             }
--         },
--         {
--             level = 0,
--             ped = vec4(-685.9841, 327.0063, 82.0840, 261.3424),
--             target = {
--                 coords = vec3(-684.2, 327.8, 83.55),
--                 radius = 0.2,
--             }
--         },
--         {
--             level = -1,
--             ped = vec4(-674.6760, 362.7444, 76.7749, 180.8797),
--             target = {
--                 coords = vec3(-673.75, 360.9, 78.25),
--                 radius = 0.2,
--             }
--         }
--     }
-- }

---------------------------------------------------------------------
Config = {}

-- Core kiezen: 'qbx', 'qb', 'esx'
Config.Core = 'qbx'

-- Notify types
Config.Notifications = {
    qbx = { info = "inform", error = "error", success = "success" },
    qb  = { info = "primary", error = "error", success = "success" },
    esx = { info = nil, error = nil, success = nil }
}

 
Config.Sound = {
    type = "default", -- opties: "default" of "custom"

    -- Standaard GTA geluid
    default = { 
        name = "ATM_WINDOW",                -- Kies uit de lijst hieronder
        set = "HUD_FRONTEND_DEFAULT_SOUNDSET" 
    },

    -- Custom geluid (werkt alleen als je .awc hebt toegevoegd in audiodirectory/)
    custom = { 
        name = "elevator", 
        set = "elevator_soundset" 
    }
}



-- Voorbeeld jobs en elevators
Config.Jobs = {
    ["police"] = {
        {
            level = -1,
            grade = {0,1,2,3,4,5,6,7,8,9},
            ped = vec4(466.32, -975.86, 25.47, 134.26),
            target = {
                coords = vec3(465.25, -977.26, 25.47),
                radius = 0.5,
            }
        },
        {
            level = 0,
            grade = {0,1,2,3,4,5,6,7,8,9},
            ped = vec4(464.84, -976.64, 30.72, 136.52),
            target = {
                coords = vec3(463.68, -977.77, 30.72),
                radius = 0.5,
            }
        },
        {
            level = 1,
            grade = {0,1,2,3,4,5,6,7,8,9},
            ped = vec4(464.93, -976.64, 35.06, 137.14),
            target = {
                coords = vec3(463.68, -977.9, 35.06),
                 radius = 0.5,
            }
        },
                {
            level = 2,
            grade = {0,1,2,3,4,5,6,7,8,9},
            ped = vec4(464.8, -976.71, 39.42, 131.09),
            target = {
                coords = vec3(463.68, -977.9, 39.42),
                 radius = 0.5,
            }
        },
        {
            level = 3,
            grade = {0,1,2,3,4,5,6,7,8,9},
            ped = vec4(466.35, -977.02, 43.7, 140.03),
            target = {
                coords = vec3(465.33, -978.15, 43.7),
                 radius = 0.5,
            }
        }
    },
    ["ambulance"] = {
        {
            level = 1,
            grade = {0,1,2,3,4},
            ped = vec4(300.12, -599.5, 43.28, 90.0),
            target = {
                coords = vec3(301.5, -598.8, 43.28),
                 radius = 0.5,
            }
        }
    }
}
