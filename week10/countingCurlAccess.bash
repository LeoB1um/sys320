#!/bin/bash

file="/var/log/apache2/access.log"

curlCount=$(awk '{print $1,$12}' ${file} | grep "curl/7.81.0" | uniq -c)

echo "${curlCount}"
