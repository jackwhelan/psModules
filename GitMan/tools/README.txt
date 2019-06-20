What is this file?
	This file is a repair/update script in case you have meddled with the code of
	this PowerShell module. Or it requires an update.

How does it work?
	This script installs a JackWhelan folder in your Program Files directory and clones
	the latest psModules repository there. Next it replaces the old/broken version of this
	module with the latest code in all of your systems PowerShell modules folders.

INSTRUCTIONS:

	[1.] Open PowerShell in elevated mode or
             Run as administrator.

	[2.] Navigate to this directory and then execute
	     the script by typing ./Repair-GitMan.ps1

	[3.] The "Repair-GitMan" function is now
             available to use within that PowerShell
	     session.

	[4.] Execute the command "Repair-GitMan" including
	     the "-Verbose" argument if you wish to see what is
             happening in more detail.