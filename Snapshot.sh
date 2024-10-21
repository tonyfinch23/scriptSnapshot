#!/bin/bash

# Collect the IDs of all volumes and store them in a file with a new line delimiter
aws ec2 describe-volumes | grep attached > output1.txt && awk '{print $7}' output1.txt > output2.txt
# Declare an array in which we will store all IDs as separate elements
numbers=()
# Fill the array with the IDs
# The array can be printed out with 'declare -p numbers' for human inspection
readarray -t numbers < <(cat /root/output2.txt)
# For loop executes the create-snapshot command for each ID in the array
for i in "${numbers[@]}"; do aws ec2 create-snapshot --volume-id "$i"; done
# Housekeeping - remove the files we used for storing the data
rm output1.txt output2.txt
