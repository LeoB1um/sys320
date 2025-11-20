#!/bin/bash
log=/home/champuser/Desktop/sys320/week12/fileaccesslog.txt
email=/home/champuser/Desktop/sys320/week12/emailform.txt

/usr/bin/echo "File was accessed $(/usr/bin/date)" >> "$log"

/usr/bin/echo "To: leo.blum@mymail.champlain.edu" > "$email"
/usr/bin/echo "Subject: Access" >> "$email"
/usr/bin/cat "$log" >> "$email"

/usr/bin/cat "$email" | /usr/sbin/ssmtp leo.blum@mymail.champlain.edu

