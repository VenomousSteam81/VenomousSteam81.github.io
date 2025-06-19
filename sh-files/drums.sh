#!/bin/bash

# A script inspired from https://www.youtube.com/watch?v=TwJdcgEClMU
# This script made by vsteam81. Credits to Deficas for this bash script idea!

# These are variables. Change these around to change different aspects of the drums.
# Variable explanations below.
# file: The file to use. replaces '/lib/linuxmint/common/mint-remove-application.py' since that is on linux mint, and I was on fedora.
# rate1, rate2, rate3, and rate4: The sample rate.
# samples1 and samples2: Amount of PCM frames to play before moving onto the next line.
# sleep1 and sleep2: The amount of time to sleep before going to the next line.

# You can customize it to your liking.
# You can add, remove, or edit these variables to create your own drums.
# Add extra aplay and sleep lines to customize as well.
# Use `aplay --help` in the terminal for more options, or look at the aplay manpage.

file=/etc/resolv.conf
rate1="2000"
rate2="10000"
rate3="2500"
rate4="8000"
samples1="200"
samples2="100"
sleep1="0.05"
sleep2="0.2"

while true; do
	aplay /dev/random -r $rate1 -s $samples1 | aplay $file -r $rate3;
	sleep $sleep1;
	aplay /dev/random -r $rate2 -s $samples2;
	aplay /dev/random -r $rate2 -s $samples2;
	aplay /dev/random -r $rate1 -s $samples2 | aplay $file -r $rate4;
	sleep $sleep2;
	aplay /dev/random -r $rate2 -s $samples2;
	aplay /dev/random -r $rate2 -s $samples2;
done
