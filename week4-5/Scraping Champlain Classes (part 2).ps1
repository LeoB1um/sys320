. (Join-Path $PSScriptRoot 'Scraping Champlain Classes (function).ps1')

#stores the function data
$fullTable = dayTranslator (gatherClasses)




#Lists all the classes in Joyce 310 on mondays 
 $fullTable | Where-Object {($_.Location -eq "JOYC 310") -and ($_.days -eq "Monday")} | `
    Sort-Object "Time Start" | `
    Select-Object "Time Start", "Time End", "Class Code"
