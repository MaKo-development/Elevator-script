----------------origineel

-- local config = require "config"

-- local function loadAudioFile()
--     if not RequestScriptAudioBank('audiodirectory/custom_sounds', false) then
--         while not RequestScriptAudioBank('audiodirectory/custom_sounds', false) do
--             Wait(0)
--         end
--     end
--     return true
-- end

-- RegisterNUICallback('hideFrame', function(data, cb)
--     SendNUIMessage({ action = 'setVisible', data = false })
--     SetNuiFocus(false, false)
--     cb(true)
-- end)

-- RegisterNUICallback('goToLevel', function(data, cb)
--     local levelData
--     for _, level in pairs(config[data.currentElevator]) do
--         if level.level == data.level then
--             levelData = level
--             break
--         end
--     end
--     if not levelData then
--         cb(false)
--         return
--     end
--     local coords = levelData.ped
--     DoScreenFadeOut(500)
--     Wait(1000)
--     SetEntityCoords(cache.ped, coords.x, coords.y, coords.z, true, false, false, false)
--     SetEntityHeading(cache.ped, coords.w)
--     Wait(1000)
--     DoScreenFadeIn(500)
--     if loadAudioFile() then
--         local soundId = GetSoundId()
--         PlaySoundFromEntity(soundId, 'elevator', PlayerPedId(), 'elevator_soundset', false, 0)
--         while not HasSoundFinished(soundId) do
--             Wait(0)
--         end
--         ReleaseSoundId(soundId)
--     end
--     cb(true)
-- end)

-- for k, v in pairs(config) do
--     for _, elevator in pairs(v) do
--         exports.ox_target:addSphereZone({
--             coords = elevator.target.coords,
--             radius = elevator.target.radius,
--             options = {
--                 {
--                     distance = 2.0,
--                     name = "elevator_menu",
--                     icon = "fa-solid fa-elevator",
--                     label = "Gebruik lift",
--                     onSelect = function()
--                         SetNuiFocus(true, true)
--                         SendNUIMessage({
--                             action = "updateElevator",
--                             data = {
--                                 currentElevator = k,
--                                 elevatorLevels = (function()
--                                     local levels = {}
--                                     for _, level in pairs(v) do
--                                         table.insert(levels, level.level)
--                                     end
--                                     table.sort(levels, function(a, b) return a > b end)
--                                     return levels
--                                 end)(),
--                                 currentLevel = elevator.level
--                             }
--                         })
--                         SendNUIMessage({
--                             action = "setVisible",
--                             data = true
--                         })
--                     end
--                 }
--             }
--         })
--     end
-- end
 ----------------------------------------------------------------------------------------
local PlayerJob = nil
local cache = { ped = PlayerPedId() }

-- ======================
-- Notify functie
-- ======================
local function Notify(msg, type)
    if Config.Core == 'qbx' then
        lib.notify({
            title = 'Elevator',
            description = msg,
            type = type or Config.Notifications.qbx.info
        })
    elseif Config.Core == 'qb' then
        local QBCore = exports['qb-core']:GetCoreObject()
        QBCore.Functions.Notify(msg, type or Config.Notifications.qb.info)
    elseif Config.Core == 'esx' then
        ESX.ShowNotification(msg)
    else
        print('[Elevator] ' .. msg)
    end
end

-- ======================
-- Job sync
-- ======================
TriggerServerEvent('mt_elevator:requestJob')

RegisterNetEvent('mt_elevator:setJob', function(job, grade)
    PlayerJob = { name = job, grade = grade }
end)

-- Bij resource restart
AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        TriggerServerEvent('mt_elevator:requestJob')
    end
end)

-- Bij job update (QBCore/QBX/ESX)
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    PlayerJob = { name = job.name, grade = job.grade.level }
end)

RegisterNetEvent('QBX:Client:OnJobUpdate', function(job)
    PlayerJob = { name = job.name, grade = job.grade.level }
end)

RegisterNetEvent('esx:setJob', function(job)
    PlayerJob = { name = job.name, grade = job.grade }
end)

-- ======================
-- Check toegang
-- ======================
local function CanUseElevator(elevatorJob, elevatorGrade)
    if not PlayerJob then return false end
    if PlayerJob.name ~= elevatorJob then return false end
    for _, g in ipairs(elevatorGrade) do
        if g == PlayerJob.grade then
            return true
        end
    end
    return false
end

-- ======================
-- Audio loader (voor custom geluid)
-- ======================
local function loadAudioFile()
    if not RequestScriptAudioBank('audiodirectory/custom_sounds', false) then
        while not RequestScriptAudioBank('audiodirectory/custom_sounds', false) do
            Wait(0)
        end
    end
    return true
end

-- ======================
-- Speel elevator geluid (config afhankelijk)
-- ======================
local function PlayElevatorSound()
    if Config.Sound.type == "custom" then
        if loadAudioFile() then
            local soundId = GetSoundId()
            PlaySoundFromEntity(soundId, Config.Sound.custom.name, cache.ped, Config.Sound.custom.set, false, 0)
            while not HasSoundFinished(soundId) do
                Wait(0)
            end
            ReleaseSoundId(soundId)
        end
    else
        -- Standaard GTA geluid
        PlaySoundFrontend(-1, Config.Sound.default.name, Config.Sound.default.set, true)
    end
end

-- ======================
-- NUI callbacks
-- ======================
RegisterNUICallback('hideFrame', function(data, cb)
    SendNUIMessage({ action = 'setVisible', data = false })
    SetNuiFocus(false, false)
    cb(true)
end)

RegisterNUICallback('goToLevel', function(data, cb)
    local levelData
    for _, level in pairs(Config.Jobs[data.currentElevator]) do
        if level.level == data.level then
            levelData = level
            break
        end
    end

    if not levelData or not CanUseElevator(data.currentElevator, levelData.grade) then
        Notify("Je hebt hier geen toegang toe!", "error")
        cb(false)
        return
    end

    local coords = levelData.ped
    DoScreenFadeOut(500)
    Wait(1000)
    SetEntityCoords(cache.ped, coords.x, coords.y, coords.z, true, false, false, false)
    SetEntityHeading(cache.ped, coords.w)
    Wait(1000)
    DoScreenFadeIn(500)

    -- Speel geluid
    PlayElevatorSound()

    cb(true)
end)

-- ======================
-- ox_target zones
-- ======================
for jobName, elevators in pairs(Config.Jobs) do
    for _, elevator in pairs(elevators) do
        exports.ox_target:addSphereZone({
            coords = elevator.target.coords,
            radius = elevator.target.radius,
            options = {
                {
                    distance = 2.0,
                    name = "elevator_menu",
                    icon = "fa-solid fa-elevator",
                    label = "Gebruik lift",
                    onSelect = function()
                        if not CanUseElevator(jobName, elevator.grade) then
                            Notify("Je hebt hier geen toegang toe!", "error")
                            return
                        end
                        SetNuiFocus(true, true)
                        SendNUIMessage({
                            action = "updateElevator",
                            data = {
                                currentElevator = jobName,
                                elevatorLevels = (function()
                                    local levels = {}
                                    for _, level in pairs(elevators) do
                                        table.insert(levels, level.level)
                                    end
                                    table.sort(levels, function(a, b) return a > b end)
                                    return levels
                                end)(),
                                currentLevel = elevator.level
                            }
                        })
                        SendNUIMessage({ action = "setVisible", data = true })
                    end
                }
            }
        })
    end
end
