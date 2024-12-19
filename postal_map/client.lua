function UpdateMinimapLocation()
    Citizen.CreateThread(function()
        -- Get screen aspect ratio
        local ratio = GetScreenAspectRatio()
    
        -- Default values for 16:9 monitors
        local posX = -0.0045
        local posY = 0.002
    
        if tonumber(string.format("%.2f", ratio)) >= 2.3 then
            -- Ultra wide 3440 x 1440 (2.39)
            -- Ultra wide 5120 x 2160 (2.37)
            posX = -0.170
            posY = 0.002
            print('Detected ultra-wide monitor, adjusted minimap')
        else 
            posX = -0.0045
            posY = 0.002
        end
    
        SetMinimapComponentPosition('minimap', 'L', 'B', posX, posY, 0.150, 0.188888)
        SetMinimapComponentPosition('minimap_mask', 'L', 'B', posX + 0.0155, posY + 0.03, 0.111, 0.159)
        SetMinimapComponentPosition('minimap_blur', 'L', 'B', posX - 0.0255, posY + 0.02, 0.266, 0.237)
    
        DisplayRadar(false)
        SetRadarBigmapEnabled(true, false)
        Citizen.Wait(0)
        SetRadarBigmapEnabled(false, false)
        DisplayRadar(true)
    end)
end
  
RegisterCommand('reload-map', function(src, args)
    UpdateMinimapLocation()
end, false)
  
  
Citizen.CreateThread(function()
    UpdateMinimapLocation()

    SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
    SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
    SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
    SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
    SetMapZoomDataLevel(4, 22.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsPedOnFoot(GetPlayerPed(-1)) then 
            SetRadarZoom(1100)
        elseif IsPedInAnyVehicle(GetPlayerPed(-1), true) then
            SetRadarZoom(1100)
        end
    end
end)

function hideminimap()
    DisplayRadar(false);
end

function showminimap()
    DisplayRadar(true);
end

