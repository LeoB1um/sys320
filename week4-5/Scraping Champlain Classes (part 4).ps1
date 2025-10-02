. (Join-Path $PSScriptRoot 'Scraping Champlain Classes (function).ps1')


#stores the function data
$fullTable = dayTranslator (gatherClasses)


# Step 1: Get list of ITS instructors teaching SYS, SEC, NET, FOR, CSI, DAT classes
$ITSinstructors = $fullTable | Where-Object {
    ($_."Class Code" -like "SYS*") -or
    ($_."Class Code" -like "SEC*") -or
    ($_."Class Code" -like "NET*") -or
    ($_."Class Code" -like "FOR*") -or
    ($_."Class Code" -like "CSI*") -or
    ($_."Class Code" -like "DAT*")
} | Select-Object -ExpandProperty "Instructor" -Unique | Sort-Object

# Step 2: Group ITS instructors by number of classes taught
$fullTable | Where-Object {
        $ITSinstructors -contains $_.Instructor 
        } | Group-Object "Instructor" | Select-Object Count, Name | Sort-Object Count -Descending

