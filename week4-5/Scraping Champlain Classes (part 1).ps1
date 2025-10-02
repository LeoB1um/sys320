. (Join-Path $PSScriptRoot 'Scraping Champlain Classes (function).ps1')

#stores the function data
$fullTable = dayTranslator (gatherClasses)


#Sorts by name
$fullTable | Where-Object { $_.Instructor -eq "Furkan Paligu" } | `
Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End"
