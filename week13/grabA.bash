#!/bin/bash

link="http://10.0.17.18/a.html"

# Fetch and convert to valid XML
fullPage=$(curl -sL "$link")

# Extract all rows from both tables
toolOutput1=$(echo "$fullPage" | \
    xmlstarlet sel -t -m "//table[@id='temp']/tr[td]"  -v "td[1]" -o "|" -v "td[2]" -n)


toolOutput2=$(echo "$fullPage" | \
    xmlstarlet sel -t -m "//table[@id='press']/tr[td]" -v "td[1]" -o "|" -v "td[2]" -n)

out=$(paste -d "|" <(echo "$toolOutput1") <(echo "$toolOutput2") | \
	awk -F"|" '{ print $1 " | " $3 " | " $2 }')

echo "$out"

