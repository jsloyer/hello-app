# This is a container image for testing web services
This repo contains a very simple image for testing web services.
The response from this web service returns the container hostname
and the value of the `TEST` env variable.

## Building the web-ms image
Build an image using provided Makefile and push it to the registry

```console
# create an image:
make docker-build

# publish:
make docker-push

# or run it all at once:
make all
```

This new image is available [here](https://hub.docker.com/r/mrsabath/web-ms/) now

## Deploy the image on Docker

```console
$ docker run -d --name WEB -e TEST=MyDockerTest -p 8081:80 mrsabath/web-ms
Unable to find image 'mrsabath/web-ms:latest' locally
latest: Pulling from mrsabath/web-ms
Digest: sha256:83637f53eefb1133e6f33b57fda10dcb59992449d978f4dfcb44a437bec72419
Status: Downloaded newer image for mrsabath/web-ms:latest
b64ab1c979d1f36d320c957acf7dff222e6d354d0a16ff701ce607b2ababcdb0

$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED                  STATUS              PORTS                  NAMES
b64ab1c979d1        mrsabath/web-ms     "/bin/sh -c 'bash -c…"   Less than a second ago   Up 5 seconds        0.0.0.0:8081->80/tcp   WEB
```
After 5 seconds:
```console
$ curl http://localhost:8081
<html><head><title>Hello World</title></head><body><h2>Hostname: b64ab1c979d1</h2><h2>TEST: MyDockerTest</h2></body></html>
```

## Deploy the image on Kubernetes
```console
# create a deployment with 2 pods:
$ kubectl run web --image=mrsabath/web-ms  --replicas=2 --env="TEST=test-web-ms"
deployment "web" created

# check the status of the pods:
$ kubectl get po
NAME                   READY     STATUS              RESTARTS   AGE
web-56b7dbb6c5-4h7kq   0/1       ContainerCreating   0          4s
web-56b7dbb6c5-tkl9h   0/1       ContainerCreating   0          4s

$ kubectl get po
NAME                   READY     STATUS    RESTARTS   AGE
web-56b7dbb6c5-4h7kq   1/1       Running   0          3m
web-56b7dbb6c5-tkl9h   1/1       Running   0          3m

# get inside one of the pods and query the web server:
$ kubectl exec -it web-56b7dbb6c5-4h7kq /bin/bash
root@web-56b7dbb6c5-4h7kq:/# curl localhost:80
<html><head><title>Hello World</title></head><body><h2>Hostname: web-56b7dbb6c5-4h7kq</h2><h2>TEST: test-web-ms</h2></body></html>root@web-5
```
