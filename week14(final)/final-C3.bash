#!/bin/bash
bash final-C2.bash access.log IOC.txt > C2logsForC3.txt

#inital formatting
echo "<html>
<head>
	<title>Access Logs with IOC indicators:</title>
	<style>
	 td {
		border: 1px solid black;
	  }
	</style>
</head>

	<body>
	Access Logs with IOC indicators:<br></br>
		<table>" > report.html

# creating the table based on the IOC filtered log file
awk -F ' ' '{ print "\t\t\t<tr>\n\t\t\t\t<td>" $1 "</td>\n\t\t\t\t<td>" $2 "</td>\n\t\t\t\t<td>" $3 "</td>\n\t\t\t</tr>" }' C2logsForC3.txt >> report.html

#html closing section 
echo  "			</table>
	</body>
</html>" >> report.html

cp report.html /var/www/html
