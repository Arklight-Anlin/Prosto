@echo off
set "REPO=%~dp0"
set "BIN=%REPO%bin"
set /a COPIED=0
set "MINGW_PATHS=C:\msys64\mingw64\bin C:\msys64\usr\bin C:\MinGW\bin"
for %%p in (%MINGW_PATHS%) do (
    if exist "%%p" (
        for %%f in (libgcc_s_seh-1.dll libstdc++-6.dll libwinpthread-1.dll) do (
            if exist "%%p\%%f" (
                copy /Y "%%p\%%f" "%BIN%\%%f" >nul
                if errorlevel 0 if not errorlevel 1 (
                    echo Copied %%f from %%p
                    set /a COPIED+=1
                )
            )
        )
    )
)
echo.
if %COPIED% equ 0 (
    echo No runtime DLLs were found in the common MinGW/MSYS locations.
    echo Please install MinGW/MSYS or restore the missing DLLs manually.
)
if %COPIED% neq 0 (
    echo Restored %COPIED% runtime DLL(s) to %BIN%.
)
