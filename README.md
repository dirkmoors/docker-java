# docker-java

To build the docker image for Ubuntu 16.04 (Xenial) including Java 8
```
$ make build
```

This will generate the image:
```
ditchitall/java:8
```

Then, you can use on of this as a base image or run java directly.

## Non-Root container command execution
Example
```
$ docker run -e LOCAL_USER_ID=$(id -u) -ti ditchitall/java:8 bash
bash-4.3$
```
You can verify the uid to be non-root:
```
bash-4.3$ echo $(id -u)
bash-4.3$ 0
```