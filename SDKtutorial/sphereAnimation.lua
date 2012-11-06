	-- *** sphereAnimation.lua ***

	-- Calculate sphere starting and ending positions
	-- sphereImage positions
	local sphere1StartX  = demoSpace2.x + 75                       -- left-center X
	local sphere1StartY  = (demoSpace2.height / 2) + demoSpace2.y  -- left-center Y
	local sphere1EndX    = demoSpace2.x + demoSpace2.width - 75    -- right-center X
	local sphere1EndY    = sphere1StartY                           -- right-center Y

	-- sphereClone positions
	-- Note: This sphere starts in the center, but to maintain naming consistency,
	--       we apply Start and End names to the sphere's outer travel boundaries.
	local sphere2StartX  = (demoSpace2.width / 2) + demoSpace2.x   -- top-center X
	local sphere2StartY  = demoSpace2.y + 75                       -- top-center Y
	local sphere2EndX    = sphere2StartX                           -- bottom-center X
	local sphere2EndY    = demoSpace2.y + demoSpace2.height - 75   -- bottom-center Y
	local sphere2CenterX = sphere2StartX                           -- display-center X
	local sphere2CenterY = (demoSpace2.height / 2) + demoSpace2.y  -- display-center Y

	-- Define sphere animated paths
	sphere1Path = Path()
	sphere1Path:move_to( sphere1StartX, sphere1StartY )
	sphere1Path:line_to( sphere1EndX,   sphere1EndY   )
	sphere1Path:line_to( sphere1StartX, sphere1StartY )

	sphere2Path = Path()
	sphere2Path:move_to( sphere2CenterX, sphere2CenterY )
	sphere2Path:line_to( sphere2StartX,  sphere2StartY  )
	sphere2Path:line_to( sphere2EndX,    sphere2EndY    )
	sphere2Path:line_to( sphere2CenterX, sphere2CenterY )

	-- Define scaling "route" for both spheres
	-- sphereImage is the X "coordinate," sphereClone is the Y
	sphereScale = Path()
	sphereScale:move_to( 100,  25 )
	sphereScale:line_to( 150, 100 )
	sphereScale:line_to( 100, 150 )
	sphereScale:line_to(  25, 100 )
	sphereScale:line_to( 100,  25 )

	-- Timeline-based animation of spheres
	local
	sphereTimeline = Timeline( {
						duration     = 1000,
						loop         = true,
					 } )

	-- Event handler called to update animated properties
	function sphereFrame( sphereTimeline, msecs, progress )
		-- Update each sphere's X and Y coordinates
		sphereImage.position = sphere1Path:get_position( progress )
		sphereClone.position = sphere2Path:get_position( progress )

		-- Get current scale factors, extract each, and convert back to floating-point scale values
		-- Note: scaleFactors = table of { ImageScaleFactor, CloneScaleFactor }
		local scaleFactors     = sphereScale:get_position( progress )
		local scaleFactorImage = scaleFactors[ 1 ] / 100
		local scaleFactorClone = scaleFactors[ 2 ] / 100

		-- Assign each sphere's scale value
		sphereImage.scale = { scaleFactorImage, scaleFactorImage }
		sphereClone.scale = { scaleFactorClone, scaleFactorClone }
	end

	-- Register the on_new_frame event handler
	sphereTimeline:add_onnewframe_listener( sphereFrame )

	-- Start the animation
	sphereTimeline:start()

