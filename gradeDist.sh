#!/bin/bash

markingscript=$1
submissionfiles=$2

Amark=0
Bmark=0
Cmark=0
Dmark=0
Fmark=0

if [[ "$#" > 2 || "$#" < 2 ]];
then
	echo error: gradeDist.sh needs exactly two arguments >|errorMessage.txt
	exit 1

elif [ ! -f "$markingscript" ];
then
	echo error: $markingscript is not an existing, executable file >|errorMessage.txt
	cat errorMessage.txt
	exit 2

elif [ ! -d "$submissionfiles" ];
then
	echo error: $submissionfiles does not exist or is not a directory >|errorMessage.txt
	cat errorMessage.txt
	exit 3

else
	for fileName in $(ls $submissionfiles);
	do

		./$markingscript $submissionfiles/$fileName >| cmd
		grade=$(head -n 1 cmd)
			if [[ $grade == "A" ]];
			then
				Amark=$((Amark+1))

			elif [ $grade == "B" ];
			then
				Bmark=$((Bmark+1))

			elif [ $grade == "C" ];
			then
				Cmark=$((Cmark+1))

			elif [ $grade == "D" ];
			then
				Dmark=$((Dmark+1))

			elif [ $grade == "F" ];
			then
				Fmark=$((Fmark+1))

			fi

	done

fi

echo A: $Amark
echo B: $Bmark
echo C: $Cmark
echo D: $Dmark
echo F: $Fmark

exit 0
