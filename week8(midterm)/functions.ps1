#scrapes webpage
function getPage() {
    $table = @()
    $scrapedPage = Invoke-WebRequest -Timeout 10 http://localhost/IOC.html
    
    $td = $scrapedPage.ParsedHtml.getElementsByTagName("td") | Select-Object -ExpandProperty innertext
    $td[1]

   
    for($i=0; $i -lt $td.Count; $i+=2){
        
        
        $table += [PSCustomObject]@{"Pattern" = $td[$i];
                                    "Explanation" = $td[$i+1]}
                  
           }
     return $table
}

# gets the apache logs given for this assignment
function getApacheLogs(){
$logsNotFormatted = Get-Content C:\xampp\apache\logs\access1.log

$tableRecords = @()

for($i = 0; $i -lt $logsNotFormatted.Count; $i++){

#split string into words
$words = $logsNotFormatted[$i].Split(" ");

#Write-Host "words: $words"
 $tableRecords += [PSCustomObject]@{ "IP" = $words[0];
                                     "Time" = $words[3].Trim('[');
                                     "Method" = $words[5].Trim('"');
                                     "Page" = $words[6];
                                     "Protocol" = $words[7];
                                     "Response" = $words[8];
                                     "Referrer" = $words[10];
                                     "Client" = $words[11..($words.Length -1)]; 
                                     }
} # end of for loop

return $tableRecords 


}

# takes the result of getApacheLogs and filters them through the properties section of getPage
# filtering it for only signs of sql injection
function sqlDetection(){
$getTable = getPage
$getApacheLog = getApacheLogs
$injectionLogs = @()

# Patterns
for($i=0; $i -lt $getTable.Pattern.Count; $i++){
    
    # Checking each unique pattern to every log
    for($i2=0; $i2 -lt $getApacheLog.Page.Count; $i2++){
           
        if($getApacheLog.Page[$i2] -ilike "*$($getTable.Pattern[$i])*"){
            $injectionLogs += $getApacheLog[$i2]}
        else{continue}
        }# end of 2nd forloop
           
    }# end of 1st forloop
return $injectionLogs | Format-Table
}

# Test function
#Write-Host "Checking pattern: $($getTable[$i].Pattern) against page: $($getApacheLog[$i2].Page)"