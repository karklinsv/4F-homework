#!/usr/bin/python
import time
import BaseHTTPServer
import sys

HOST_NAME = '0.0.0.0'
PORT_NUMBER = 1337

class MyHandler(BaseHTTPServer.BaseHTTPRequestHandler):
    log_file = open('/opt/application/access.log', 'w')
    err_file = open('/opt/application/err.log', 'w')
    ping_file = open('/opt/application/ping.log', 'w')

    def log_error(s, format, *args):
	s.err_file.write("%s - - [%s] %s\n" %
			(s.client_address[0],
			 s.log_date_time_string(),
			 format%args))
	s.err_file.flush()

    def log_message(s, format, *args):
	s.log_file.write("%s - - [%s] %s\n" %
			(s.client_address[0],
			 s.log_date_time_string(),
			 format%args))
	s.log_file.flush() 

    def do_ping(s):
        s.wfile.write('pong\n')
	s.ping_file.write("\n ping served")
	s.ping_file.flush()

    def do_HEAD(s):
        s.send_response(200)
        s.send_header("Content-type", "text/html")
        s.end_headers()

    def do_GET(s):
        """Respond to a GET request."""
        s.send_response(200)
        s.send_header("Content-type", "text/html")
        s.end_headers()
        s.wfile.write("<html><head><title>This is application</title></head>")
        s.wfile.write("<body><p>Listening for connections</p>")
        s.wfile.write("</body></html>")

if __name__ == '__main__':
    server_class = BaseHTTPServer.HTTPServer
    httpd = server_class((HOST_NAME, PORT_NUMBER), MyHandler)
    print time.asctime(), "Server Starts - %s:%s" % (HOST_NAME, PORT_NUMBER)
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    httpd.server_close()
    print time.asctime(), "Server Stops - %s:%s" % (HOST_NAME, PORT_NUMBER)

