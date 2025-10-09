. (Join-Path $PSScriptRoot Event-Logs1.ps1)

#checks if user is running file as administrator, if not program errors out.
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    exit
}


$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Displays last 10 apache logs`n"
$Prompt += "2 - Gets the 10 last failed logins`n"
$Prompt += "3 - Displays risky users`n"
$Prompt += "4 - Starts/stops chrome and navigates to champlain.edu`n"
$Prompt += "5 - Exit "




$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye!"
        exit
        $operation = $false
        }

     elseif($choice -eq 1){
        . "C:\Users\champuser\sys320\week4-5\apache logs - (-tail 10).ps1"
        }


     elseif($choice -eq 2){
        $days = Read-Host "Please select a number of days in the past to check logs"
        getFailedLogins($days) | Select-Object -Last 10 | Format-Table
        }


     elseif($choice -eq 3){
    
        $badLogins = Get-LocalUser | Select-Object -ExpandProperty Name
        
        
        $days = Read-Host "Please Enter the amount of days in the past you would like to see logs for"
        

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
        else { Write-Host "No accounts with more than 9 failed login attempts found." }
           }
            
        }         

     elseif($choice -eq 4){
        . "C:\Users\champuser\sys320\week2\Process Management (part 4).ps1"
        }
        
     else { Write-Host "Bad Input"
     continue}

}