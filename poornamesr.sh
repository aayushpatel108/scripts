#! /bin/sh
R=0
if [ $# -gt 2 ]
then
    echo 'Too many arguments'
    exit 1
fi
case $# in
    0) D='.';;
    1) if [ $1 = '-r' ]
       then
	   D='.'
	   R=1
       else
	   D=$1
	   R=0
       fi;;
    2) if [ $1 = '-r' ]
       then
	   R=1
       else
	   echo 'Invalid argument'
	   exit 1
       fi
       D=$2;;
    esac
if [ ! -r $D ]
then
    echo "Directory not readable" >&2
fi
if [ ${D:0:1} == "-" ]
then
    echo "Invalid Directory"
    exit 1
fi
if [ ! -d $D ]
then
    echo "Directory does not exist"
    exit 1
fi
if [ $R = 1 ]
then
find -H $D \( -type d -printf "%p/\n" , -type f -print \) | sort -f | uniq -iD
find -H $D \( -type d -printf "%p/\n" , -type f -print \) | sort -f | uniq -iu | grep -E "([^\/]{15,}[^\/]*\/?$)|\/*[^a-zA-Z0-9\._\/-][^\/]*\/?$|\/-[^\/]*\/?$|\/\.[^.]+[^\/]*\/?$|\/\.\.[^\/]+\/?$"
else
find $D -maxdepth 1 \( -type d -printf "%p/\n" , -type f -print \) | sort -f | uniq -iD
find $D -maxdepth 1 \( -type d -printf "%p/\n" , -type f -print \) | sort -f | uniq -iu | grep -E "$1\/?[^\/]{15,}\/?|$1\/?-|$1\/?\.{1,2}[^.]+|\/*[^a-zA-Z0-9\._\/-][^\/]*$"
fi
