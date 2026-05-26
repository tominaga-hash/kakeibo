Set-Location $PSScriptRoot

$git = "C:\Users\tominaga\AppData\Local\GitHubDesktop\app-3.5.10\resources\app\git\cmd\git.exe"

if (-not (Test-Path ".git")) {
    Write-Host "First time setup..."
    & $git init
    & $git branch -M main
    & $git remote add origin "https://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@github.com/tominaga-hash/kakeibo.git"
    & $git config user.email "tominaga@pmc.co.jp"
    & $git config user.name "KazNeco"
    & $git fetch origin
    & $git reset --soft origin/main
    Write-Host "Setup done"
}

& $git config user.email "tominaga@pmc.co.jp"
& $git config user.name "KazNeco"
& $git add .
& $git status --short

$msg = Read-Host "Commit message (Enter for update)"
if ($msg -eq "") { $msg = "update" }

& $git commit -m $msg
& $git push origin main

Write-Host "=== Pushed to GitHub ==="
Read-Host "Press Enter to close"
