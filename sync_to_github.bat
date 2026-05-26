@echo off
echo 家計簿アプリ → GitHub へ同期中...
xcopy /Y /E /I "C:\Users\tominaga\Documents\Claude\Projects\家計簿アプリ\*" "C:\Users\tominaga\Documents\GitHub\kakeibo\"
echo.
echo 完了！GitHub Desktop で Commit → Push してください。
pause
