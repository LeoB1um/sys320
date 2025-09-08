#question 1
(Get-NetIPAddress -AddressFamily IPv4 | 
Where-Object { $_.InterfaceAlias -ilike "Ethernet" }).IPAddress

#question 2
(Get-NetIPAddress -AddressFamily IPv4 | 
Where-Object { $_.InterfaceAlias -ilike "Ethernet" }).PrefixLength

#question 3 and 4
Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_Net*" } | Sort-Object

#question 5 & 6
(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet" }).ServerAddresses[0]