--
-- TrickPlay Canvas Sample Application
--
-- *********************************************************
-- Constants

-- Names of external files
MAIN_BACKGROUND_IMAGE		= "images/MainBackground.png"

PARTLY_CLOUDY_IMAGE			= "images/PartlyCloudy.png"
THUNDER_IMAGE				= "images/Thunder.png"
RAIN_IMAGE					= "images/Rain.png"
SUNNY_IMAGE					= "images/Sunny.png"
CLOUDY_IMAGE				= "images/Cloudy.png"

SLATE_SHADOW_IMAGE			= "images/Shadow.png"

WEATHER_SLATE_WIDTH			= 300
WEATHER_SLATE_HEIGHT		= 400
WEATHER_SLATE_Y				= 300

-- *********************************************************
-- Global variables

	gWeatherSlates			= {}		-- table of composite images
	gWeatherImages			= { PARTLY_CLOUDY_IMAGE,
	                            THUNDER_IMAGE,
	                            RAIN_IMAGE,
	                            SUNNY_IMAGE,
	                            CLOUDY_IMAGE,
	                          }
	                          
-- *********************************************************
function
displayMainScreen()

	local mainScreen = nil
	
	-- Load the background screen
	mainScreen = Image( { name = "MainScreen",
	                      src  = MAIN_BACKGROUND_IMAGE,
	} )
	if( mainScreen.loaded == false )then
		print( "Could not load the screen's main image:", MAIN_BACKGROUND_IMAGE )
		exit()
		return
	end
	screen:add( mainScreen )

end

-- *********************************************************
function
createCompositeImages()

	local		NUM_WEATHER_SLATES			= 5
	local		WEATHER_SLATE_COLOR_LIGHT	= "#EE9A499F"	-- Less opacity/more texture in lighter area
	local		WEATHER_SLATE_COLOR_DARK	= "#663100CF"	-- More opacity/less texture in darker area
	local		BITMAP_Y                    = 30
	local		TEXT_FONT					= "FreeSerif 48px"
	local		TEMP_COLOR					= "honeydew2"
	local		TEMP_X						= 30
	local		TEMP_Y						= 250
	local		DAY_COLOR					= "tan2"
	local		DAY_Y						= 310

	local		base  						= nil
	local		image 						= nil
	local		bitmap						= nil
	local		bitmap_X					= nil
	local		i     						= nil
	local		weekday						= { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday" }
	local		text						= nil
	

	-- Create NUM_WEATHER_SLATES Canvas objects
	-- Each Canvas object is built up to become a composite image
	for i = 1, NUM_WEATHER_SLATES do
	
		-- Create the base Canvas on which additional images will be composited
		base = Canvas( WEATHER_SLATE_WIDTH, WEATHER_SLATE_HEIGHT )
		
		-- Cover Canvas with a paper texture
		bitmap = Bitmap( { src = "images/PaperTexture.png" } )
		if( bitmap.loaded == true )then
			-- Create rectangle path on which to draw the paper texture
			base:rectangle( 0, 0, WEATHER_SLATE_WIDTH, WEATHER_SLATE_HEIGHT )
			
			--Draw paper texture onto slate canvas
			base:set_source_bitmap( bitmap, 0, 0 )
			base:fill()
		end
	
		-- Fill Canvas with a semi-transparent gradient color from top to bottom
		base:set_source_linear_pattern( 0, 0, 0, WEATHER_SLATE_HEIGHT )
		base:add_source_pattern_color_stop( 0.0, WEATHER_SLATE_COLOR_LIGHT )	-- top
		base:add_source_pattern_color_stop( 1.0, WEATHER_SLATE_COLOR_DARK )		-- bottom
		base:paint()
		
		-- Make slate edges more transparent
		base:rectangle( 0, 0, WEATHER_SLATE_WIDTH, WEATHER_SLATE_HEIGHT )
		base.line_width = 20
		base.op = "DEST_OUT"
		base:set_source_color( { 0, 0, 0, 128 } )	-- used to set transparency level
		base:stroke()
		base.op = "OVER"	-- reset to original setting

		-- Load a weather image for the slate
		bitmap = Bitmap( { src  = gWeatherImages[ math.random( #gWeatherImages ) ] } )
		if( bitmap.loaded == true )then
			-- Create a centered rectangle path on which to draw the bitmap
			bitmap_X = (WEATHER_SLATE_WIDTH - bitmap.width) / 2		-- center along X-axis
			base:rectangle( bitmap_X, BITMAP_Y, bitmap.width, bitmap.height )
			
			-- Draw bitmap onto the weather slate canvas
			base:set_source_bitmap( bitmap, bitmap_X, BITMAP_Y )
			base:fill()
		end

		-- Display temperature range on the slate
		base:move_to( TEMP_X, TEMP_Y )
		base:text_path( TEXT_FONT, "Temp: " .. math.random( 70, 99 ) .. "-" .. math.random( 40, 69 ) )
		base:set_source_color( TEMP_COLOR )
		base:fill()
		
		-- Display day of the week centered on the slate
		-- Note: To center the text, we must use a Text object so we can get the text's width
		text = Text( { text = weekday[ i ],
		               font = TEXT_FONT,
		} )		               
		base:move_to( (WEATHER_SLATE_WIDTH - text.width) / 2, DAY_Y )		-- centered along X-axis
		base:set_source_color( DAY_COLOR )
		base:text_element_path( text )
		base:fill()

		-- Convert Canvas to an Image object and add to table
		image = base:Image()
		gWeatherSlates[ #gWeatherSlates + 1 ] = image
	end

end

-- *********************************************************
function
displayCompositeImages()

	local	SHADOW_Y		= 800
	
	local	slateAreaWidth	= nil
	local	slateXOffset	= nil
	local	i				= nil
	local	shadow			= nil
	local	shadowClone		= nil
	
	-- Position each weather slate and add it to the screen
	
	-- Calculate screen width available for each slate
	slateAreaWidth = screen.width / #gWeatherSlates
	
	-- Calculate X offset to center slate within slateArea
	slateXOffset = (slateAreaWidth - WEATHER_SLATE_WIDTH) / 2
	
	-- Each slate also has a shadow
	shadow = Image( { name = "SlateShadow",
	                  src  = SLATE_SHADOW_IMAGE,
	} )
	
	-- Process each slate
	for i = 1, #gWeatherSlates do
		-- Center the slate in its screen area
		gWeatherSlates[ i ].x = (slateAreaWidth * (i - 1)) + slateXOffset
		gWeatherSlates[ i ].y = WEATHER_SLATE_Y
		
		-- Add it to the screen for display
		screen:add( gWeatherSlates[ i ] )
		
		-- Process slate's shadow
		if( i == 1 )then
			if( shadow ~= nil )then
				-- Use the original Image object
				shadow.x = gWeatherSlates[ i ].x
				shadow.y = SHADOW_Y
				screen:add( shadow )
			end
		elseif( shadow ~= nil )then
			-- Use a Clone of the Image object
			shadowClone = Clone( { name = "ShadowClone" .. i,
			                       source = shadow,
			} )
			shadowClone.x = gWeatherSlates[ i ].x
			shadowClone.y = SHADOW_Y
			screen:add( shadowClone )
		end
	end

end

-- *********************************************************
-- Program's main entry point

	-- Show the main background screen
	displayMainScreen()
	
	-- Create the composite images
	createCompositeImages()
	
	-- Position composite image on the screen
	displayCompositeImages()

	-- Show the screen
	screen:show()

