#!bin/bash
i=1;
max=0;
hasharray=[];
longId=0;
shortId=0;
re="^[+-]?[0-9]+([.][0-9]+)?$"
echo "Gradim indeksno tabelo"
while read -r line ; do
	if [ $(($i%2)) -eq 0 ]; then
		shortId=$(echo $line | grep -E -o "[0-9]*");
		hasharray[$shortId]=$longId;
		if [ $shortId -gt $max ]; then
			max=$shortId
		fi
	else
		longId=$(echo $line | grep -o -E "id='-[0-9]*'" | grep -E -o "\-[0-9]*");
	fi
	i=`expr $i + 1`;
done <<<$(grep -B 1 "idx" ../osm/FERIV2.osm | grep -v "\--")
echo "Gradim seznam sosednosti"

j=1;
grep -B 3 "<tag k='location' v='path' />" ../osm/FERIV2.osm | grep -v "<tag k='location' v='path' />" | grep -v "\--" | grep -v -E "<tag.*" | while read -r line ; do
	id=$(echo $line | grep -o "'.*'" | sed -E "s/'//g");

	
	for (( k = 0; k <= $max; k++ )) 
	do 
		if [[ "${hasharray[$k]}" =~ $re ]] && [[ $id -eq ${hasharray[$k]} ]]; then
			printf -- "$k " >> vmesna1.txt 
			
			if [ $(($j%2)) -eq 0 ]; then
				echo -e "" >> vmesna1.txt
			fi
	
			break;
		fi
	done

	
	j=`expr $j + 1`;
done















