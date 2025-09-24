#Gets login and logoff records from windows events and saves to a variabe 
#gets the last 14 days.
$loginouts = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-15)

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


$loginoutsTable