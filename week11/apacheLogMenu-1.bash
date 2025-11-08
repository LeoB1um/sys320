#! /bin/bash

logFile="/var/log/apache2/access.log"

function displayAllLogs(){
	cat "$logFile"
}

function displayOnlyIPs(){
        cat "$logFile" | cut -d ' ' -f1 | sort -n | uniq -c | sort -nr
	echo -e

}

# like displayOnlyIPs - but only pages
function displayOnlyPages(){
	cat "$logFile" | cut -d ' ' -f7 | sort -n | uniq -c | sort -nr
	echo -e

}

function histogram(){

	local visitsPerDay=$(cat "$logFile" | cut -d " " -f 4,1 | tr -d '['  | sort \
                              | uniq)
	# This is for debugging, print here to see what it does to continue:
	# echo "$visitsPerDay"

        :> newtemp.txt  # what :> does is in slides
	echo "$visitsPerDay" | while read -r line;
	do
		local withoutHours=$(echo "$line" | cut -d " " -f 2 \
                                     | cut -d ":" -f 1)
		local IP=$(echo "$line" | cut -d  " " -f 1)
          
		local newLine="$IP $withoutHours"
		echo "$IP $withoutHours" >> newtemp.txt
	done 
	cat "newtemp.txt" | sort -n | uniq -c
}

# function: frequentVisitors: 
# Only display the IPs that have more than 10 visits
# You can either call histogram and process the results,
# Or make a whole new function. Do not forget to separate the 
# number and check with a condition whether it is greater than 10
# the output should be almost identical to histogram
# only with daily number of visits that are greater than 10 
function frequentVisitor(){
	displayOnlyIPs | awk '$1 >= 10'

}

# function: suspiciousVisitors
# Manually make a list of indicators of attack (ioc.txt)
# filter the records with this indicators of attack
# only display the unique count of IP addresses.  
# Hint: there are examples in slides
function suspiciousVisitors(){
	cut -d ' ' -f1,7 "${logFile}" | sort -n | uniq -c | sort -nr | grep -f IOC.txt

}

# Keep in mind that I have selected long way of doing things to 
# demonstrate loops, functions, etc. If you can do things simpler,
# it is welcomed.

while :
do
	echo "PLease select an option:"
	echo "[1] Display all Logs"
	echo "[2] Display only IPS"
	echo "[3] Display only pages visited"
	echo "[4] Histogram"
	echo "[5] Frequent visitors"
	echo "[6] Suspicious visitors"
	echo "[7] Quit"

	read userInput
	echo ""

	if [[ "$userInput" == "7" ]]; then
		echo -e "\033[1;31mGoodbye\033[0m"		
		break

	elif [[ "$userInput" == "1" ]]; then
		echo -e "\033[1;36mDisplaying all logs:\033[0m"
		displayAllLogs

	elif [[ "$userInput" == "2" ]]; then
		echo -e "\033[1;33mDisplaying only IPS:\033[0m"
		displayOnlyIPs

	# Display only pages visited
	elif [[ "$userInput" == "3" ]]; then
		echo -e "\033[1;32mDisplaying only pages visited\033[0m"
		displayOnlyPages

	elif [[ "$userInput" == "4" ]]; then
		echo -e "\033[1;35mHistogram:\033[0m"
		histogram

        # Display frequent visitors
	elif [[ "${userInput}" == "5" ]]; then
		echo -e "\033[1;34mFrequent Visitors\033[0m"
		frequentVisitor
	# Display suspicious visitors
	elif [[ "${userInput}" == "6" ]]; then
                echo -e "\033[1;37mSuspicious Visitors\033[0m"
                suspiciousVisitors

	# Display a message, if an invalid input is given
	else
		echo -e "\033[1;31mInvalid input, try again\033[0m \n"

	fi
done
