#

if (Get-Process -Name "chrome" -ErrorAction SilentlyContinue) {
    Stop-Process -Name "chrome"
} else {
    Start-Process "chrome.exe" -ArgumentList "https://champlain.edu"
    }
