echo off
start winvnc.exe -run
timeout /t 1 >nul
start winvnc.exe -connect 192.168.171.165: :5555