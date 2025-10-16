. (Join-Path $PSScriptRoot String-Helper.ps1)



<# ******************************
     Function Explaination
****************************** #>
function getLogInAndOffs($timeBack){

$loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$timeBack)

$loginoutsTable = @()
for($i=0; $i -lt $loginouts.Count; $i++){

$type = ""
if($loginouts[$i].InstanceID -eq 7001) {$type="Logon"}
if($loginouts[$i].InstanceID -eq 7002) {$type="Logoff"}


# Check if user exists first
$user = (New-Object System.Security.Principal.SecurityIdentifier `
         $loginouts[$i].ReplacementStrings[1]).Translate([System.Security.Principal.NTAccount])

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                       "Id" = $loginouts[$i].InstanceId; `
                                    "Event" = $type; `
                                     "User" = $user;
                                     }
} # End of for

return $loginoutsTable
} # End of function getLogInAndOffs





<# ******************************
     Function Explaination
****************************** #>
function getFailedLogins($timeBack){
  
  $failedlogins = Get-EventLog security -After (Get-Date).AddDays(-$timeBack) | Where { $_.InstanceID -eq "4625" }

  $failedloginsTable = @()
  for($i=0; $i -lt $failedlogins.Count; $i++){

    $account=""
    $domain="" 

    $usrlines = getMatchingLines $failedlogins[$i].Message "*Account Name*"
    $usr = $usrlines[1].Split(":")[1].trim()

    $dmnlines = getMatchingLines $failedlogins[$i].Message "*Account Domain*"
    $dmn = $dmnlines[1].Split(":")[1].trim()

    $user = $dmn+"\"+$usr;

    $failedloginsTable += [pscustomobject]@{"Time" = $failedlogins[$i].TimeGenerated; `
                                       "Id" = $failedlogins[$i].InstanceId; `
                                    "Event" = "Failed"; `
                                     "User" = $user;
                                     }

    }

    return $failedloginsTable
} # End of function getFailedLogins


# Gets a list of users who have failed password attempts over the last 'x' days
Function atRiskUsers($days) {

        $badLogins = Get-LocalUser | Select-Object -ExpandProperty Name                   

        $failedLogins = getFailedLogins($days) 
  

        $badLoginTotal = @()

        foreach ($user in $badLogins) {
            $matchCount = ($failedLogins | Where-Object { $_.User -like "*\$user" }).Count
            
            
            if($matchCount -gt 9){
                $badLoginTotal += [PSCustomObject]@{
                                                   "Account" = "$user";
                                                   "Password Fails over the past $days days" = "$matchCount"
                                                   }           
            
                                         }
            else { continue }
        
        if ($badLoginTotal.Count -gt 0) { $badLoginTotal | Format-Table -AutoSize }
        else { Write-Host "No accounts with more than 9 failed login attempts found."}
    }
}