#only displays logs with a 404 or 400 http code
Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 ',' 400 ' 