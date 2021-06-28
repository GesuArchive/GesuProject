
:BEGINNING
@ECHO OFF

:SCRIPT_SETTINGS
SET wsl_os=UBUNTU
SET wsl_user=root
SET wsl_dir=%~dp0
@REM SET wsl_dir=%CD%

:SETTINGS_PRINT
CD /D "%wsl_dir%"
ECHO Starting dir: %wsl_dir%

:WSL_INFO
@REM WSL --list --running
WSL --terminate %wsl_os%

:WSL_START
@REM WSL.EXE --distribution %wsl_os% --user %wsl_user%
%wsl_os%.EXE run
@REM "C:\Windows\System32\bash.exe" ~ -c "/bin/login -p -f %wsl_user%"

:END
ECHO ----------------------------------------
ECHO Goodbye!
EXIT %ERRORLEVEL%
