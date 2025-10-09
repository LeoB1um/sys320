

<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for enabled users
****************************** #>
function getEnabledUsers(){

  $enabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "True" } | Select-Object Name, SID
  return $enabledUsers

}



<# ******************************
# Create a function that returns a list of NAMEs AND SIDs only for not enabled users
****************************** #>
function getNotEnabledUsers(){

  $notEnabledUsers = Get-LocalUser | Where-Object { $_.Enabled -ilike "False" } | Select-Object Name, SID
  return $notEnabledUsers

}




<# ******************************
# Create a function that adds a user
****************************** #>
function createAUser($name, $password){

   $params = @{
     Name = $name
     Password = $password
   }

   $newUser = New-LocalUser @params 


   # ***** Policies ******

   # User should be forced to change password
   Set-LocalUser $newUser -PasswordNeverExpires $false

   # First time created users should be disabled
   Disable-LocalUser $newUser

}



function removeAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ieq $name }
   
   if ($userToBeDeleted) { Remove-LocalUser $userToBeDeleted}
   else { Write-Host "User '$name' not found."}
}



function disableAUser($name){
   
   $userToBeDeleted = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Disable-LocalUser $userToBeDeleted
   
}


function enableAUser($name){
   
   $userToBeEnabled = Get-LocalUser | Where-Object { $_.name -ilike $name }
   Enable-LocalUser $userToBeEnabled
   
}

#Function to check if a name already exsists on file.
function checkUser($name) {

    $match = Get-LocalUser | Where-Object { $_.name -ilike $name }
    
    if (-not $match) {
        return "false"
    
    } else {
        return "true"
    }
}

<#
Checks password to see if it matches the following.
    - has >=6 charecters 
    - checks if string has 1 special charecter, 1 number, and 1 letter
    - if any condition is not met return false.
#>
function checkPassword ($password){
    $binarycheck = @()
    
    $passwordCount = $password.Length
    
    # code to do checks for size and characters.
    if ($passwordCount -gt 5) {
        if ($password -match "[0-9]") { $binarycheck += "1" }
        else { $binarycheck += "0" }

        if ($password -match "[a-zA-Z]") { $binarycheck += "1" }
        else { $binarycheck += "0" }

        if ($password -match "[\p{P}\p{S}]") { $binarycheck += "1" }
        else { $binarycheck += "0" }

        $a = $binarycheck -join ""
        } 
    
    else { $a = "bad" }
     

    if ($a -eq "bad") {
        Write-Host -ForegroundColor Red -BackgroundColor Black "!!!BAD PASSWORD!!! `nNot Enough Characters, needs 6 or more."
        }

     else {
      
        if ($a -eq "000") { 
            Write-Host "HOW?"
            return "False"
            }
    
        elseif ($a -eq "001") {
            Write-Host -ForegroundColor Red -BackgroundColor Black "!!!BAD PASSWORD!!! `nMissing: Number, Regular Character" 
            return "False"
            }

        elseif ($a -eq "010") {
            Write-Host -ForegroundColor Red -BackgroundColor Black "!!!BAD PASSWORD!!! `nMissing: Number, Special Character"
            return "False"
            }

        elseif ($a -eq "011") {
            Write-Host -ForegroundColor Red -BackgroundColor Black "!!!BAD PASSWORD!!! `nMissing: Number"
            return "False"
            }

        elseif ($a -eq "100") {
            Write-Host -ForegroundColor Red -BackgroundColor Black "!!!BAD PASSWORD!!! `nMissing: Regular Character, Special Character"
            return "False"
            }

        elseif ($a -eq "101") {
            Write-Host -ForegroundColor Red -BackgroundColor Black "!!!BAD PASSWORD!!! `nMissing: Regular Character"
            return "False"
            }

        elseif ($a -eq "110") {
            Write-Host -ForegroundColor Red -BackgroundColor Black "!!!BAD PASSWORD!!! `nMissing: Special Character"
            return "False"
            }

        elseif ($a -eq "111") {
            return "True" 
            }               
     }
} #end of function

    