@echo off
setlocal enabledelayedexpansion

pushd "%~dp0"
set "curDD=%cd%"
popd

cd /d "%curDD%"

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Start-Process pwsh.exe -ArgumentList '-NoProfile', '-ExecutionPolicy Bypass', '-Command \"pwsh.exe -File \"manual-traversal-test.ps1\"\"' -Verb RunAs"

endlocal
exit /b