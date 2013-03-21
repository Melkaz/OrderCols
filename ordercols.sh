
if [ $# -lt 2 ] || [ $# -gt 3 ]; then
  echo "Usage: sh $0 list_colnames file"
  exit
fi

# If no separator is provided
if [ ! -n "$3" ]; then
	separator="\t"
else
	separator=$3
fi

# Sequence of column names
sequence=$(cat $1 | sed "s/$separator/\n/g")
length=$(cat $1 | sed "s/$separator/\n/g" | wc -l)

# Input file that contain matching column names
input_file=$2

# Construction of the awk command
cmd="awk 'BEGIN {FS = \""$separator\""} {print "

count=0

# For each column name
for colname in $sequence
do
	count=$(($count + 1))

	# We grep on the header where are the column names
	# First grep is finding a match with the current element of the list and all the characters before
	# Second grep is counting tabulations if present or the own column name (if in first position)
	position=$(head -n1 $input_file | grep -P -w -o ".*$colname" | grep -P -o -w "$colname|$separator" | wc -l)

	# If we have a zero, it means that the column name in the list does not exist in the input file
	if [ "$position" == 0 ]
	then
		echo "Column name : "$colname" not found !">&2
		continue
	fi

	cmd=$cmd\$$position

	# If it is not the last column name, add a separator
	if [ $count != $length ]; then
		cmd=$cmd"\"${separator}\""
	fi
done

# Finalize the awk command
cmd=$cmd"}' $input_file"

# Output in a temporary sh file, run and delete
echo $cmd > tmp.sh
sh tmp.sh
rm tmp.sh
