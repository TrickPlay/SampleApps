--
--	Using 3D Assets in a TrickPlay 2D Application
--  Note: This version uses the SpriteSheet and Sprite classes instead of
--  individual image files.

-- *********************************************************
-- Constants

-- Names of external files
MAIN_SCREEN_IMAGE		= "images/Background3D.png"
COIN_SPRITESHEET		= "images/SpritesCoin.json"

-- 3D Coin animation cels

NUM_COIN_CELS			= 24
COIN_ANIMATION_FPS		= (1000 / 24)		-- 24 fps

COIN_INIT_X				= (screen.width / 2)
COIN_INIT_Y				= ((screen.height / 2) + 215)

-- *************************************
-- Note: The positions stored in the following tables are offsets from the coin's
-- "at rest" position stored in the global variables gCoinRestingX and gCoinRestingY

-- Table of cel position offsets for animating the coin left
ANIMATE_COIN_LEFT_POS	= { {    0,    0 },	-- Cel #1
							{   -5,  -10 },
							{  -20,  -37 },
							{  -30,  -82 },
							{  -50, -142 },	-- Cel #5
							{  -79, -207 },
							{  -95, -277 },
							{ -111, -337 },
							{ -127, -392 },
							{ -143, -430 },	-- Cel #10
							{ -159, -455 },
							{ -175, -455 },
							{ -189, -455 },
							{ -203, -445 },
							{ -217, -423 },	-- Cel #15
							{ -231, -395 },
							{ -245, -360 },
							{ -260, -318 },
							{ -275, -270 },
							{ -290, -220 },	-- Cel #20
							{ -305, -170 },
							{ -320, -108 },
							{ -335,  -45 },
							{ -350,    0 },	-- Cel #24
}

-- Table of cel position offsets for animating the coin right
ANIMATE_COIN_RIGHT_POS	= { {   0,    0 },	-- Cel #1
							{   5,  -10 },
							{  20,  -37 },
							{  30,  -82 },
							{  50, -142 },	-- Cel #5
							{  79, -207 },
							{  95, -277 },
							{ 111, -337 },
							{ 127, -392 },
							{ 143, -430 },	-- Cel #10
							{ 159, -455 },
							{ 175, -455 },
							{ 189, -455 },
							{ 203, -445 },
							{ 217, -423 },	-- Cel #15
							{ 231, -395 },
							{ 245, -360 },
							{ 260, -318 },
							{ 275, -270 },
							{ 290, -220 },	-- Cel #20
							{ 305, -170 },
							{ 320, -108 },
							{ 335,  -45 },
							{ 350,    0 },	-- Cel #24
}

-- Table of cel position offsets for animating the coin straight up
ANIMATE_COIN_UP_POS		= { { 0,    0 },	-- Cel #1
							{ 0,  -10 },
							{ 0,  -37 },
							{ 0,  -82 },
							{ 0, -142 },	-- Cel #5
							{ 0, -207 },
							{ 0, -277 },
							{ 0, -337 },
							{ 0, -392 },
							{ 0, -430 },	-- Cel #10
							{ 0, -455 },
							{ 0, -455 },
							{ 0, -455 },
							{ 0, -445 },
							{ 0, -423 },	-- Cel #15
							{ 0, -395 },
							{ 0, -360 },
							{ 0, -318 },
							{ 0, -270 },
							{ 0, -220 },	-- Cel #20
							{ 0, -170 },
							{ 0, -108 },
							{ 0,  -45 },
							{ 0,    0 },	-- Cel #24
}

-- *************************************
-- Global Variables

	gCurrCoinCel		= 1					-- Current coin cel number (1-24)
	gCoinSprites		= nil 				-- SpriteSheet of coin cel images
	gCoinCel  			= nil 				-- Coin cel sprite
	gCoinPos			= nil				-- Table of animation cel offset positions
	gAnimationTimer		= nil				-- Animation timer
	gCoinRestingX		= COIN_INIT_X		-- Coin's X position when "at rest"
	gCoinRestingY		= COIN_INIT_Y		-- Coin's Y position when "at rest"

-- *********************************************************
-- Table of handlers for keystroke input

-- Menu keystroke handler
keyInputHandler = {
	LEFT  = function() animateCoinLeft()  end,
	RIGHT = function() animateCoinRight() end,
	UP    = function() animateCoinUp()    end,
}

-- *********************************************************
function
nextCoinFrame( timer )

	-- Advance to the next frame and sprite
	gCurrCoinCel = gCurrCoinCel + 1								-- reference current cel/frame
	gCoinCel.id  = string.format( "frame%d", gCurrCoinCel )		-- refer to appropriate sprite ID on spritesheet

	-- Position the frame's image
	gCoinCel.x = gCoinRestingX + gCoinPos[ gCurrCoinCel ][ 1 ]
	gCoinCel.y = gCoinRestingY + gCoinPos[ gCurrCoinCel ][ 2 ]

	-- Was this the last frame in the animation?
	if( gCurrCoinCel == NUM_COIN_CELS )then
		-- Yes, terminate animation
		timer:stop()

		-- Save current X coordinate as new at-rest location
		gCoinRestingX = gCoinCel.x

		-- Did coin reach right or left edge of the screen?
		if( (gCoinRestingX > (screen.width - (gCoinCel.width / 2)))		-- right edge test
		    or
		    (gCoinRestingX < (gCoinCel.width / 2)) )then				-- left edge test
				-- Yes, move back to the middle of the screen
				gCoinRestingX = COIN_INIT_X
		end

		-- Move position of first cel to updated position
		gCoinCel.x = gCoinRestingX

		-- Re-init cel index and set to appropriate sprite
		-- Note: The first and last cels in our animation are identical.
		gCurrCoinCel = 1
		gCoinCel.id  = string.format( "frame%d", gCurrCoinCel )
	end

end

-- *********************************************************
function
animateCoinLeft()

	-- Assign Left-animation positions to global variable
	gCoinPos = ANIMATE_COIN_LEFT_POS

	-- Start the animation
	-- Note: gCurrCoinCel == 1 at this point, indexing the animation's first
	-- cel image/frame and first sprite in the spritesheet
	gAnimationTimer:start()

end

-- *********************************************************
function
animateCoinRight()

	-- Assign Right-animation positions to global variable
	gCoinPos = ANIMATE_COIN_RIGHT_POS

	-- Start the animation
	-- Note: gCurrCoinCel == 1 at this point, indexing the animation's first
	-- cel image/frame and first sprite in the spritesheet
	gAnimationTimer:start()

end

-- *********************************************************
function
animateCoinUp()

	-- Assign Up-animation positions to global variable
	gCoinPos = ANIMATE_COIN_UP_POS

	-- Start the animation
	-- Note: gCurrCoinCel == 1 at this point, indexing the animation's first
	-- cel image/frame and first sprite in the spritesheet
	gAnimationTimer:start()

end

-- *********************************************************
function
showTwoCels( animationCelPos )

	-- Utility function that displays semi-transparently two cels in the
	-- animation.
	-- This function is useful when positioning each cel in the animation's
	-- sequence during development.
	-- This function is not called during the normal running of the finished
	-- program.

	-- The animationCelPos argument is a table containing the offsets (from
	-- gCoinRestingX/Y) of each cel's position

	local	i = 5			-- frame to display opaquely
	local	j = 6			-- frame to display semi-transparently
	local	lCoinCel = nil

	-- Position this cel and show it opaquely
	gCoinCel.id = string.format( "frame%d", i )
	gCoinCel.x  = gCoinRestingX + animationCelPos[ i ][ 1 ]
	gCoinCel.y  = gCoinRestingY + animationCelPos[ i ][ 2 ]
	gCoinCel.opacity = 255

	-- Create and initialize second sprite to display semi-transparently
	lCoinCel = Sprite( { sheet = gCoinSprites,
	 					 id    = string.format( "frame%d", j ),
	} )

	if( lCoinCel.loaded == false )then
		print( "lCoinCel sprite was not loaded" )
	end

	-- Place the sprite's origin in its center
	lCoinCel.anchor_point = { lCoinCel.width / 2, lCoinCel.height / 2 }

	-- Add image to screen
	screen:add( lCoinCel )

	-- Position sprite and display it semi-transparently
	lCoinCel.x  = gCoinRestingX + animationCelPos[ j ][ 1 ]
	lCoinCel.y  = gCoinRestingY + animationCelPos[ j ][ 2 ]
	lCoinCel.opacity = 128

end

-- *********************************************************
function
displayMainScreen()

	local	mainScreen = nil

	-- Load the main screen image
	mainScreen = Image( { src = MAIN_SCREEN_IMAGE } )
	if( mainScreen.loaded == false )then
		print( "Could not load the screen's main image: ", MAIN_SCREEN_IMAGE )
		exit()
		return
	end
	screen:add( mainScreen )

end

-- *********************************************************
function
coinSpritesLoaded( coinSheet, failed )

	local  	i = 0

	-- Did the SpriteSheet load successfully?
	if( failed )then
		print( "Could not load spritesheet:", COIN_SPRITESHEET )
		exit()
	end

	-- Create a Sprite object that will reference the coin cels in the SpriteSheet
	gCoinCel = Sprite( { sheet = gCoinSprites,
	 					 id    = string.format( "frame%d", gCurrCoinCel ),
	} )

	if( gCoinCel.loaded == false )then
		print( "gCoinCel sprite was not loaded" )
	end

	-- Make sprite invisible until it is needed
	gCoinCel.opacity = 0

	-- Place the sprite's origin in its center
	gCoinCel.anchor_point = { gCoinCel.width / 2, gCoinCel.height / 2 }

	-- Add image to screen
	screen:add( gCoinCel )

end

-- *********************************************************
function
loadCoinAnimationCels()

	-- Demonstrate the various methods of creating a SpriteSheet
	local	fromJSON  = true			-- if false, create in Lua statements

	-- Define a SpriteSheet
	if( fromJSON )then
		-- Load the JSON map file synchronously
		gCoinSprites = SpriteSheet( { map = COIN_SPRITESHEET } )
		if( gCoinSprites.loaded )then
			-- Initialize each sprite from the sheet
			coinSpritesLoaded( gCoinSprites, false )
		end
	else
		-- Define the map file in Lua
		gCoinSprites = SpriteSheet( {
			map = {
				{
					sprites = {
						{ x = 1422, y = 226, w = 348, h = 260, id = "frame1"  },
						{ x = 358,  y = 261, w = 348, h = 269, id = "frame2"  },
						{ x = 2,    y = 576, w = 343, h = 292, id = "frame3"  },
						{ x = 347,  y = 674, w = 336, h = 323, id = "frame4"  },
						{ x = 1054, y = 618, w = 327, h = 345, id = "frame5"  },
						{ x = 1704, y = 745, w = 318, h = 348, id = "frame6"  },
						{ x = 336,  y = 999, w = 315, h = 322, id = "frame7"  },
						{ x = 1720, y = 488, w = 320, h = 255, id = "frame8"  },
						{ x = 1388, y = 488, w = 330, h = 172, id = "frame9"  },
						{ x = 352,  y = 532, w = 344, h = 140, id = "frame10" },
						{ x = 1069, y = 127, w = 351, h = 194, id = "frame11" },
						{ x = 358,  y = 2,   w = 354, h = 257, id = "frame12" },
						{ x = 2,    y = 2,   w = 354, h = 310, id = "frame13" },
						{ x = 708,  y = 432, w = 344, h = 344, id = "frame14" },
						{ x = 2,    y = 870, w = 332, h = 350, id = "frame15" },
						{ x = 1383, y = 662, w = 319, h = 327, id = "frame16" },
						{ x = 685,  y = 778, w = 318, h = 266, id = "frame17" },
						{ x = 1054, y = 435, w = 332, h = 181, id = "frame18" },
						{ x = 1065, y = 323, w = 347, h = 110, id = "frame19" },
						{ x = 1069, y = 2,   w = 353, h = 123, id = "frame20" },
						{ x = 714,  y = 2,   w = 353, h = 178, id = "frame21" },
						{ x = 1424, y = 2,   w = 351, h = 222, id = "frame22" },
						{ x = 714,  y = 182, w = 349, h = 248, id = "frame23" },
						{ x = 2,    y = 314, w = 348, h = 260, id = "frame24" }

					},
					img = Bitmap( { src = "images/CoinSpriteSheet.png" } )
				},
			}
		} )
	end

end

-- *********************************************************
function
initCoinDisplay()

	-- Position the first coin onscreen and show it
	gCoinCel.position = { COIN_INIT_X, COIN_INIT_Y }
	gCoinCel.opacity  = 255

	-- We'll also define the animation's Timer now, too, but don't start it
	gAnimationTimer = Timer( COIN_ANIMATION_FPS )

	-- Define the handler to show the animation's next frame
	gAnimationTimer.on_timer = nextCoinFrame

end

-- *********************************************************
-- Keyhandler
-- Accepts a table of KEY=function()... where KEY is an element from the
-- TrickPlay SDK's keys global variable and function() is a function that
-- processes the keystroke.
-- Alternatively, the table entry can be KEY="KEY" where "KEY" references
-- an element from the keys global variable; this syntax equates the "KEY"
-- keystroke with KEY.

function
KeyHandler( t )
    return
        function( o , key , ... )
            local k = keys[ key ]:upper()
            while k do
                local f = t[ k ]
                if type( f ) == "function" then
                    return f( o , key , ... )
                end
                k = f
            end
        end
end

-- *********************************************************
-- Program's Main Entry Point

	-- Show the main screen
	displayMainScreen()

	-- Load all the animation's coin cels
	loadCoinAnimationCels()

	-- Show initial coin
	initCoinDisplay()

	-- Hook the screen's menu keyboard input to our handlers
	screen.on_key_down = KeyHandler( keyInputHandler )

	-- Show the TrickPlay screen
	screen:show()

	local	develShowTwoCels = false		-- set to true to display two cel frames simultaneously

	if( develShowTwoCels )then
		-- Development utility function: Determine animation's cel positions
		showTwoCels( ANIMATE_COIN_RIGHT_POS )
	else
		-- Perform program intro
		animateCoinUp()
	end

-- *********************************************************

