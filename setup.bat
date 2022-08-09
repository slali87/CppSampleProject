@echo off
echo Setup by Batch Script

rem create a temporary batch file in order to the call function can run it
copy .\tools\setup\setup_common .\tools\setup\setup_common.bat
call .\tools\setup\setup_common.bat
set /a error = %errorlevel%
del .\tools\setup\setup_common.bat
if %error%==0 (if %errorlevel% NEQ 0 (
    set /a error = %errorlevel%
))

echo.
echo ==============================
if %error%==0 (
    echo Setup successfully finished!
) else (
    echo Error: %error%
    echo Setup failed!!!
)
echo ==============================