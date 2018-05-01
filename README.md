# This is a container image for testing web services.
This repo contains a very simple image for testing web services.
The response from this web service returns the container hostname
and the value of the `TEST` env variable.

For docker:
```console
docker run -d --name WEB -e TEST=MyDockerTest -p 8081:80 mrsabath/web-ms
```
After 5 seconds:
```console
curl http://localhost:8081
<html><head><title>Hello World</title></head><body><h2>Hostname: e684a1dbcbcb</h2><h2>TEST: MyDockerTest</h2></body></html>
```

For Kubernetes:
```console
kubectl run web --image=mrsabath/web-ms  --replicas=2 --env="TEST=test-web-ms"
```
After 5 seconds:
```console
curl http://localhost:8081
<html><head><title>Hello World</title></head><body><h2>Hostname: e684a1dbcbcb</h2><h2>TEST: test-web-ms</h2></body></html>
```


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
