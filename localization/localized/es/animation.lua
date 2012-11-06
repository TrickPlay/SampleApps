--
-- Localized animation function
--
-- Spanish
--
-- *********************************************************

-- Function argument(s)
-- Note: This syntax is like defining a function that accepts a single argument called billbrd.
-- To define a function with multiple arguments, simply separate them with commas, as in:
-- 		local billbrd, property, duration = ...
local billbrd = ...


	ROTATION_LOW	= 0			-- low range of rotation in degrees
	ROTATION_HIGH	= -7		-- high range of rotation in degrees
	DURATION		= 3000		-- animation duration in milliseconds

	timelineOne		= nil		-- performs first half of animation
	timelineTwo		= nil		-- performs second half of animation

	rotationOne		= nil		-- Phase One rotation Interval in degrees
	rotationTwo		= nil		-- Phase Two rotation Interval in degrees


	-- Define degree intervals of rotation
	rotationOne = Interval( ROTATION_LOW,  ROTATION_HIGH )
	rotationTwo = Interval( ROTATION_HIGH, ROTATION_LOW )

	-- Create timeline to implement Phase One/Rotation about the X-axis
	timelineOne = Timeline( { duration = DURATION } )

	-- Define and register Phase One on_new_frame handler
	function phaseOneNewFrame( self, msecs, progress )
		-- Rotate billbrd about X-axis
		billbrd.x_rotation = { rotationOne:get_value( progress ), 0, 0 }
	end
	timelineOne:add_onnewframe_listener( phaseOneNewFrame )

	-- Define and register Phase One on_completed handler
	function phaseOneCompleted( self, msecs, progress )
		-- Start rotating in opposite direction
		timelineTwo:start()
	end
	timelineOne:add_oncompleted_listener( phaseOneCompleted )

	-- Create timeline to implement Phase Two/Rotation about the X-axis
	timelineTwo = Timeline( { duration = DURATION } )

	-- Define and register Phase Two on_new_frame handler
	function phaseTwoNewFrame( self, msecs, progress )
		-- Rotate billbrd about X-axis
		billbrd.x_rotation = { rotationTwo:get_value( progress ), 0, 0 }
	end
	timelineTwo:add_onnewframe_listener( phaseTwoNewFrame )

	-- Define and register Phase Two on_completed handler
	function phaseTwoCompleted( self, msecs, progress )
		-- Begin cycle again by rotating in opposite direction
		timelineOne:start()
	end
	timelineTwo:add_oncompleted_listener( phaseTwoCompleted )

	-- Start animation, Phase One
	timelineOne:start()

-- *********************************************************

