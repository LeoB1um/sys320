function getIPs($page, $code, $browser) {
 

# Gets logs that match the three requirements.
$notfounds = Get-Content "C:\xampp\apache\logs\access.log" | Where-Object { $_ -match " /$page " -and $_ -match " $code " -and $_ -match " $browser/" }


#defines a regex for IP addresses
$regex = [regex] "[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"


#error handling
 if (-not $notfounds) {
    Write-Warning "no matching line in log file"
    return
}
# Gets $notofunds records that match to the regex
$ipsUnorganiszed = $regex.Matches($notfounds -join "`n")

$ipsUnorganiszed

#Gets ips as pscustomobject 
$ips = @()
for($i=0; $i -lt $ipsUnorganiszed.Count; $i++){
  $ips += [pscustomobject]@{ "IP" = $ipsUnorganiszed[$i].Value; }
}

# Counts ips from number 8


 $ipsoften = $ips | Where-Object { $_.IP -ilike "10.*" } 
 $counts = $ipsoften | Group-Object IP
 $counts | Select-Object Count, Name


return $counts
}