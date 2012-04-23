	-- *** loadImages.lua ***

	--[[ Creates the following global variables
	
			logoImage   - Image object with loaded TrickPlay logo image
			sphereImage - Image object with loaded Red Sphere image
			sphereClone - Clone object of Red Sphere image
	--]]
	
	-- Load the TrickPlay logo image
	logoImage = Image( { src = "tpLogo.png" } )
	if( logoImage.loaded == false ) then
		print( "Could not load TrickPlay logo" )
		return
	end

	-- Set the image's anchor point to its center
	logoImage.anchor_point = { logoImage.width / 2, logoImage.height / 2 }
	
	-- Set the image's position in the middle of demoArea1's display space (demoSpace1)
	logoImage.position = { (demoSpace1.width  / 2) + demoSpace1.x,
	                       (demoSpace1.height / 2) + demoSpace1.y - 20 }
	
	-- Add the image to the demoArea1 group
	demoArea1:add( logoImage )
	
	-- Load the red sphere image
	sphereImage = Image( { src = "sphereRed.png" } )
	if( sphereImage.loaded == false ) then
		print( "Could not load sphere image" )
		return
	end
	
	-- Set the image's anchor point to its center
	sphereImage.anchor_point = { sphereImage.width / 2, sphereImage.height / 2 }
	
	-- Position the image in the left-center of the demoArea2's display space (demoSpace2)
	sphereImage.position = {  demoSpace2.x + 75,
	                         (demoSpace2.height / 2) + demoSpace2.y }

	-- Create a clone of the sphere
	sphereClone = Clone( { source = sphereImage } )
	
	-- Set Clone's anchor point and position it in the center of the display space
	sphereClone.anchor_point = { sphereClone.width  / 2, sphereClone.height / 2 }
	sphereClone.position     = { (demoSpace2.width  / 2) + demoSpace2.x,
	                             (demoSpace2.height / 2) + demoSpace2.y }
	
	-- Add the two images to the demoArea2 group
	demoArea2:add( sphereClone, sphereImage )

