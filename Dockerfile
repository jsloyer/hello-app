# Author: Mariusz Sabath
# Email: sabath@us.ibm.com
# Description: this is a simple Dockerfile to create a container 
# with a running web server on port 80
# The response from the container returns the container hostname name
# and the TEST parameter value passed as an environment variable
#     docker run -d --name WEB -e TEST=MyTest1 -p 8081:80 mrsabath/web-ms 
# expected result (after 5 seconds wait delay):
#  curl http://localhost:8081
#  <html><head><title>Hello World</title></head><body><h2>Hostname: e684a1dbcbcb</h2><h2>TEST: MyTest1</h2></body></html>

FROM        ubuntu:latest

RUN apt-get update
RUN apt-get install -y python curl
RUN apt-get clean
RUN apt-get install --only-upgrade  libgnutls-openssl27 libpng12-0

ADD hello_world.py /tmp/hello_world.py

ENV HELLO_VERSION hello version 3

EXPOSE 80
# add a delay to allow setup of the network
CMD bash -c "sleep 5; python /tmp/hello_world.py"

