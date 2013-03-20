

sequence=$(cat $1 | sed 's/\t/\n/g')
input_file=$2
cmd="awk '{print "

for colname in $sequence
do
	# echo $colname
	position=$(head -n1 $input_file | grep -P -o ".*${colname}" | grep -P -o "\t" | wc -l)
	position=$(($position + 1))

	cmd=$cmd\$$position"\"\t\""
	# echo $position
done


cmd=$cmd"}' $input_file"
cmd=$(echo $cmd | sed 's/"\\t"}/}/g')

echo $cmd > run.sh
sh run.sh
rm run.sh
