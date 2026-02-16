@echo off
setlocal enabledelayedexpansion

pushd "%~dp0"
set "curDD=%cd%"
popd

cd /d "%curDD%"

set "testDir=%curDD%\tests"

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Start-Process pwsh.exe -ArgumentList '-NoProfile', '-ExecutionPolicy Bypass', '-Command \"Invoke-Pester -Path \"%testDir%\" -Output Detailed\"' -Verb RunAs"

endlocal
exit /b