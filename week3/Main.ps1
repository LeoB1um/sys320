. (Join-Path $PSScriptRoot 'login-out logs (function only).ps1')
. (Join-Path $PSScriptRoot 'system boot-shutdown (function only).ps1')
clear


#checks for logins and logoffs from the last 15 days
$logins = loginLogsVarDays(15)
$logins


#checks for shutdowns and startups in the last 25 days
$ShutdownLogs = onOffLogs
(25)
$ShutdownLogs