--============================= ID NA CABEÇA

 local showPlayerBlips = false
 local ignorePlayerNameDistance = false
 local disPlayerNames = 5
 local playerSource = 0
 local InAction = true
 local isDead = false

function DrawText3D(x,y,z, text)
   local onScreen,_x,_y=World3dToScreen2d(x,y,z)
   local px,py,pz=table.unpack(GetGameplayCamCoords())
   local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

   local scale = (1/dist)*2
   local fov = (1/GetGameplayCamFov())*100
   local scale = scale*fov
    
   if onScreen then
       SetTextScale(0.0*scale, 0.55*scale)
       SetTextFont(4)
       SetTextProportional(1)
       SetTextScale(0.0, 0.4)
       SetTextColour(255, 255, 255, 255)
       SetTextDropshadow(0, 0, 0, 0, 255)
       SetTextEdge(2, 0, 0, 0, 150)
       SetTextDropShadow()
       SetTextOutline()
       SetTextEntry("STRING")
       SetTextCentre(1)
       AddTextComponentString(text)
       DrawText(_x,_y)
   end
end

RegisterCommand("id",function(source, args)
	if InAction then
	InAction = false
	else
	InAction = true
	end
end, false) 

Citizen.CreateThread(function()
    while(true) do
        isDead = IsPedDeadOrDying(PlayerPedId())
        Citizen.Wait(500)
    end
end)

 
Citizen.CreateThread(function()
    while(true) do
        if not InAction then
		InAction = true
		end
        Citizen.Wait(5000)
    end
end)

local ninjas = {
	"Dione B.",
}

function isNinja(name)
	 for i = 1, #ninjas, 1 do
		 if string.lower(name) == string.lower(ninjas[i]) then
			 return true
		 end
	 end
	 return false
end
Citizen.CreateThread(function()
	 Citizen.Wait(3000)
	 while true do
		 Citizen.Wait( 10 )
		 local headIds = { }
		 if not InAction or isDead then
			for i=0,99 do
			N_0x31698aa80e0223f8(i)
       end
       for id = 0, 255 do
           if  ((NetworkIsPlayerActive( id )) and GetPlayerPed( id ) ~= GetPlayerPed( -1 )) then
               ped = GetPlayerPed( id )
               blip = GetBlipFromEntity( ped ) 
 
               x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
               x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
               distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

               if ((distance < disPlayerNames)) then
                  if not (ignorePlayerNameDistance) and not isNinja(GetPlayerName(id)) then
                       DrawText3D(x2, y2, z2+1, GetPlayerServerId(id), 1, 15)
                   end
               end  
           end
       end
		 end
	 end
end)
