# useage

```
TAG=0.0.1
podman pull ghcr.io/blank71/bigul-container/bigul-container:${TAG}

git clone https://bitbucket.org/prl_tokyo/BiGUL.git
podman run \
-v ./BiGUL:/root/BiGUL \
--replace \
-dit \
--name bigul \
ghcr.io/blank71/bigul-container/bigul-container:${TAG}

podman exec -it bigul /bin/bash
```