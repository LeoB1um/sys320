#!/bin/bash

link="http://10.0.17.6/IOC.html"

fullPage=$(curl -sL "$link")

toolOutput1=$(echo "$fullPage" | \
	xmlstarlet sel -t -m "//table/tr[td]" -v "td[1]" -n) 

echo "$toolOutput1"  > IOC.txt
