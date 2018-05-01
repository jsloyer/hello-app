__author__ = "Mariusz Sabath"
__email__ = "sabath@us.ibm.com"

import time, os
import socket
import BaseHTTPServer

TEST = os.environ.get('TEST', "unknown")
TEST = TEST.split('/')[-1]

class MyHandler(BaseHTTPServer.BaseHTTPRequestHandler):
    def do_HEAD(self):
        self.send_respones(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()

    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        path = self.path.strip('/')
        segments = path.split('/')
        if len(segments) == 2 and segments[0] == "env_var":
            key = segments[1].upper()
            value = os.environ.get(key, "")
            self.wfile.write(value)
            return
        self.wfile.write("<html><head><title>Hello World</title></head>")
        self.wfile.write("<body>")
        self.wfile.write("<h2>Hostname: " + socket.gethostname() + "</h2>")
        self.wfile.write("<h2>TEST: " + TEST + "</h2>")
        self.wfile.write("</body></html>")

if __name__ == "__main__":
    server_class = BaseHTTPServer.HTTPServer
    # httpd = server_class((socket.gethostname(), 80), MyHandler)
    httpd = server_class(('0.0.0.0', 80), MyHandler)
    print time.asctime(), "Server started - %s:%s" % (socket.gethostname(), 80)
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    httpd.server_close()
    print time.asctime(), "Server stopped"



