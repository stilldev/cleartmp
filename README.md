Script to clear temp files from terminal servers

Instructions
------------

* Extract all the files into a folder
* make a scheduled task for init.cmd, run as SYSTEM and highest privileges

init.cmd will download the latest version from github every time it is executed.

To run cleartmp without downloading the latest version, just run cleartmp.cmd as administrator

What it Does
------------

This script will delete the following files:
*	C: and D: recycle bins
*	Thumbnail cache for all users (all thumbnail_*.db files in profile dir)
*	Firefox cache for all users (for all firefox profiles)
*	Chrome cache for all users (for all chrome profiles)
*	Internet explorer cache for all users
*	Windows error reporting cache for all users (appdata\local\microsoft\windows\wer\*)
*	Temp files for all users (appdata\local\temp\*)
*	System wide windows error reporting cache (c:\programdata\microsoft\windows\wer)
*	Windows installer temp files (c:\windows\installer\*.tmp)
*	System memory dump files (c:\windows\*.dmp and c:\windows\minidump\*)
*	System temp files (c:\windows\temp\*)

This utilizes icsweep.exe for the per-user IE cache and temp files (http://www.ctrl-alt-del.com.au/files/ICSweep.txt)
