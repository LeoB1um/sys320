function SendAlertEmail($Body) {
$From = "<Your Email Here>"
$To = "<Your Email Here>"
$Subject = "Suspicious Activity"

$Password = "<Google App Password>" | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" -port 587 -UseSsl -Credential $Credential
}