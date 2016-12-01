#!/usr/bin/python
import SimpleHTTPServer
import SocketServer

counterf = 0
PORT = 6699

Handler = SimpleHTTPServer.SimpleHTTPRequestHandler

httpd = SocketServer.TCPServer(("", PORT), Handler)

print "serving at port", PORT

httpd.serve_forever()

