%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0"" ::","","runas",1)(window.close)&&exit

@echo off
color 81
title 网络监测脚本 - 掉网自动重启无线网卡    Design-By ZengQiuMing 2023-02-05
cd /d %~dp0
rem Ping_IP,network_name,interval_time

:begin
cls
echo "运行本程序，时间格式必须更改为yyyy-MM-dd且必须管理员权限运行，否则可能出错!"
echo "网卡自动检查重启服务正在进行中......"
echo "停止服务请按 Ctrl+C"

echo %date% %time% "ping 192.168.30.251..." >>%date%ping.txt

ping -n 2 192.168.30.251 | find "TTL" >>%date%ping.txt

echo --------%ERRORLEVEL%--------if 1 mean's the net is broken!-------- >>%date%ping.txt

if %ERRORLEVEL% == 1 goto reboot
goto loop

:reboot
echo %date% %time% ".网卡执行重新启动." >>network.log
echo %date% %time% "网卡禁用中...."
netsh interface set interface "无线网络连接" disabled

ping 127.0.0.1 -n 2 > nul

echo %date% %time% "网卡启用中...."
netsh interface set interface "无线网络连接" enabled
echo %date% %time% "网卡已重新启动...."

:loop
ping 127.0.0.1 -n 120 > nul
goto begin
