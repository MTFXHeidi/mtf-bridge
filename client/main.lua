Core = nil
Target = nil

if Config.Framework == "qb" then
    Core = exports['qb-core']:GetCoreObject()
elseif Config.Framework == "esx" then
    Core = exports['es_extended']:getSharedObject()
elseif Config.Framework == "nd" then
    Core = exports['nd-core']:getSharedObject()
elseif Config.Framework == "qbox" then
    Core = exports['qbox-core']:getCoreObject()
end

if Config.Target == 'ox' then
    Target = 'ox_target'
elseif Config.Target == 'qb' then
    Target = 'qb-target'
end

exports("GetPlayerJob", function()
    if Config.Framework == "qb" then
        return Core.Functions.GetPlayerData().job.name
    elseif Config.Framework == "esx" then
        return Core.GetPlayerData().job.name
    end
    return nil
end)

exports("GetPlayerCitizenID", function(text, duration)
    if Config.Framework == "qb" then
        return Core.Functions.GetPlayerData().citizenid
    elseif Config.Framework == "esx" then
        return Core.GetPlayerData().license
    end
    return nil
end)

exports("AddSphereZone", function(options)
    local zoneid = nil
    if Target == 'ox_target' then
        zoneid = exports.ox_target:addSphereZone({
            name = options.name,
            coords = options.coords,
            radius = options.radius,
            options = options.options,
            debug = options.debug 
        })
    elseif Target == 'qb-target' then
        zoneid = exports['qb-target']:AddCircleZone(options.name, options.coords, options.radius, {
          name = options.name, 
          debugPoly = true, 
        }, {
          options = { 
                options = options.options,
                distance = options.radius
          },
          distance = 5.0,
        })
    end

    return zoneid
end)


exports("AddTargetEntity", function(entity, options)
    if Target == 'ox_target' then
        exports.ox_target:addLocalEntity(entity, options)
    elseif Target == 'qb-target' then
        exports['qb-target']:AddTargetEntity(entity, {
            {
                label = options.label,
                icon = options.icon,
                action = options.onSelect,
            }
        }, options.distance or 3)
    end
end)
exports("RemoveTargetEntity", function(entity, options)
    if Target == 'ox_target' then
        exports.ox_target:removeEntity(entity, options)
    elseif Target == 'qb-target' then
        exports['qb-target']:RemoveTargetEntity(entity)
    end
end)

exports("RemoveZone", function(zone)
    if Target == 'ox_target' then
        exports.ox_target:removeZone(zone)
    elseif Target == 'qb-target' then
        exports['qb-target']:RemoveZone(zone)
    end
end)




