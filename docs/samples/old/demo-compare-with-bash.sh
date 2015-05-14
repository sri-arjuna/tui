#!/bin/bash
clear
echo
echo "Regular shell output"
echo "Very great."
read -p "Make input" input
echo "$input is what you entered"

echo
echo

tui-header "Compare regular shell vs TUI"
tui-title "Cool Cat & the gang"
tui-echo "Also regular shell output"
tui-echo "It is" \
	"great"
input=$(tui-read "Make your input")
tui-echo "Your input was:" \
	"$input"