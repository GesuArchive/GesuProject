
:BEGINNING
@ECHO OFF

:COMPULE
dm.exe -l -verbose GesuProject.dme

:END
ECHO ----------------------------------------
ECHO Goodbye!
EXIT %ERRORLEVEL%
