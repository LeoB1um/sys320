. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs1.ps1)

#checks if user is running file as administrator, if not program errors out.
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "This script must be run as Administrator."
    exit
}


$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$prompt += "9 - List Risk Users `n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    # Gets enabled users
    elseif($choice -eq 1){
        clear
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    } # close 1

    # Gets disabled users
    elseif($choice -eq 2){
        clear
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    } # close 2
    
    # Create a user
    elseif($choice -eq 3){ 
        clear

        while ($true) {
            $name = Read-Host -Prompt "Please enter the username for the new user (type 'exit' return to menu)"
            $doesUserExsist = checkUser($name)
                                   
            if ($doesUserExsist -eq "false") { break } 
                                   
            else { Write-Host "Please choose a new username"
                Continue }
                 
            } #end of username whileloop       

        if ($name -eq "exit") { continue }

        While ($true) {
         $password = Read-Host -Prompt "Please enter the password for the new user" 

        <#
            While ($true) {
                           $password = Read-Host -MaskInput -Prompt "Please enter the password for the new user" 
                           $password2 = Read-Host -MaskInput -Prompt "Please enter the password again" 

                           if ($password -eq $password2) { return $password } 
                           else { Write-Host "Passwords did not match, try again" 
                                  continue }
                                  }
                                  #> #Not powershell 7.1+ ;-;

        $passwordcheck = checkPassword($password)

        if ($passwordcheck -eq "True") { break }

        else {continue}
        }


        <# TODO: Create a function called checkUser in Users that: 
        #              - Checks if user a exists. 
        #              - If user exists, returns true, else returns false
        #> #Done

        <# TODO: Check the given username with your new function.
        #              - If false is returned, continue with the rest of the function
        #              - If true is returned, do not continue and inform the user
        #> #Done

        <#
        # TODO: Create a function called checkPassword in String-Helper that:
        #              - Checks if the given string is at least 6 characters
        #              - Checks if the given string contains at least 1 special character, 1 number, and 1 letter
        #              - If the given string does not satisfy conditions, returns false
        #              - If the given string satisfy the conditions, returns true
        #> #Done
        
        <#
        # TODO: Check the given password with your new function. 
        #              - If false is returned, do not continue and inform the user
        #              - If true is returned, continue with the rest of the function
        #> #Done?

        $passwordSecure = ConvertTo-SecureString -String $password -AsPlainText -Force
        Remove-Variable password
        [System.GC]::Collect()
        
        clear

        createAUser $name $passwordSecure

        Write-Host "User: $name is created." | Out-String
    } # close 3
    
    # Remove a user
    elseif($choice -eq 4){
         clear

        <#
        # TODO: Check the given username with the checkUser function.
        #> # Done

        While($true){
            $name = Read-Host -Prompt "Please enter the username for the user to be removed(type 'exit' to cancel)"
            
            if($name -eq 'exit') { break }

            $cu = checkUser($name)
            
            if($cu -eq "True"){ 
                             removeAUser $name
                             Write-Host "User: $name Removed." | Out-String
                             break 
                             }
            else { Write-Host "Not a user, try again."
                   continue }
              }
        if($name -eq "exit"){continue}
    } # close 4
        
    # Enable a user
    elseif($choice -eq 5){
        clear

        While ($true){
            $name = Read-Host -Prompt "Please enter the username for the user to be enabled(type 'exit' to cancel)"

            <#
            # TODO: Check the given username with the checkUser function. #>#Done
            if($name -eq 'exit') { break }

            $cu = checkUser($name)
            
            if($cu -eq "True"){ 
                             enableAUser $name
                             Write-Host "User: $name Enabled." | Out-String
                             break 
                             }
            else { Write-Host "Not a user, try again."
                   continue }
              }
        if($name -eq "exit"){continue}
           
         } # close 5
         
    # Disable a user
    elseif($choice -eq 6){
        clear

        While ($true){
            $name = Read-Host -Prompt "Please enter the username for the user to be disabled(type 'exit' to cancel)"

           <#
            # TODO: Check the given username with the checkUser function. #> #Done
            if($name -eq 'exit') { break }

            $cu = checkUser($name)
            
            if($cu -eq "True"){ 
                             disableAUser $name
                             Write-Host "User: $name Disabled." | Out-String
                             break 
                             }
            else { Write-Host "Not a user, try again."
                   continue }
              }
        if($name -eq "exit"){continue}
                        
    } # close 6

    # Gets Log-in logs
    elseif($choice -eq 7){
        clear
       

        While ($true){
            $name = Read-Host -Prompt "Please enter the username for the user logs(type 'exit' to cancel)"
            <#
            # TODO: Check the given username with the checkUser function. #> #Done
            if($name -eq 'exit') { break }

            $cu = checkUser($name)
            
            if($cu -eq "True"){ break }

            else { Write-Host "Not a user, try again."
                   continue }
              }
        if($name -eq "exit"){continue}
        
        $days = Read-Host "Please Enter the amount of days in the past you would like to see logs for"

        $userLogins = getLogInAndOffs($days)
        $userLogins
        
        <# TODO: Change the above line in a way that, the days 90 should be taken from the user
        #> #Done

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Where-Object { $_.Event -ilike "Logon" }| Format-Table | Out-String)
    } # close 7

    #gets Failed log-in logs
    elseif($choice -eq 8){
        clear

        While ($true){
            $name = Read-Host -Prompt "Please enter the username for the user's failed login logs(type 'exit' to cancel)"
            <#
            # TODO: Check the given username with the checkUser function. #> #Done
            if($name -eq 'exit') { break }

            $cu = checkUser($name)
            
            if($cu -eq "True"){ break }

            else { Write-Host "Not a user, try again."
                   continue }
              }
        if($name -eq "exit"){continue}

        $days = Read-Host "Please Enter the amount of days in the past you would like to see logs for"

        $userLogins = getFailedLogins $days
        <# TODO: Change the above line in a way that, the days 90 should be taken from the user
        #> #Done

        Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
    } # close 8

    <#
    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option 
    #> # Done 
    elseif($choice -eq 9){
    clear

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
        else { Write-Host "No accounts with more than 9 failed login attempts found." 

    
        }#end of forloop
}    
    } # close 9
    
    <#
    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    #> # Done
    else{
         clear
         Write-Host "Out of scope number, try again" 
         Continue
         }

}




