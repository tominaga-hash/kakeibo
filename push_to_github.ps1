Set-Location $PSScriptRoot

$git = "C:\Users\tominaga\AppData\Local\GitHubDesktop\app-3.5.10\resources\app\git\cmd\git.exe"
$remote = "https://tominaga-hash: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@github.com/tominaga-hash/kakeibo.git"

$env:GCM_INTERACTIVE = "never"
$env:GIT_TERMINAL_PROMPT = "0"

if (-not (Test-Path ".git")) {
    Write-Host "First time setup..."
    & $git init
    & $git branch -M main
    & $git remote add origin $remote
    & $git config user.email "tominaga@pmc.co.jp"
    & $git config user.name "KazNeco"
    & $git -c credential.helper="" fetch origin
    & $git reset --soft origin/main
    Write-Host "Setup done"
}

& $git config user.email "tominaga@pmc.co.jp"
& $git config user.name "KazNeco"
& $git remote set-url origin $remote
& $git add .
& $git status --short

$msg = Read-Host "Commit message (Enter for update)"
if ($msg -eq "") { $msg = "update" }

& $git commit -m $msg
& $git -c credential.helper="" push origin main

Write-Host "=== Pushed to GitHub ==="
Read-Host "Press Enter to close"
