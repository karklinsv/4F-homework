#!/bin/env bash
# this script will connect to application running on HOST:PORT
# and produce access and error lines in log file depending on options chosen

# configuration

# host and port configuration
HOST="127.0.0.1"
PORT="1337"
# output files
PF="./ping.out"
CF="./conn.out"
EF="./err.out"
# curl options 
OPT="--fail --silent --show-error"

# functions

function how {
echo "
  #############################################################################################
  This bash script will connect to application running on configured host and port
  and based on chosen options perform connections.

  Dependencies: netcat (nc) and curl should be installed and accessible from PATH.
  
  If executed without options, will executes 10000 error and successfull connections.

  After execution with option -E -P -C will ask for number -  how many connections You want.

	0 - Infinite connections every 0.3 seconds
	1-.. Connections count

  Options:

	-E - will generate error messages in applciation log files by sending incorrect request 
             (two logfiles will be updated: access.log and err.log)
	-P - will ping server, request will be seen only in ping.log
	-C - will generate correct GET request to application
	-h - show this
"
}
# this function will send incorrect http request and generate error message in app error log
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
# this function will send ping, and application will reply with pong
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

# this function will execute curl to conf host:port with options (options are needed to prevent curl from output, even it is redirected)
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

# this just reads how many requests need to be sent
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
		doerr>$EF 2>&1
		;;

	P)	echo "########## Ping application ##############"
		startz
		doping>$PF 2>&1
		;;

	C)	echo "########## Correct HTTP requests #########"
		startz
		docurl>$CF 2>&1
		;;

	h)	how
		HM=0
		exit 0
		;;

	*)      echo "########## No such option #################"
		how
		HM=0
		exit 1
		;;
	esac
done

# Check if executed without options
if [ -z "$HM" ]
then
   HM=10000
   echo "Doing $HM incorrect & $HM correct requests"
   doerr > /dev/null 2>&1 & docurl > /dev/null 2>&1
fi

