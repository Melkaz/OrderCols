

sequence=$(cat $1 | sed 's/\t/\n/g')
input_file=$2
cmd="awk '{print "

for colname in $sequence
do
	# echo $colname

	# We grep on the header where are the column names
	# First grep is finding a match with the current element of the list and all the characters before
	# Second grep is counting tabulations if present or the own column name (if in first position)
	position=$(head -n1 $input_file | grep -P -w -o ".*${colname}" | grep -P -o -w "${colname}|\t" | wc -l)

	# If we have a zero, it means that the column name in the list does not exist in the input file
	if [ "$position" == 0 ]
	then
		echo "Column name : "$colname" not found !">&2
		continue
	fi

	# echo $position

	cmd=$cmd\$$position"\"\t\""
	# echo $position
done


cmd=$cmd"}' $input_file"
cmd=$(echo $cmd | sed 's/"\\t"}/}/g')

echo $cmd > tmp.sh
sh tmp.sh
# rm tmp.sh
