. (Join-Path $PSScriptRoot "functions.ps1")

$prompt = "Select option: `n1 - Shows different methods of SQL injection `n2 - Shows full log file `n3 - Filters logs by those that show signs of SQL injection `n"
$prompt += "4 - Exit `n"

$operation = $true

While($operation){
    
    Write-Host $prompt | Out-String

    $choice = Read-Host

    if ($choice -eq 4) {
        Write-Host "Till next time."
        exit
        $operation = $false
        }

    elseif($choice -eq 1) {getPage | Format-Table}

    elseif($choice -eq 2) {getApacheLogs | Format-Table}

    elseif($choice -eq 3) {sqlDetection | Format-Table}

    else { Write-Host "Not a valid input `n"
           continue }
}

