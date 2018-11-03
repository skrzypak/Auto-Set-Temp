::Main Function
@ECHO OFF

::SET default variables
SET /P Sharename=Sharename: 
SET fTemp=C:\TEMP
ECHO --------------------------------------------------------------------
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

::Display TEMP\<Sharename>
ECHO --------------------------------------------------------------------
ECHO Ready to display %fTemp%\%Sharename%
explorer.exe /ROOT,%fTemp%\%Sharename%
