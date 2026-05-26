@echo off
echo === Start ===
pause
cd /d "C:\Users\tominaga\Documents\Claude\Projects\‰ÆŒv•ëƒAƒvƒŠ"
echo Folder OK
pause
set GIT=
if exist "C:\Program Files\Git\cmd\git.exe" set GIT="C:\Program Files\Git\cmd\git.exe"
if exist "C:\Program Files (x86)\Git\cmd\git.exe" set GIT="C:\Program Files (x86)\Git\cmd\git.exe"
for /d %%D in ("%LOCALAPPDATA%\GitHubDesktop\app-*") do (
    if exist "%%D\resources\app\git\cmd\git.exe" set GIT="%%D\resources\app\git\cmd\git.exe"
)
echo GIT=%GIT%
pause
if "%GIT%"=="" (
    echo git not found
    pause
    exit /b 1
)
if not exist ".git" (
    echo Initializing git...
    %GIT% init
    %GIT% branch -M main
    %GIT% remote add origin https://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@github.com/tominaga-hash/kakeibo.git
    %GIT% config user.email "tominaga@pmc.co.jp"
    %GIT% config user.name "KazNeco"
    %GIT% fetch origin
    %GIT% reset --soft origin/main
    echo Init done
    pause
)
%GIT% config user.email "tominaga@pmc.co.jp"
%GIT% config user.name "KazNeco"
%GIT% add .
%GIT% status --short
echo.
set /p MSG=Commit message (Enter for update): 
if "%MSG%"=="" set MSG=update
%GIT% commit -m "%MSG%"
%GIT% push origin main
echo.
echo === Done ===
pause
