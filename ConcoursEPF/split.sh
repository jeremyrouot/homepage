#!/bin/bash

# Split Video Script
# Usage: script_name file_name split-point
# Example: split_video_script bugs_bunny.mp4 31:23

# Instructions:     
# 1. Type the name of your script (if it is already added to ~/bin and marked as executable). 
# 2. Type the file name including path to it if necessary. 
# 3. Type the time where you want to split the video. It goes in minutes:seconds

# Get length in seconds
length=$(echo "$2" | awk -F: '{print ($1 * 60) + $2}')

# Get filename without extension
fname="${1%.*}"

# First half
ffmpeg -i "${fname}.mp4" -c copy -t "$length" "${fname}1.mp4"

# Second half
ffmpeg -i "${fname}.mp4" -c copy -ss "$length" "${fname}2.mp4"
