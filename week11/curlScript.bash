#!/bin/bash

while read -r line; do
	for i in {1..20}; do
		curl "10.0.17.18/${line}"
		curl "10.0.17.18/index.html?=${line}"
	done
done < IOC.txt
