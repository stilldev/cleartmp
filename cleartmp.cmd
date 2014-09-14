@echo off
REM - ***********************************************************
REM - cleartmp.cmd - Eric McConkey 2014
REM - 
REM - This script will clear out the following locations:
REM - 	c:\$recycle.bin
REM - 	d:\$recycle.bin
REM - 	thumbnail cache for all users
REM - 	firefox cache for all users
REM - 	chrome cache for all users
REM - 	internet explorer cache for all users
REM - 	windows error reporting cache for all users
REM - 	temp files for all users
REM -   system wide windows error reporting cache
REM -   windows installer temp files
REM -   system memory dump files
REM - 	system temp files
REM - ***********************************************************


setlocal enableextensions
%~d0
cd %~p0
pushd .
REM - ***********************************************************
REM - Clear out the recycle bin
REM - ***********************************************************

if exist "c:\$recycle.bin" (
	c:
	cd c:\$recycle.bin
	attrib /d /s -r -h -s
	echo Clearing out c:\$recycle.bin
	for /d %%i in (*) do rmdir /s /q "%%i"
)
if exist "d:\$recycle.bin" (
	d:
	cd d:\$recycle.bin
	attrib /d /s -r -h -s
	echo Clearing out d:\$recycle.bin
	for /d %%i in (*) do rmdir /s /q "%%i"
)

REM - ***********************************************************
REM - Clear out the thumbnail cache for all users
REM - ***********************************************************
c:
cd c:\users
echo Clearing out thumbnail cache
for /f %%i in ('dir /s /b /a thumbcache_*.db') do del /q "%%i"

REM - ***********************************************************
REM - Clear out the Chrome cache, Firefox cache,
REM - and the Windows Error Reporting (WER) folders
REM - ***********************************************************
c:
cd \users
echo Clearing out Chrome, Firefox and WER caches
for /d %%d in (*) do if exist "%%~fd\appdata" (
	echo Clearing chrome cache for %%~fd
	if exist "%%~fd\appdata\Local\Google\Chrome\User Data" ( 
		cd "%%~fd\appdata\Local\Google\Chrome\User Data"
		for /d %%i in (*) do if exist "%%i\cache" del /q "%%i\cache"
	)
	cd \users
	echo Clearing firefox cache for %%~fd
	if exist "%%~fd\appdata\Local\Mozilla\Firefox\Profiles" (
		cd "%%~fd\appdata\Local\Mozilla\Firefox\Profiles"
		for /d %%i in (*) do if exist "%%i\cache2" del /q "%%i\cache2"
		for /d %%i in (*) do if exist "%%i\cache" del /q "%%i\cache"
	)
	cd \users
	echo Clearing WER cache for %%~fd
	if exist "%%d\appdata\local\microsoft\windows\wer\" (
		rmdir /s /q "%%d\appdata\local\microsoft\windows\wer\"
	)
	cd \users
)

REM - ***********************************************************
REM - Clear out system WER files
REM - ***********************************************************
echo Clearing out system WER files
rmdir /s /q "C:\ProgramData\Microsoft\Windows\WER\reportarchive"
rmdir /s /q "C:\ProgramData\Microsoft\Windows\WER\reportqueue"

REM - ***********************************************************
REM - Clear out system minidump files and installer temp files
REM - ***********************************************************
echo Clearing out system minidump and installer temp files
del /q "c:\windows\minidump\"
del /q "c:\windows\*.dmp"
del /q "c:\windows\installer\*.tmp"

REM - ***********************************************************
REM - Clear out system temp files
REM - ***********************************************************
echo Clearing out system temp files
if exist "c:\windows\temp" (
	cd "\windows\temp"
	del /q "c:\windows\temp\"
	for /d %%d in (*) do (
		rmdir /s /q "%%d"
	)
)

REM - ***********************************************************
REM - Clear out the IE cache and tmp folders for all users
REM - ***********************************************************
popd
icsweep /all