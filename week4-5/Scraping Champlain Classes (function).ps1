function gatherClasses(){
$page = Invoke-WebRequest -TimeoutSec 2 http://localhost/Courses.html

#gets all the tr elemets of HTML doc 
$trs = $page.ParsedHtml.body.getElementsByTagName("tr")

#empty table 
$fullTable = @()
for($i=1; $i -lt $trs.length; $i++){ #going over every tr element 

    #gets every td element of current tr element 
    $tds = $trs[$i].getElementsByTagName("td")
    
    # Want to separate start and end time from one time field
    $times = $tds[5].innerText.Split("-") 
    
    $fullTable += [PSCustomObject]@{"Class Code" = $tds[0].innerText; 
                                    "Title" = $tds[1].innerText; 
                                    "Days" = $tds[4].innerText; 
                                    "Time Start" = $times[0];
                                    "Time End" = $times[1]; 
                                    "Instructor" = $tds[6].innerText; 
                                    "Location" = $tds[9].innerText; }
                                     } 
return $fullTable
} 


function dayTranslator($fullTable){ 

for($i = 0; $i -lt $fullTable.length; $i++){ 
    #empty array to hold days for every record 
    $days = @()

    #if you see "M" -> monday 
    if($fullTable[$i].Days -ilike "*M*"){ $days += "Monday" } 
    
    #if you see "T" followed byt T, W, or F -> Tuesday
    if($fullTable[$i].Days -ilike "*T[WF]*"){ $days += "Tuesday" } 
    #If you only see "T" -> Tuesday
    Elseif($fullTable[$i].Days -ilike "T"){ $days += "Tuesday" }
    
    #if you see "W" -> Wednesday 
    if($fullTable[$i].Days -ilike "*W*"){ $days += "Wednesday" } 
    
    #If you see"TH" -> Thursday 
    if($fullTable[$i].Days -ilike "*TH*"){ $days += "Thursday" } 
    
    #if you see "F" -> Friday 
    if($fullTable[$i].Days -ilike "*F*"){ $days += "Friday" } 
    
    $fullTable[$i].Days = $days
} 
    
return $fullTable 
} 


dayTranslator (gatherClasses) | Group-Object -Property "Class Code", "Title", "Location", "Time Start" |
    Where-Object { $_.Count -gt 1 } |
    ForEach-Object { $_.Group } |
    Format-Table -AutoSize |
    Out-File -FilePath "$PSScriptRoot\duplicates.txt"

#$translatedTable = dayTranslator (gatherClasses) 
#$translatedTable