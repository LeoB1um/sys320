#!/bin/bash
#fileaccesslog.txt
#emailform.txt

echo "File was accessed $(date)" >> fileaccesslog.txt

echo "To: leo.blum@mymail.champlain.edu" > emailform.txt
echo "Subject: Access" >> emailform.txt
/bin/cat fileaccesslog.txt >> emailform.txt

/bin/cat emailform.txt | ssmtp leo.blum@mymail.champlain.edu

