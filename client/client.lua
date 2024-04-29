lib.locale()

for k, v in ipairs(Config.StashLocs) do

    RegisterNetEvent('yetticodeStash:openStash' .. v.id, function()
        local input = lib.inputDialog(locale("dialog_title"), {
            {type = 'input', label = locale("dialog_description"), required = true, password = true, icon = 'fa-solid fa-lock'},
          })

        if input then
            local code = input[1]
            if code == v.code then
                exports.ox_inventory:openInventory('stash', v.id)
            else
                lib.notify({
                    title = locale("notify_title"),
                    description = locale("notify_description"),
                    type = 'error',
                    duration = 5000, 
                })
            end
        end
    end)

    if Config.OpenType == 'target' then
        if Config.Target == 'ox' then
            exports.ox_target:addBoxZone({
                coords = vector3(v.coords.x, v.coords.y, v.coords.z + 0.25),
                size = vector3(3.0, 3.0, 3.0),
                rotation = 0.0,
                debug = false,
                options = {
                    {
                        type = "client",
                        event = 'yetticodeStash:openStash'.. v.id,
                        icon = Config.TargetIcon,
                        label = Config.TargetLabel,
                        distance = Config.Distance,
                    }
                }
            })
        elseif Config.Target == 'qb' then
            exports['qb-target']:AddBoxZone(v.id, vector3(v.coords.x, v.coords.y, v.coords.z + 0.25), 1.5, 1.6, {
                name = v.id,
                heading = 0,
                debugPoly = Config.Debug,
                minZ = v.coords.z - 1.5,
                maxZ = v.coords.z + 1.5,
            }, {
                options = {
                {
                    icon = Config.TargetIcon,
                    label = Config.TargetLabel,
                    action = function ()
                        TriggerEvent('yetticodeStash:openStash' .. v.id)
                    end
                }
                },
                distance = Config.Distance,
            })
        end

    elseif Config.OpenType == 'textui' then
        local point = lib.points.new({
            coords = vector3(v.coords.x, v.coords.y, v.coords.z + 0.25),
            distance = Config.Distance,
            onExit = function()
                if lib.isTextUIOpen() then
                    lib.hideTextUI()
                end
            end
        })


        function point:nearby()
            if not lib.isTextUIOpen() then
                lib.showTextUI(locale("open_stash_textui"))
            end

            if IsControlJustPressed(0, 51) then
                TriggerEvent('yetticodeStash:openStash' .. v.id)
            end
        end



    end

    


end
