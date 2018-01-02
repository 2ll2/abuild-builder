# abuild builder for v3.7

This docker image has `abuild` setup to build `.apk` packages.

To get started

```
$ cd abuild-builder/

$ docker build -t abuild-builder .
```

Go to the _parent_ directory containing `aports` tree.

```
$ docker run --rm -ti -v $(pwd):/home/builder/src \
     -v <PATH_TO_REPO_BASE_ON_HOST>:/home/builder/repo/<REPO_BASE> \
     abuild-builder /bin/sh

(For example)

$ docker run --rm -ti -v $(pwd):/home/builder/src \
     -v /home/ll-user/work/lambda2/repo/virtualbox/v3.7:/home/builder/repo/virtualbox/v3.7 \
     abuild-builder /bin/su -l -s /bin/sh builder

f5c1eee20ebe:~$ sudo apk update

f5c1eee20ebe:~$ cd src/aports-virtualbox/main/docker/

f5c1eee20ebe:~/src/aports-virtualbox/main/docker$ abuild \
    -c -r -P /home/builder/repo/virtualbox/v3.7
```
