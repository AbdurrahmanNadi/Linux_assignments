#!/bin/bash
if [[ ! -f "sdel.sh" ]]; then
	echo "script sdel.sh doesn't exist" >& 2
	exit 1
fi
args="$@"
while  :; do
case $1 in 
	-u|--user) user=$2
		id -u "$user" > /dev/null
		if [[ ! $? -eq 0 ]]; then 
			echo Specified user $user doesn\'t exist >&2
			exit 1
		fi
		;;
	-p|--path) path=$2
		if [[ ! -d $path ]]; then
			echo Path $path doesn\'t exist >&2
			exit 1
		fi
		;;
	*)
		break
esac
shift 2
done
if [[ $user == "" ]]; then
	user=$SUDO_USER
fi
if [[ $path == "" ]]; then
	path='/usr/bin'
fi
if [[ $user == root ]]; then
	home='/root'
else
	home="/home/$user"
fi
read -p "Do you want to install sdel.sh in $path (Y/N)?" res
if [[ ! "$res" =~ ^[yY] ]]; then
	exit 0
fi
version=$(./sdel.sh -v)
if [[ ! $(grep sdel $home/.bashrc) =~ ^alias' 'sdel=$path/sdel.sh$ ]]; then
	echo "alias sdel=$path/sdel.sh" >> $home/.bashrc
fi

if [[ ! "$(crontab -u $user -l)" =~ ^0' '0' '*' '*' '*' 'sdel$ ]]; then
	echo "0 0 * * * sdel" > $home/tmp
       	crontab -u $user $home/tmp
	rm $home/tmp
fi
if [[ -f "$path/sdel.sh" ]] && [[ $($path/sdel.sh -v) == "$version" ]]; then	
	echo Safe Delete is already the latest version
	exit 0
fi
cp sdel.sh $path
echo Safe Delete Successfully Installed
source ~/.bashrc
exit 0
