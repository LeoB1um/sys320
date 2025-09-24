function onOffLogs($days){

$shutdowns = Get-EventLog System -After (Get-Date).AddDays(-$days) | where {$_.EventID -eq "6006"} 

$shutdownsTable = @() # Empty array
for($i=0; $i -lt $shutdowns.Count; $i++){

#creating event property value 
$event = ""
if($shutdowns[$i].EventID -eq 6006) {$event="Shutdown"}
if($shutdowns[$i].EventID -eq 6008) {$event="Startup"}

#creating user property value
$user = "System"



#adding new line (PSCustomObject) to empty array
$shutdownsTable += [PSCustomObject]@{
        "Time" = $shutdowns[$i].TimeGenerated;
        "Id" = $shutdowns[$i].EventID;
        "Event" = $event;
        "User" = $user;
        }
} # end of for


return $shutdownsTable
}