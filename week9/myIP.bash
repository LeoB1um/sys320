#!bin/bash

# EXPLANATION:
# grep grabs all strings starting with 'inet'
# grep -v shows all strings that DON'T match with your keystring (inversion)
# awk '{print $2}' prints the 2nd column in all strings sent.
# cut: -d sets delimiter as whats in the quotes. -f1 prints the first field. (-f2 would print the 2nd)

ip addr | grep "inet " \
       	| grep -v "127.0.0.1" \
       	| awk '{print $2}' \
	| cut -d'/' -f1
