rem The purpose of this script is to delete old Topcon Field jobs and replace
rem configuration with a clean one. Over the course of semester the configuration
rem on the controllers tends to drift as settings get changed.
rem
rem This script replaces all of the configuration styles (Total Station, GNSS).
rem
rem The jobs in the Jobs folder are all deleted.
@echo off
cls

title UniSQ Topcon Field Config Cleaner 

tasklist /fi "ImageName eq tf.exe" /fo csv 2>NUL | find /I "tf.exe">NUL
if "%ERRORLEVEL%"=="0" echo Topcon Field is running. Close the program and rerun this command. && exit /B

echo UniSQ Topcon Field Config Cleaner
echo:
echo WARNING - IF YOU RUN THIS SCRIPT IT WILL DELETE ALL CONFIG STYLES AND JOB FILES
echo
echo All job files in the Job directory will be permanently deleted.
echo:

rem Set directory config
set TOPCON_FIELD_JOBS_DIR="%userprofile%\Documents\Topcon Field PC\Jobs"
echo Jobs directory: %TOPCON_FIELD_JOBS_DIR%

set TOPCON_FIELD_APPDATA_DIR="%AppData%\Topcon Field PC"
echo Config styles directory: %TOPCON_FIELD_APPDATA_DIR%

set TOPCON_FIELD_MENU_DIR="%AppData%\Topcon Field PC\Menu"
echo Menu directory: %TOPCON_FIELD_MENU_DIR%

rem Prompt the user before running a destructive command
setlocal
SET AREYOUSURE=N

echo:
:PROMPT
SET /P AREYOUSURE=Do you wish to continue (y/[n])?
if /I "%AREYOUSURE%" neq "y" exit /B

setlocal EnableExtensions DisableDelayedExpansion
set "pwd="

rem Ask for a password before running a destructive command
:PwdPrompt
set /P "pwd=Enter password: " || goto PwdPrompt
setlocal EnableDelayedExpansion
if not "!pwd!" == "boom" exit /B
endlocal
echo The password is correct!
echo:

rem Delete all jobs and replace the Styles.tsstyles config file
echo Going to permanently delete all jobs and the config styles. Close this window if you do not wish to proceed.
pause
echo Deleting all jobs in %TOPCON_FIELD_JOBS_DIR%...
rmdir /s /q %TOPCON_FIELD_JOBS_DIR%
mkdir %TOPCON_FIELD_JOBS_DIR%

echo:
echo Replacing Styles.tsstyles in %TOPCON_FIELD_APPDATA_DIR%...
xcopy /y Styles.tsstyles %TOPCON_FIELD_APPDATA_DIR%
echo:

echo Replacing Menu.xml in %TOPCON_FIELD_MENU_DIR%...
xcopy /y Menu.xml %TOPCON_FIELD_MENU_DIR%
endlocal

title Command Prompt

echo:
echo Cleaning complete!
echo:
pause