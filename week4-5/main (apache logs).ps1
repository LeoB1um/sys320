. (Join-Path $PSScriptRoot 'Apache-Logs.ps1')


$page = "index.html"
$code = "200"
$browser = "Firefox"

getIPs -page $page -code $code -browser $browser