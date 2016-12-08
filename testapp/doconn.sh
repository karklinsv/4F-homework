#!/bin/env bash
# this script will connect to application running on HOST:PORT
# and produce access and error lines in log file depending on options chosen

# configuration

HOST="127.0.0.1"
PORT="1337"
PF="./ping.out"
CF="./conn.out"
EF="./err.out"
NOT="0"
OPT="--fail --silent --show-error"

# functions

function how {
echo "
  This bash script will connect to application running on configured host and port
  and based on chosen options perform conenctions.
  Dependencies: netcat (nc) and curl should be installed and accessible from PATH
  
  If executed without options, will executes 10000 error and successfull connections

  After execution with option -E -P -C You should provide number, how many connections You want.
	0 - Infinite connections every 0.3 seconds
	1-.. Connections count

  Options:
	-E - will generate error messages in applciation log files by sending incorrect request (two logfiles will be updated: access.log and err.log)
	-P - will ping server, request will be seen only in ping.log
	-C - will generate correct GET request to application
"
}

function doerr {
	if [ "$HM" -ge 1 ];
	then
		for e in $(seq 1 $HM);
			do
			echo "This is not correct request" | nc $HOST $PORT
		done
	else
                for (( ; ; ));
                        do
                        sleep "0.3"
			echo "This is not correct request" | nc $HOST $PORT
		done
	fi
}

function doping {
 	if [ "$HM" -ge 1 ];
	then 
        	for e in $(seq 1 $HM);
                	do
                	echo "ping / HTTP/1.1" | nc $HOST $PORT
                done
	else
		for (( ; ; ));
			do
			sleep "0.3"
                	echo "ping / HTTP/1.1" | nc $HOST $PORT
                done
	fi
}

function docurl {
	if [ "$HM" -ge 1 ];
        then
	        for e in $(seq 1 $HM);
        	        do
               		curl $OPT $HOST:$PORT
                done
	else
                for (( ; ; ));
                        do
                        sleep "0.3"
			curl $OPT $HOST:$PORT
		done
	fi	
}

function startz {
	echo "How many connections:"
	read HM
}

# Options

while getopts EPCh option
do
	case $option in
	E)	echo "########## Incorrect connections #########"
		startz
		doerr>$EF
		;;

	P)	echo "########## Ping application ##############"
		startz
		doping>$PF
		;;

	C)	echo "########## Correct HTTP requests #########"
		startz
		docurl>$CF
		;;

	h)	how
		HM=0
		exit 0
		;;

	*)      echo "No such option"
		how
		HM=0
		exit 1
		;;
	esac
done

# Check is executed without options
if [ -z "$HM" ]
then
   HM=10000
   echo "Doing $HM incorrect & correct requests"
   doerr > /dev/null & docurl > /dev/null
fi

