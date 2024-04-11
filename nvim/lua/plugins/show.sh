#!/bin/bash

file_path=$1

frames=$(cat "$file_path" | awk -v RS= '{gsub(/\n/, "\\n"); print}')

clear_terminal() {
	printf "\033c"
}

while true; do
	for frame in $frames; do
		clear_terminal
		echo "$frame"
		sleep 0.05
	done
done
