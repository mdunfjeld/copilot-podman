
## Build

```
podman build --build-arg USER_UID=$(id -u) --build-arg USER_GID=$(id -g) -t copilot-agent -f Containerfile
```


## Run 

```
podman run -it --rm --hostname=copilot-agent \
  --network=host \
  --userns=keep-id:uid=1000,gid=1000 \
  -e HOME=/home/ubuntu \
  -v "$(pwd):/home/ubuntu/$(basename $(pwd)):Z" \
  -v "$HOME/.copilot:/home/ubuntu/.copilot:Z" \
  copilot-agent
```
# copilot-podman
