ESX = exports["es_extended"]:getSharedObject()


Citizen.CreateThread(function()

    while ESX.GetPlayerData() == nil do
        Citizen.Wait(0)
    end

    PlayerData = ESX.GetPlayerData()

end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

-- Pre Inizio

Citizen.CreateThread(function()
    Marker_Blip()
end)


-- Inzio

local VenditaNpc = nil

RegisterNetEvent('kng:humane')
AddEventHandler('kng:humane', function(value)
    VenditaNpc = value
end)

RegisterNetEvent('kng:ricompensahumane')
AddEventHandler('kng:ricompensahumane', function(value)
    VenditaNpc = value

    local Valigetta = CreateObject(GetHashKey("prop_med_bag_01b"), 0, 0, 0, true, true, true)
    AttachEntityToEntity(Valigetta, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)        

    Citizen.Wait(1000*2)
    DeleteEntity(Valigetta) 
    ClearPedTasks(GetPlayerPed(-1))

    TriggerServerEvent('kng:ricompensahumane')
end)

RegisterNetEvent('kng:humane') 
AddEventHandler('kng:humane', function()
    local input = lib.inputDialog('💀', {
        {type = 'select', label = 'Seleziona', options = {
            {label = "💊 - Humane", value = "humane"},
            {label = "💀 - Morte", value = "morte"},
        }},
    })
    
    if input[1] == 'humane' then

        ESX.ShowNotification('Hai Scelto Il Lavoro! ' ..input[1])
        OpenMenu()
        Citizen.Wait(1000*2)
        ESX.ShowNotification('Tuffati Alla Ricera Di Una Valigetta')
        Citizen.Wait(1000*5)
        Valigetta()

    elseif input[1] == 'morte' then
        ESX.ShowNotification('Hai Scelto Il Lavoro! ' ..input[1])
        OpenMenu()
        Citizen.Wait(1000*5)
        ESX.ShowNotification('Tuffati Alla Ricera Di Una Valigetta')
        Citizen.Wait(1000*5)
        Valigetta()
    end
end)

RegisterNetEvent('takeOutfit')
AddEventHandler('takeOutfit',function(data)
    exports['fivem-appearance']:setPedComponents(cache.ped, {data.torso,data.undershirt,data.pants,data.shoes,data.bag,data.accesories,data.kevlar,data.badge,data.arms})  
    exports['fivem-appearance']:setPedProps(cache.ped, {data.hat})     
end)