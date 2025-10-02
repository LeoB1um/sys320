#Searches every log in the directory for the word error and printing all logs with 'error' contained within it. 
$a = Get-ChildItem C:\xampp\apache\logs\*.log  | Select-String -AllMatches 'error'

#prints the lasts 5 entries

$a[-5..-1] 