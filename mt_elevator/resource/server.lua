---oirgineel

-- lib.versionCheck('MT-Scripts/mt_elevator')


------------
local QBCore, ESX = nil, nil

-- Core init
if Config.Core == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
elseif Config.Core == 'esx' then
    ESX = exports['es_extended']:getSharedObject()
end

RegisterServerEvent('mt_elevator:requestJob')
AddEventHandler('mt_elevator:requestJob', function()
    local src = source
    local job, grade

    if Config.Core == 'qb' then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            job = Player.PlayerData.job.name
            grade = Player.PlayerData.job.grade.level
        end

    elseif Config.Core == 'qbx' then
        local Player = exports.qbx_core:GetPlayer(src)
        if Player then
            job = Player.PlayerData.job.name
            grade = Player.PlayerData.job.grade.level
        end

    elseif Config.Core == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            job = xPlayer.job.name
            grade = xPlayer.job.grade
        end
    end

    if job and grade then
        TriggerClientEvent('mt_elevator:setJob', src, job, grade)
    end
end)

