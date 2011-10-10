--
-- Project: ngKit Module
--
-- Date: September 20, 2011
--
-- Version: 0.2
--
-- File name: main.lua
--
-- Author: Shahar Zrihen
--
-- Abstract: ngKit community library
--
-- Creates all the necessary data and functions to handle ngKit Community Module 
-- The module checks if the file has been created and if not, creates the loader file 
--
-- Module Dependencies : crypto, ngKit SDK
--
-- Target devices: Device or Device simulator (not corona SDK simulator)
--
-- Update History:
--	v0.2			Update to remove "package.seeall" 
--  v0.1            Create file and open popup
--
-- Comments: 
--
-- Sample code is MIT licensed, see http://www.opensource.org/licenses/mit-license.php
-- Copyright (C) 2011 Shahar Zrihen, iDevelop - creative technology. All Rights Reserved.
--------------------------------------------------------------------------------------

-- define a local table to store all references to functions/variables
local M = {}

-- init
--print "Initilizing ngKit";

-- Determine if running on Corona Simulator
local isSimulator = "simulator" == system.getInfo("environment");
if isSimulator then print ("Simulator") end;

-- Location of processed file.
local filePath = system.pathForFile( "loader.html", system.DocumentsDirectory );

-- io.open opens the file if it exists or returns nil if no file found
local loaderFile = io.open( filePath, "r" );

if loaderFile then	
	
	-- Processed file already created. all is good.
	--print ("file exists");
	io.close( loaderFile ); -- important!
else
	--print( "Creating file..." );
	
	-- Location of original file
	local origPath = system.pathForFile( "loader.html", system.ResourceDirectory );
	
	-- Add crypto library
	require "crypto";
	
	-- Set vars from server
	local dataset = {};
	dataset.secret = "217bac016f3fe34577fceee15f995b6e";
	dataset.COMMUNITY_API_SERVER_ROOT = "http://x.appsto.com/";
	dataset.apiVer = 101;
	dataset.comm_id = "4e922280f874ef535f000010";
	dataset.staticRoot = "http://static.appsto.com/";
	dataset.root = "http://x.appsto.com/";	
	dataset.hideCloseBtn = 0;
	dataset.COMMUNITY_API_POLL_FREQ	= 30.0;
	dataset.internalUrl = "/";
	dataset.deviceInfoJson = '{}';
	dataset.did = crypto.digest( crypto.md5, "corona:" .. system.getInfo( "deviceID" ) );
	dataset.sig = crypto.digest( crypto.md5, dataset.did .. dataset.comm_id .. dataset.secret );
	
	-- End vars from server

	-- Prepare origin file for reading
	local origFile = io.open( origPath, "r" );
	
	-- create target file
	local loaderFile = io.open( filePath, "w" );
	
	-- Read all the data into local var 
	local contents = origFile:read( "*a");
	
	-- Switch strings for values
	local newContents = contents;
	
	for k,v in pairs(dataset) do
		if (k) then
			newContents = string.gsub(newContents, "%%" .. k .. "%%", v);
		end;
	end;
	
	-- Write processed data to new file
	loaderFile:write( newContents );
	
	-- Close open files
	io.close( origFile );
	io.close( loaderFile );
	--print ( "File Created" );
end;


-- open the popup
local open = function( params )
	if (params) then
		
		if not type(params.x) == "int" then
			local x = 0;
		end;
		if not type(params.y) == "int" then
			local y = 0;
		end;
		if not type(params.width) == "int" then
			local width = 320;
		end;
		if not type(params.height) == "int" then
			local height = 480;
		end;
		if not type(params.url) == "string" then
			local url = "loader.html"; -- for now. change when we can control inside pages.
		end;

	end;
	
	-- for now. change when we can control inside pages.
	url = "loader.html"; 
	
	if isSimulator then
		native.showAlert("ngKit", "Web popups are not supported in simulator");
	else
		local options = { hasBackground=false, baseUrl=system.DocumentsDirectory };
		native.showWebPopup( "loader.html" , options );
	end;
end;

M.open = open;

return M;