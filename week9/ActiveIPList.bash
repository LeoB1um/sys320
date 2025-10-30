#!/bin/bash

# List all ips in the given network prefix
# /24 only 

#Usage: bash IPList.bash 10.0.17
[ $# -ne 1 ] && echo "Usage: $0 <Prefix>" && exit 1

# Prefix is the first input taken
prefix=$1

# Verify input length
[ ${#prefix} -le 5 ] && \
	printf "Prefix length is too short\nPrefix example: 10.0.17\n" && \
	exit 1

for i in {0..255}
do
	ping -c 1 ${prefix}.${i} | grep "bytes from" \
		| awk '{print $4}' | cut -d':' -f1
	
done
