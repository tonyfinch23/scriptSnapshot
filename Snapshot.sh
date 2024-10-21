aws ec2 describe-volumes | grep / > output1.txt && awk '{print $7}' output1.txt > output2.txt
numbers=()
readarray -t numbers < <(cat /root/output2.txt)
for i in "${numbers[@]}"; do aws ec2 create-snapshot --volume-id "$i"; done
rm output1.txt output2.txt
