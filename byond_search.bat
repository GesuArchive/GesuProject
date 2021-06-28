
@ECHO OFF

ECHO.
ECHO. Script to search BYOND istall dir.
ECHO.

SETLOCAL ENABLEDELAYEDEXPANSION
SET reg_path_32="HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\BYOND"
SET reg_path_64="HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\BYOND"

ECHO. Path for 32 bit BYOND: %reg_path_32%
ECHO. Path for 64 bit BYOND: %reg_path_64%
ECHO.

SET "DisplayName="
SET "DisplayVersion="
SET "InstallLocation="

FOR %%s IN (
	%reg_path_32%
	%reg_path_64%
) DO (
	ECHO Now searching for: %%s
	FOR /f "delims=" %%A IN ('REG QUERY %%s /reg:32 2^>nul') DO (
		SET "ln=%%A"
		@REM ECHO %%A
		FOR /f "tokens=1,2*" %%A IN ("!ln!") DO (
			IF "%%A" EQU "DisplayName"     SET "DisplayName=%%C"
			IF "%%A" EQU "DisplayVersion"  SET "DisplayVersion=%%C"
			IF "%%A" EQU "InstallLocation" SET "InstallLocation=%%C"
		)
	)
	IF NOT DEFINED DisplayName (
		ECHO ERROR! BYOND not founded!
		@REM PAUSE
		@REM EXIT 1
	)
	ECHO. DisplayName: "!DisplayName!"
	ECHO. DisplayVersion: "!DisplayVersion!"
	ECHO. InstallLocation: "!InstallLocation!"
	ECHO.
)

@REM FOR /F "Skip=1 Tokens=2*" %%A IN ('REG QUERY %reg_path_32% /V "InstallLocation" 2^>Nul') DO (SET "InstallLocation=%%~B")
@REM ECHO InstallLocation: "%InstallLocation%"

PAUSE
EXIT %ERRORLEVEL%
