#!/usr/bin/osascript
--------------------------------------------------------------------------------
# pnam: CREATE MACHINE DEVICE ICON V1.0B
# nmxt: .applescript
# pDSC: Returns a path to a PNG image file containing a hi-resolution icon of 
#       the user's machine 

# plst: -

# rslt: «text» : The path to the PNG file
#       «bool» : false = Failed to write out PNG file
--------------------------------------------------------------------------------
# sown: CK
# ascd: 2019-06-13
# asmo: 2019-06-13
# vers: 1.0b
# url : https://github.com/ChristoferK
--------------------------------------------------------------------------------
use framework "Foundation"
use framework "AppKit"

use scripting additions

property this : a reference to the current application
property nil : a reference to missing value
property _1 : a reference to reference

property NSWorkspace : a reference to NSWorkspace of this

property version : "1.0b"
property folder : a reference to system attribute "TMPDIR"
property filename : "machine.png"
property path : a reference to {my folder, my filename}
property file : a reference to the POSIX file named (a reference to path)

property text item delimiters : "/"
--------------------------------------------------------------------------------
# IMPLEMENTATION:
try
	Alfred()'s folder as alias
	set my folder to the POSIX path of Alfred()'s folder
end try

tell ((NSWorkspace's sharedWorkspace()'s iconForFileType:"'root'")'s ¬
	TIFFRepresentation()'s writeToURL:(my file as «class furl») ¬
	atomically:yes) to if it = true then tell my file to return ¬
	the PNG(POSIX path) of me

false
--------------------------------------------------------------------------------
# HANDLERS & SCRIPT OBJECTS:
# Alfred()
#   An addition for utilising within an Alfred workflow
on Alfred()
	script
		property folder : POSIX file named {¬
			system attribute "alfred_preferences", "workflows", ¬
			system attribute "alfred_workflow_uid", "Icons"}
	end script
end Alfred

to PNG(filepath)
	tell application "Image Events"
		set _img to open filepath
		set _PNG to save _img as PNG in filepath with icon
		return the _PNG's POSIX path
	end tell
end PNG
---------------------------------------------------------------------------❮END❯