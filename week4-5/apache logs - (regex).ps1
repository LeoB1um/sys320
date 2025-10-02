clear
#gets only logs with 404, saves to $notfounds
$notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404 '

#defines a regex for IP addresses
$regex = [regex] "[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}"

# Gets $notofunds records that match to the regex
$ipsUnorganiszed = $regex.Matches($notfounds)

#$ipsUnorganiszed

#Gets ips as pscustomobject 
$ips = @()
for($i=0; $i -lt $ipsUnorganiszed.Count; $i++){
   $ips += [pscustomobject]@{ "IP" = $ipsUnorganiszed[$i].Value; }
 }

# Counts ips from number 8
 
 $ipsoften = $ips | Where-Object { $_.IP -ilike "10.*" } 
 $counts = $ipsoften | Group-Object IP
 $counts | Select-Object Count, Name