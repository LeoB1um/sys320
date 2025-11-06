#!/bin/bash

file="/var/log/apache2/access.log"

result=$(cat "$file" | grep "Firefox")

echo "$result"
