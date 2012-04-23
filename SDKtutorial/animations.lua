	-- *** animations.lua ***
	
	-- Implements Tutorial's animate() animation
	
	-- ***********************************************************
	-- Local variables
	
	-- Boolean variable indicating which portion of animate() loop that's running
	local scaling_down = true
	
	-- ***********************************************************
	-- Functions

	-- Scale-down portion of logo animation
	local
	function logoScaleDown()
		logoImage:animate( {
					duration     = 3000,            -- 3000 milliseconds = 3 seconds
					scale        = { 0, 0 },        -- scale down to nothing
					z_rotation   = 360,             -- rotate 360 degrees, clockwise
					mode         = "EASE_IN_QUART", -- Alpha mode
					on_completed = logoCompleted    -- called when finished
				  } )
	end
	
	-- Scale-up portion of logo animation
	local
	function logoScaleUp()
		-- To continue clockwise spinning, reset z_rotation
		logoImage.z_rotation = { -360, 0, 0 }
		
		logoImage:animate( {
					duration     = 3000,
					scale        = { 1, 1 },         -- return to original size
					z_rotation   = 0,                -- return to 0 degree rotation
					mode         = "EASE_OUT_QUART", -- use ease out for this portion
					on_completed = logoCompleted
				  } )
	end

	-- Function called when animate() completes
	local
	function logoCompleted()
		-- Which portion of the animation did we just complete?
		if( scaling_down ) then
			-- Start scaling-up portion
			scaling_down = false
			logoScaleUp()
		else
			-- Start scaling-down portion
			scaling_down = true
			logoScaleDown()
		end
	end

	-- ***********************************************************
	-- Module entry point
	
	-- Start logo animation
	logoScaleDown()

