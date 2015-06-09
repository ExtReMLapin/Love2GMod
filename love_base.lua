love = {}
love.graphics = {}
love.lastStackColor = Color(255,255,255,255)


local function draw_Circle( x, y, radius, seg ) -- gmod wiki
	local cir = {}

	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 ) -- This is need for non absolute segment counts
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )

	surface.DrawPoly( cir )
end



function love.graphics.setColor( red, green, blue, alpha )
	love.lastStackColor = Color(red, green, blue, alpha)
	surface.SetDrawColor( love.lastStackColor )
end

function love.graphics.rectangle( mode, x, y, width, height )
	if mode == "fill" then
		surface.DrawRect( x, y, width, height )
	else
		surface.DrawLine( x, y, x+width, y )
		surface.DrawLine( x, y, x, y+height )
		surface.DrawLine( x+width, y, x+width, y+height )
		surface.DrawLine( x, y+height, x+width, y+height )
	end
end

function love.graphics.circle( mode, x, y, radius, segments )
	if mode != "fill" then
		surface.DrawCircle( x, y, radius, love.lastStackColor  )
	else
		draw_Circle( x, y, radius, segments)

	end
end




function love.graphics.line(...) -- argument number sentitive, must be multiple of 4
	local args = {...}
	if #args == 1 and istable(args[1]) then
		args = args[1]
	end
		local tbl = args
		if #tbl%4 == 1 then return end
		local i = 1
		while i < #tbl do
			surface.DrawLine(tbl[i], tbl[i+1], tbl[i+2] or tbl[i] , tbl[i+3] or tbl[i+1])
			i = i + 2
		end
end



hook.Add("HUDPaint", "edfhsdf", function()  

	surface.SetDrawColor(255,255,255,255)
	love.graphics.line({200,50, 400,50, 500,300, 100,300, 200,50}) 
	love.graphics.setColor(255, 255, 255);
    love.graphics.circle("fill", 300, 300, 50, 100); -- Draw white circle with 100 segments.

	end)
