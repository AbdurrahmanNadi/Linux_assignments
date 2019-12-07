#!/bin/bash
###############################################
#Bash Script Assignment                       #
#Abdelrahman Nadi Taha                        #
#Mechatronics                                 #
#This script supports only files in .gz format#
###############################################

if [ ! -d ~/TRASH ]; then
	mkdir ~/TRASH
else
	for file in $(ls -f ~/TRASH/*.tar.gz)
	do
		d1=$(date -r $file +%s)
		d2=$(date +%s)
		if [ $(( (d2 - d1) / (3600 * 24) )) -ge 2 ]; then
			rm -v $file
		fi
	done
fi
for file in "$@"
do
	if [ -f "$file" ]; then
		if [ ! $(file --mime-type -b "$file") == "application/gzip" ]; then
			not_compressed_files="$not_compressed_files $file"
		else
			compressed_files="$compressed_files $file"
		fi
	elif [ -d "$file" ]; then
		dir="$dir $file"
	else
		echo "$file is not a regular file or directory" >&2
		exit 1
	fi
done
d="$(date +%x)_$(date +%T)"
d=${d//\//_}
d=${d//:/_}
to_be_deleted="$not_compressed_files $compressed_files $dir"
to_be_archived="$not_compressed_files $dir"
if [[ "$not_compressed_files" =~  ^\ */?[_[:alnum:]]+ ]]; then
	tar czf ~/TRASH/archive_$d.tar.gz $to_be_archived
fi
if [[ "$compressed_files" =~ ^\ */?[_[:alnum:]]+ ]];then
       mv $compressed_files ~/TRASH
fi

if [[ "$to_be_deleted" =~ ^\ */?[_[:alnum:]]+ ]];then
	rm -r $to_be_deleted
fi
