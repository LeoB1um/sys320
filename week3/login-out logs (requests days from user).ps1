#asks user to input a number of days to request login/logout logs for the amount of days the user wants before todays date. 
#time machine essentially. 
#gets for a user number selected of days 

function loginLogsVarDays($days){
$loginouts = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$days)

$loginoutsTable = @() # Empty array
for($i=0; $i -lt $loginouts.Count; $i++){

#creating event property value 
$event = ""
if($loginouts[$i].InstanceId -eq 7001) {$event="Log on"}
if($loginouts[$i].InstanceId -eq 7002) {$event="Log off"}

#creating user property value
$user = $loginouts[$i].ReplacementStrings[1]

$SIDo = New-Object -TypeName System.Security.Principal.SecurityIdentifier -ArgumentList $user;
$name = $SIDo.Translate([System.Security.Principal.NTAccount]).Value;

#adding new line (PSCustomObject) to empty array
$loginoutsTable += [PSCustomObject]@{
        "Time" = $loginouts[$i].TimeGenerated;
        "Id" = $loginouts[$i].InstanceID;
        "Event" = $event;
        "User" = $name;
        }
} # end of for


return $loginoutsTable
}

#echo "Please enter number of days you would like to see logs for:" 
#$dayspos = Read-Host

#loginLogsVarDays($dayspos)
