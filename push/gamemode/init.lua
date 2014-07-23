AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

print("Push Started")

resource.AddFile( "content/maps/push_bycrizip.bsp" )
resource.AddFile( "push_bycrizip.bsp" )
resource.AddFile( "content/sound/start.wav" )
resource.AddFile( "start.wav" )
resource.AddFile( "music.wav" )

function GM:PlayerLoadout( pl )
 
    pl:Give( "weapon_fists" )
	pl:SetWalkSpeed( 800 )
	pl:SetJumpPower( 500 )
	
end



function GM:PlayerInitialSpawn( ply ) --"When the player first joins the server and spawns" function

end

local GodMode = {
	Settings = {
		Length = 5
	}
}

function GodMode:PlayerSpawn(ply)
	if !IsValid(ply) then return end
	ply:GodEnable()
	ply.GodEnabled = true
	print("god Started")
	ply:PrintMessage(HUD_PRINTCENTER, "Spawn protection ( 5 sec )")
	ply:Say( "Je Suis Prêt À Tuer !" )
	ply:SetWalkSpeed( 800 )
	ply:SetJumpPower( 500 )

	timer.Simple(self.Settings.Length, function()
		if !IsValid(ply) then return end
		ply:GodDisable()
		ply.GodEnabled = false
	    ply:PrintMessage(HUD_PRINTCENTER, "Spawn protection ( Terminer )")
	print("god stoped")
	end)
end
hook.Add("PlayerSpawn", "GE.PlayerSpawn", function(...) GodMode:PlayerSpawn(...) end)

function GM:OnPlayerHitGround( pl )
 
     local boom = ents.Create( "env_explosion" )
     boom:SetPos( pl:GetPos( ) )
     boom:Spawn( )
     boom:Fire( "explode", "", 0 )
	  
end

function KillCounter( victim, killer, weapon )  
        if killer:GetNWInt("killcounter") == 2 then --nombre de joueur a tuer
            PrintMessage(HUD_PRINTCENTER, "Le Joueur " .. killer:GetName() .. " Gagne !")  --message de gagne
            timer.Simple(10, function()   --Sets up a timer for three seconds
                game.ConsoleCommand("changelevel push_bycrizip \n") --on redemare la map 
            end)  
        end  
            killer:SetNWInt("killcounter", killer:GetNWInt("killcounter") + 1)  --ajoute a chaque joueur tuer	
    end
	hook.Add("OnNPCKilled","KillCounter", KillCounter)
	
	function GM:PlayerHurt( victim, attacker )
    if ( attacker:IsPlayer() ) then
        victim:ChatPrint( "Vous avez été attaqué par : " .. attacker:Nick() )
		victim:StartWalking( )
		victim:Kill()
    end
end

local round = {}

-- Variables
round.Break	= 30	-- 30 second breaks
round.Time	= 600	-- 5 minute rounds

function round.Broadcast(Text)
	for k, v in pairs(player.GetAll()) do
		v:ChatPrint(Text)
        sound.Play("start.wav", v:GetPos(), 100, math.Rand(80, 120))
		
		end
end

function round.Begin( pl )
	-- Your code
	-- (Anything that may need to happen when the round begins)
	PrintMessage(HUD_PRINTCENTER, "Debut de la partie !")
	round.Broadcast("Debut de la partie ! Temps restant : " .. round.Time .. " seconds!")
	timer.Simple(round.Time, round.End)
end

function round.End()
	-- Your code
	-- (Anything that may need to happen when the round ends)
	PrintMessage(HUD_PRINTCENTER, "FIN DE LA PARTIE !")
	round.Broadcast("Fin de la partie prochaine partie : " .. round.Break .. " seconds!")
	timer.Simple(10, function()   --Sets up a timer for three seconds
                game.ConsoleCommand("changelevel push_bycrizip \n") --on redemare la map 
            end) 
	timer.Simple(round.Break, round.Begin)
end

timer.Simple(10, function(ply)   --Sets up a timer for three seconds
round.Begin() 
end)


function GM:PlayerFootstep( ply, pos, foot, sound, volume, rf ) 
     return true -- Don't allow default footsteps
 end
