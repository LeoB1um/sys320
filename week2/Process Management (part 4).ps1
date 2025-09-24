#This script checks if chrome is running
#if it is running then it stops the proccess 
#

if (Get-Process -Name "chrome" -ErrorAction SilentlyContinue) {
    Stop-Process -Name "chrome"
} else {
    Start-Process "chrome.exe" -ArgumentList "https://champlain.edu"
    }
