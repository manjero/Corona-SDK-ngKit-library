--
-- Project: ngKit sample app
--
-- Date: September 20, 2011
--
-- Version: 0.1
--
-- File name: main.lua
--
-- Author: Shahar Zrihen
--
-- Abstract: ngKit community example app
--
-- Demonstrates how to use the ngKit module
--
-- Module Dependencies : crypto, ngKit SDK
--
-- Target devices: Device or Device simulator (not corona SDK simulator)
--
-- Update History:
--  v0.1            Create file and open popup
--
-- Comments: 
--
-- Sample code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
-- Copyright (C) 2011 Shahar Zrihen, iDevelop - creative technology. All Rights Reserved.
---------------------------------------------------------------------------------------
display.setStatusBar( display.HiddenStatusBar );

-- Load external libraries 
local ui = require("ui")
local ngkit = require ("ngkit");

local background = display.newImage("carbonfiber.jpg", true);
background.x = display.contentWidth / 2;
background.y = display.contentHeight / 2;

-- These are the function triggered by the button
local button1Press = function( event )
	if event.phase == "ended" then
		--print( "release" );
		ngkit.open();
	end;
end;


-- This button has individual press and release functions
local button1 = ui.newButton{
	default = "buttonRed.png",
	over = "buttonRedOver.png",
	onRelease = button1Press,
	text = "Community",
	emboss = true
}

button1.x = display.contentWidth / 2; button1.y = display.contentHeight / 2;
