# Agentbox
Run AI agents in a sandbox.


## Start a shell

```bash
docker exec -it agentbox bash

# As root
docker exec --privileged -u root -it agentbox bash
```


## Use with Apple containers

```bash
# Start the container service (once per boot)
container system start

# Build image
container build -t agentbox \
  --build-arg UID=$(id -u) \
  --build-arg GID=$(id -g) \
  --build-arg NODE_MAJOR=24 \
  .

# Temporary container
container run --rm -it -v "$HOME/Projects:/Projects" agentbox bash
container run --rm -it -v "$PWD:/work" agentbox bash

# Create volumes (once)
for v in claude pi cache npm cargo-registry cargo-git; do
  container volume create "agentbox-$v"
done

# Start detached
container run -d --name agentbox \
  --env-file .env \
  -w /Projects \
  -v "$HOME/Projects:/Projects" \
  -v agentbox-claude:/home/dev/.claude \
  -v agentbox-pi:/home/dev/.pi \
  -v agentbox-cache:/home/dev/.cache \
  -v agentbox-npm:/home/dev/.npm \
  -v agentbox-cargo-registry:/home/dev/.cargo/registry \
  -v agentbox-cargo-git:/home/dev/.cargo/git \
  agentbox

# Shell
container exec -it agentbox bash
container exec -u root -it agentbox bash

# Stop / remove
container stop agentbox
container delete agentbox

# List running containers (-a for all)
container list

# List images
container image list

# Delete image
container image delete agentbox
```
