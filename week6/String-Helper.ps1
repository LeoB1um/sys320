<# String-Helper
*************************************************************
   This script contains functions that help with String/Match/Search
   operations. 
************************************************************* 
#>


<# ******************************************************
   Functions: Get Matching Lines
   Input:   1) Text with multiple lines  
            2) Keyword
   Output:  1) Array of lines that contain the keyword
********************************************************* #>
function getMatchingLines($contents, $lookline){

$allines = @()
$splitted =  $contents.split([Environment]::NewLine)

for($j=0; $j -lt $splitted.Count; $j++){  
 
   if($splitted[$j].Length -gt 0){  
        if($splitted[$j] -ilike $lookline){ $allines += $splitted[$j] }
   }

}

return $allines
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
