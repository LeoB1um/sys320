. "C:\Users\champuser\sys320\week6\Event-Logs1.ps1"
. "C:\Users\champuser\sys320NoUpload\week7\Email.ps1"
. (Join-Path $PSScriptRoot "Scheduler.ps1")
. (Join-Path $PSScriptRoot "Functions.ps1")

#checks if user is running file as administrator, if not program errors out.
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script must be run as Administrator." -ForegroundColor Yellow -BackgroundColor Black
    exit
}

# Getting config
$config = getConfig

# obtaining risk users
$failed = atRiskUsers $config.Days

#sending at risk users in an email
SendAlertEmail ($failed | Format-Table | Out-String)

# setting a time to run the script every day
ChooseTimeToRun($config."Execution Time")