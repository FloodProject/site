@echo off
goto menu

:menu
echo Tools:
echo.
echo [0] Install Drupal
echo [1] Backup
echo [2] Restore
echo [3] Build
echo.

:choice
set /P C="Choice: "
if "%C%"=="0" goto install
if "%C%"=="1" goto backup
if "%C%"=="2" goto restore
if "%C%"=="3" goto build
goto quit

:install
lua "./tools/install.lua"
goto quit

:backup
lua "./tools/backup.lua"
goto quit

:restore
lua "./tools/restore.lua"
goto quit

:build
lua "./tools/build.lua"
goto quit

:quit
pause
:end