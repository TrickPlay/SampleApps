-- TrickPlay SDK Tutorial
	
	-- Display message on Engine console
	print( "TrickPlay SDK Tutorial" )

	-- Create a Rectangle to use as the screen's colored background
	backGround = Rectangle( {
	                size     = { 1920, 1080 },
	                position = { 0, 0, 0 },
	                color    = { 70, 100, 130, 255 }
	             } )

	-- Add the background to the display
	screen:add( backGround)

	-- Create the window's header area
	header = Rectangle( {
				size     = { 1920, 200 },
				position = { 0, 0 },
				color    = { 211, 211, 211, 128 }
	         } )
	         
	-- Add the header area to the screen
	screen:add( header )

	-- Load localized text strings into a table called localStr
	localStr = dofile( "localized:strings.lua" )
		
	-- Create header label, using localized header text
	headerLabel = Text( {
					text     = localStr.header,
					font     = "DejaVu Sans Bold 80px",
					color    = { 245, 245, 220, 255 },
					position = { 190, 50 }
				  } )
				 
	-- Add the header label to the screen
	screen:add( headerLabel )

	-- Create DemoArea1 Group and add it to the screen
	demoArea1 = Group( { position = { 200, 300 } } )
	screen:add( demoArea1 )

	-- Create DemoArea1's base
	demoBase1 = Rectangle( {
					size     = { 650, 600 },
					position = { 0, 0 },
					color    = { 211, 211, 211, 128 }
	         	} )
	         	
	-- Create DemoArea1's display space
	demoSpace1 = Rectangle( {
					size     = { 550, 450 },
					position = { 50, 50 },
					color    = { 220, 220, 220, 128 },
					border_width = 4,
					border_color = { 139, 69, 19, 128 }
				 } )

	-- Add base and display space rectangles to demoArea group
	demoArea1:add( demoBase1, demoSpace1 )

	-- Create a second demo area, repeating the previous steps
	demoArea2 = Group( { position = { 1050, 300 } } )
	screen:add( demoArea2 )
	
	-- Create DemoArea2's base and display space
	demoBase2  = Rectangle( {
					size     = { 650, 600 },
					position = { 0, 0 },
					color    = { 211, 211, 211, 128 }
				 } )
	demoSpace2 = Rectangle( {
					size     = { 550, 450 },
					position = { 50, 50 },
					color    = { 220, 220, 220, 128 },
					border_width = 4,
					border_color = { 139, 69, 19, 128 }
				 } )
				 
    -- Add base and display space rectangles to demoArea group
	demoArea2:add( demoBase2, demoSpace2 )

	-- Create footers for demo areas
	demoFooter1 = Text( {
					text     = localStr.demoFooter1,
					font     = "DejaVu Serif Bold 40px",
					color    = { 50, 50, 50, 255 },
					position = { 225, 520 }
				  } )
	demoArea1:add( demoFooter1 )
	
	demoFooter2 = Text( {
					text     = localStr.demoFooter2,
					font     = "DejaVu Serif Bold 40px",
					color    = { 50, 50, 50, 255 },
					position = { 225, 520 }
				  } )
	demoArea2:add( demoFooter2 )

	-- Load images
	-- Creates global variables called logoImage, sphereImage, and sphereClone
	dofile( "loadImages.lua" )

	-- Animate the TrickPlay logo
	dofile( "logoAnimation.lua" )
	
	-- Animate the two spheres
	dofile( "sphereAnimation.lua" )
	
	-- Show the display
	screen:show()
	
	
	
