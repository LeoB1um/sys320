#!/bin/bash

file="/var/log/apache2/access.log"

pageCount=$(awk '{print $7}' "${file}" | sort | uniq -c | sort -nr)

echo "${pageCount}"

