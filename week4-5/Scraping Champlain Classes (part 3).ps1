. (Join-Path $PSScriptRoot 'Scraping Champlain Classes (function).ps1')

#stores the function data
$fullTable = dayTranslator (gatherClasses)

#List of Unique ITS professors sorted by name.
$ITSinstructors = $fullTable | Where-Object {
                             ($_."Class Code" -like "SYS*") -or `
                             ($_."Class Code" -like "SEC*") -or `
                             ($_."Class Code" -like "NET*") -or `
                             ($_."Class Code" -like "FOR*") -or `
                             ($_."Class Code" -like "CSI*") -or `
                             ($_."Class Code" -like "DAT*") } `
                             | Select-Object "Instructor" `
                             | Sort-Object "Instructor" -Unique 

$ITSinstructors