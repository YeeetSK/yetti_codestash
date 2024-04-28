for k, v in ipairs(Config.StashLocs) do

    exports.ox_inventory:RegisterStash(v.id, v.label, v.slots, v.weight * 1000, nil, nil, vector3(v.coords.x, v.coords.y, v.coords.z + 1))

end