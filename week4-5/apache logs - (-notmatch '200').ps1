#Displays all logs EXCEPT those with a http 200 code
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -NotMatch