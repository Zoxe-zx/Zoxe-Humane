ESX = exports["es_extended"]:getSharedObject()

function Marker_Blip()
    for k,v in pairs(Config.Start) do 

        local Blip = AddBlipForCoord(v.Blip.x,v.Blip.y,v.Blip.z)

        SetBlipSprite(Blip, 51) --351 -- Scegli Il Tuo Blip: https://docs.fivem.net/docs/game-references/blips/
        SetBlipScale(Blip, 0.5)
        SetBlipColour(Blip, 50)
        SetBlipDisplay(Blip, 2)
        SetBlipAsShortRange(Blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Humane")
        EndTextCommandSetBlipName(Blip)

        if not HasModelLoaded('a_m_m_ktown_01') then
            RequestModel('a_m_m_ktown_01')
            while not HasModelLoaded('a_m_m_ktown_01') do
                Citizen.Wait(5)
            end
        end

        Npc = CreatePed(4, 'a_m_m_ktown_01', v.Npc.x, v.Npc.y, v.Npc.z, false, true)

        FreezeEntityPosition(Npc, true)
        SetEntityInvincible(Npc, true)
        SetBlockingOfNonTemporaryEvents(Npc, true)

        local VenditaNpc = false
        local Options = {
            
            {
                event = 'kng:humane',
                icon = 'fa-solid fa-briefcase',
                label = 'Lavora',
                canInteract = function(entity)
                    return not IsEntityDead(entity)
                end
            }
        }

        exports.ox_target:addLocalEntity(Npc, Options)     

    end
end


function Valigetta()
    for k, v in pairs(Config.Start) do 
        exports.ox_target:addBoxZone({
            coords =  v.Marker, --vector3(3670.16, 3727.48, 31.44),
            size = vec3(2, 2, 2),
            rotation = 45,
            debug = drawZones,
            options = {
                {
                    name = 'Valigetta',
                    icon = 'fa-solid fa-suitcase',
                    label = 'Valigetta',
                    onSelect = function(data)
                        print('Valigetta')

                        local Valigetta = CreateObject(GetHashKey("prop_med_bag_01b"), 0, 0, 0, true, true, true)
                        AttachEntityToEntity(Valigetta, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true)        

                        Citizen.Wait(1000*2)

                        ESX.ShowNotification('Hai Preso La Valigetta, Ma Putroppo Il Contenuto Si E\' Bagnato')

                        Citizen.Wait(1000*4)
                        DeleteEntity(Valigetta) 
                        ClearPedTasks(GetPlayerPed(-1))

                        ESX.ShowNotification('Valigetta Salvata, Nel Frattempo Continua Il Percorso')

                        Step()
                    end,
                }
            }
        })
    end
end

function Step()
    for k, v in pairs(Config.Start) do 
        Npc = CreatePed(4, 'a_m_m_ktown_01', v.Marker2.x, v.Marker2.y, v.Marker2.z, false, true)

        FreezeEntityPosition(Npc, true)
        SetEntityInvincible(Npc, true)
        SetBlockingOfNonTemporaryEvents(Npc, true)

        local VenditaNpc = false
        local Options = {
            
            {
                event = 'kng:ricompensahumane',
                icon = 'fa-solid fa-capsules',
                label = 'Humane',
                canInteract = function(entity)
                    return not IsEntityDead(entity)
                end
            }
        }

        exports.ox_target:addLocalEntity(Npc, Options)
    end
end


RegisterCommand('humane', function()
    --TriggerEvent('kng:humane')
    Valigetta()
    Step()
end)





















--Clothes

function OpenMenu()
    lib.registerContext({
        id = 'openMenu',
        title = "Job Outfits",
        options = {
            {
                title = "Job Oufits",
                onSelect = function()
                    OpenJobOutfit()
                end,
            },
            {
                title = "Civil Clothes",
                onSelect = function()
                    NormalClothes()
                end,
            },
        }
    })
    lib.showContext('openMenu')

end

function NormalClothes()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)


        if lib.progressBar({
            duration = 2000,
            label = 'Changing Clothes',
            useWhileDead = false,
            allowCuffed = false,
            canCancel = false,
            disable = {
                car = true,
            },
            anim = {
                dict = 'clothingshirt',
                clip = 'try_shirt_positive_d'
            },
        }) then
            local model = nil

            if skin.sex == 0  then
                model = GetHashKey("mp_m_freemode_01")
            else
                model = GetHashKey("mp_f_freemode_01")
            end
    
            lib.requestModel(model, 100)
    
            SetPlayerModel(PlayerId(), model)
            SetModelAsNoLongerNeeded(model)
            TriggerEvent('skinchanger:loadSkin', skin)
            TriggerEvent('esx:restoreLoadout')
            lib.showContext('openMenu')
        end
    end)
end

function OpenJobOutfit()
    local opz = {}
    for k,v in pairs(Config.Start) do
        --for k,v in pairs(Config.Lavoro[k]) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == v.job then --and ESX.PlayerData.job.grade >= v.grade then
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                    if skin.model == v.model then
                        args = {
                            torso = v.torso,
                            undershirt = v.undershirt,
                            arms = v.arms,
                            pants = v.pants,
                            shoes = v.shoes,
                            bag = v.bag,
                            accesories = v.accesories,
                            kevlar = v.kevlar,
                            badge = v.badge,
                            hat = v.hat
                        }
                        table.insert(opz, {
                            title = v.outfitName,
                            event = 'takeOutfit',
                            args = args,
                            onSelect = function()
                                if lib.progressBar({
                                    duration = 2000,
                                    label = 'Changing Clothes',
                                    useWhileDead = false,
                                    allowCuffed = false,
                                    canCancel = false,
                                    disable = {
                                        car = true,
                                    },
                                    anim = {
                                        dict = 'clothingshirt',
                                        clip = 'try_shirt_positive_d'
                                    },
                                }) then
                                    --lib.showContext('outfits')
                                end
                            end,
                        })
                        lib.registerContext({
                            id = 'outfits',
                            title = 'Job Outfits',
                            menu = 'openMenu',
                            options = opz
                        })
                        lib.showContext('outfits')
                    end
                end)
            end
        --end
    end
end