::AutoSetTemp
::@author Konrad Skrzypczyk
::@date 01.09.2017 
::@description Computer science in high school - automation of the first minutes of the lesson

::Main Function
@ECHO OFF

::Set default variables
SET ip=192.168.16.131
SET HOST=\\%ip%
SET fTemp=C:\TEMP

::Show sharename folder from HOST
ECHO Shearch shared folders...
NET VIEW %HOST%

IF ERRORLEVEL 1 (
	ECHO No HOST connections found
	EXIT /b 0
	PAUSE
)

SET /P Sharename=Sharename:
::Exit program when Sharename equal ENTER
IF DEFINED %Sharename% (
	ECHO Sharename empty
	EXIT /b 0
	PAUSE
)

SET HOST=\\%ip%\%Sharename%
ECHO Default variables were setting
	
::TEMP found - clear and make dir <Sharename>
IF EXIST %fTemp% (
    ECHO %fTemp% found
	CD /D %fTemp%
	RMDIR /S /Q . >NUL 2>NUL
	ECHO %fTemp% cleared
	MKDIR %Sharename% 
	ECHO Dir %Sharename% created
) ELSE (
	::Creat TEMP if not found in C:\
	ECHO No found %fTemp%
	MKDIR %fTemp%\%Sharename%
	ECHO %fTemp% created
)

::Connect with HOST
ECHO --------------------------------------------------------------------
ECHO Checking connections with HOST...
NET USE %HOST% >NUL 2>NUL

IF EXIST %HOST% (
	ECHO HOST connected
	::Copy all dir and files from HOST to C:\TEMP\<Sharename>
	ECHO Copy file from %HOST% to %fTemp%\%Sharename%
	XCOPY %HOST% %fTemp%\%Sharename% /E /Q
	ECHO Files downloaded
	
	::Disconnect with HOST
	NET USE %HOST% /DELETE >NUL 2>NUL
	ECHO HOST disconnected
) ELSE (
	ECHO No HOST connections found
	EXIT /b 0
	PAUSE
)

::Display TEMP\<Sharename>
ECHO --------------------------------------------------------------------
ECHO Ready to display %fTemp%\%Sharename%
PAUSE
explorer.exe /ROOT,%fTemp%\%Sharename%

