# Menu
function configMenu() {


$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Show Configuration `n"
$Prompt += "2 - Change Configuration `n"
$Prompt += "3 - Exit"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 
    

    if ($choice -eq 3) {
        Write-Host "Goodbye"
        exit
        $operation = $false
        }


    elseif ($choice -eq 1) {
        $getConfig = getConfig
        $getConfig | Format-Table
        }

    elseif ($choice -eq 2) {
        changeConfig
        }


    else { Write-Host "Bad Input"
           continue 
          }

    }
return
}



# Gets the current configuration file
function getConfig() {
        
        $array = @()
        $arrayTxt = @(Get-Content "$PSScriptRoot\configuration.txt")


        $array += [PSCustomObject]@{
                                    "Days" = $arrayTxt[0];
                                    "Execution Time" = $arrayTxt[1];
                                    }
            
        return $array
        }



# Edits the config file 
function changeConfig() {
        $regex = '^(0?[1-9]|1[0-2]):[0-5][0-9]\s(?i)(AM|PM)$'
        $configfile = "$PSScriptRoot\configuration.txt"

        #validates days as a number
        While($true){
            $days = Read-Host "Enter the number of days for which logs will be obtained"    
                                 
            if($days -match "^\d+$") { break }
            elseif ($days -match '^-\d+$') { Write-Host "Negative numbers are not accepted."
                                             Continue }            
            else { Write-Host "Not A Number"
                   Continue }
            }
            
        #validates timestamp
        While($true){
            $time = Read-Host "Enter the time you want this to be executed(format: hh:mm AM/PM)"

            if($time -match $regex) { break }
            else { Write-Host "invalid time signature"
                   Continue }
            }
       
        #changes the config file     
        $content = Get-Content $configfile

        $content[0] = $days
        $content[1] = $time

        Set-Content $configfile $content

        Write-Host "Config Changed"
        Return
}