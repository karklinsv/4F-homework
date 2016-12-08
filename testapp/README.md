################################################################################################

 This bash script will send different requests to application running on configured HOST and PORT.

################################################################################################

 Usage:

 Script is preconfigured to connect to IP: 127.0.0.1 Port: 133 and without any options 
 will send 10000 correct http requests and 10000 incorrect requests.

  Options:

	-E - will generate error messages in applciation log files by sending incorrect request
             (two logfiles will be updated: access.log and err.log) netcat is used (nc)
	-P - will ping server, request will be seen only in ping.log netcat is used (nc)
	-C - will generate correct GET request to application using curl
	-h - show usage info
  After execution with any option (-E -P -C in any combinations) script will ask for a positive 
  number, how many connections to send.
  
        0 - Infinite connections every 0.3 seconds
        1.. Connection number

  Dependencies: netcat (nc) and curl should be installed and accessible from PATH.

  Usage examples: from current dir where script is located:
  * options -E and -C in one line, will ask separattely a number of connection for each test.

  	./doconn.sh -E -C

	########## Incorrect connections #########
	How many connections:
	3
	########## Correct HTTP requests #########
	How many connections:
	4
  
  * script executed without options, will run until all 20000 requests will sent
    
        ./doconn.sh
        Doing 10000 incorrect & 10000 correct requests

  * script executed with -h option will provide usage info
