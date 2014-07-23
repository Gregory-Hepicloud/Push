include( "shared.lua" )


surface.CreateFont( "akbar", {
	font = "Arial",
	size = 30,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

function killcounter()  
        draw.WordBox( 8, ScrW() - 180, ScrH() - 98, "Points: "..LocalPlayer():GetNWInt("killcounter"),"akbar",Color(200,0,0,0),Color(255,255,255,255))  
end  
hook.Add("HUDPaint","KillCounter",killcounter)  

function paint()
draw.WordBox( 5, ScrW() - 80, ScrH() - 40, "Push By Crizip", "Default", Color(50,50,75,100), Color(255,255,255,255) )
end
hook.Add( "HUDPaint", "TestPaint", paint )
 