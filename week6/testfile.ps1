. (Join-Path $PSScriptRoot 'Users.ps1')
. (Join-Path $PSScriptRoot 'String-Helper.ps1')

<#
        while ($true) {
            $name = Read-Host -Prompt "Please enter the username for the new user"
            $doesUserExsist = checkUser($name)
            
            
            if ($doesUserExsist -eq "false") {
                break 
            
    
            } else {
                Write-Host "Please choose a new username"
                Continue
            } #end of if
            } #end of whileloop  
            #> #While Loop for username


<#
While($true) {
    $password = Read-Host "Please choose a password"
    
    $a = checkPassword($password)

    Write-Host $a

    if($a -eq "good") {
     
     break
     }

     elseif ($a -eq "bad") {
        Write-Host "Not Enough Charecters, needs 6 or more."
        }

     else {
      
        if ($a -eq "000") { 
            Write-Host "HOW?"
            continue
            }
    
        elseif ($a -eq "001") {
            Write-Host "Missing: Number, Regular Character" 
            continue
            }

        elseif ($a -eq "010") {
            Write-Host "Missing: Number, Special Character"
            continue
            }

        elseif ($a -eq "011") {
            Write-Host "Missing: Number"
            continue
            }

        elseif ($a -eq "100") {
            Write-Host "Missing: Regular Character, Special Character"
            continue
            }

        elseif ($a -eq "101") {
            Write-Host "Missing: Regular Character"
            continue
            }

        elseif ($a -eq "110") {
            Write-Host "Missing: Special Character"
            }

        elseif ($a -eq "111") {
            break 
            }               
     }
}
    #> #Checks password for reqirements (Old) 


<#
While ($true){
    $password = Read-Host "paworplz"    
    
    $passwordcheck = checkPassword($password)

    if ($passwordcheck -eq "True") { break }

    else {continue}
    }
#> #ask function to check password (current in use)