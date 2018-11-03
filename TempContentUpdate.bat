::Main Function
@ECHO OFF

::SET default variables
SET ip=192.168.16.131
SET fTemp=C:\TEMP
CD %fTemp%

::Display all folders in TEMP
FOR /d %%D IN (*) DO ECHO %%~fD
SET /P Sharename=Sharename:

::Exit program when Sharename equal ENTER
IF DEFINED %Sharename% (
	ECHO Sharename empty
	EXIT /b 0
	PAUSE
)

SET HOST=\\%ip%\%Sharename%
ECHO Default variables were setting
	
::Connect with HOST
ECHO --------------------------------------------------------------------
ECHO Checking connections with HOST...
NET USE %HOST% >NUL 2>NUL

IF EXIST %HOST% (
	ECHO Server connected
	
	IF NOT EXIST %fTemp%\%Sharename% (
		CD /D %fTemp%
		MKDIR %Sharename% 
		ECHO Dir %Sharename% created
	)

	IF NOT EXIST %fTemp%\%Sharename%\PREVIOUS_%Sharename% (
		MKDIR %fTemp%\PREVIOUS_%Sharename%
		ECHO Dir PREVIOUS_%Sharename% created
	)
	
	CD /D %fTemp%
	::Backup files before overwritted
	XCOPY %Sharename% PREVIOUS_%Sharename% /E /Q /S >NUL 2>NUL
	ECHO Backup complited
	
	::Copy all dir and files from Server to C:\TEMP\<Sharename>
	ECHO Copy file from %HOST% to %fTemp%\%Sharename%
	XCOPY %HOST% %fTemp%\%Sharename% /E /Q
	ECHO Files downloaded
	
	::Disconnect with Server
	NET USE %HOST% /DELETE >NUL 2>NUL
	ECHO Server disconnected
	
	::Display TEMP\<Sharename>
	ECHO --------------------------------------------------------------------
	ECHO Ready to display %fTemp%\%Sharename%
	explorer.exe /ROOT,%fTemp%\%Sharename%
) ELSE (
	ECHO No server connections found
	PAUSE
	EXIT /b 0
)

