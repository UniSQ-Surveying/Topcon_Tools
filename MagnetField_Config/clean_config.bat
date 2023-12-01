rem The purpose of this script is to replace the Magnet Field configuration
rem with a clean one. Over the course of semester the configuration on the
rem controllers tends to drift as settings get changed.
rem
rem This script replaces all of the configuration styles (Total Station, GNSS).
rem
rem Magnet Field also loads config styles from all jobs in the jobs folder.
rem As a result, all jobs must be deleted in order to only load the
rem desired styles. The jobs are backed up to the Backups folder in
rem user documents.

rem Don't want to print each command as it runs
@echo off

rem Clear the command prompt screen
cls

title UniSQ Magnet Field Config Cleaner 

tasklist /fi "ImageName eq MAGNET_Field.exe" /fo csv 2>NUL | find /I "MAGNET_Field.exe">NUL
if "%ERRORLEVEL%"=="0" echo Magnet Field is running. Close the program and rerun this command. && exit /B

echo UniSQ Magnet Field Config Cleaner
echo:
echo WARNING - IF YOU RUN THIS SCRIPT IT WILL DELETE ALL CONFIG STYLES
echo
echo All job files will be moved from the Job directory to the Backup directory (shown below)
echo:

rem Set directory config
set MAGNET_FIELD_JOBS_DIR="%userprofile%\Documents\MAGNET Field PC\Jobs"
echo Jobs directory: %MAGNET_FIELD_JOBS_DIR%

rem if not exist %BACKUP_DIR% mkdir %BACKUP_DIR%

set BACKUP_DIR="%userprofile%\Documents\MAGNET Field PC\Backup"
echo Backup directory: %BACKUP_DIR%

set MAGNET_FIELD_APPDATA_DIR="%AppData%\MAGNET Field PC"
echo Config styles directory: %MAGNET_FIELD_APPDATA_DIR%

set MAGNET_FIELD_MENU_DIR="%AppData%\MAGNET Field PC\Menu"
echo Menu directory: %MAGNET_FIELD_MENU_DIR%

rem Prompt the user before running a destructive command
setlocal
SET AREYOUSURE=N

echo:
:PROMPT
SET /P AREYOUSURE=Do you wish to continue (y/[n])?
if /I "%AREYOUSURE%" neq "y" exit /B

setlocal EnableExtensions DisableDelayedExpansion
set "pwd="

rem Ask for a password before running a destuctive command
rem https://stackoverflow.com/questions/72406478/secure-password-protected-batch
:PwdPrompt
set /P "pwd=Enter password: " || goto PwdPrompt
setlocal EnableDelayedExpansion
if not "!pwd!" == "boom" exit /B
endlocal
echo The password is correct!
echo:

rem Move all jobs and replace the Styles.tsstyles config file
echo Going to backup all jobs and delete the config styles. Close this window if you do not wish to proceed.
pause
echo Moving all jobs to %BACKUP_DIR%...
robocopy /move /e /nfl /ndl /njh /njs %MAGNET_FIELD_JOBS_DIR% %BACKUP_DIR%

echo:
echo Replacing Styles.tsstyles in %MAGNET_FIELD_APPDATA_DIR%...
xcopy /y Styles.tsstyles %MAGNET_FIELD_APPDATA_DIR%
echo:

echo Replacing Menu.xml in %MAGNET_FIELD_MENU_DIR%...
xcopy /y Menu.xml %MAGNET_FIELD_MENU_DIR%
endlocal

title Command Prompt

echo:
echo Cleaning complete!
echo:
pause