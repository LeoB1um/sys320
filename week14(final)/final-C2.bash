#!/bin/bash

cut -d ' ' -f1,4,7 "$1" | tr -d '[' | sort -n | grep -f $2
