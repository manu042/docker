# Code Server
Code Server is a self-hosted Visual Studio Code development environment.
- https://coder.com
- https://github.com/coder/code-server
- https://github.com/linuxserver/docker-code-server


## Setup
1. Prepare persistent data directory (for your home and projects):
```bash
mkdir -p coder_data/workspace
```

2. Generate password hashes
- Web login (argon2id):
```bash
sudo apt update
sudo apt install argon2 openssl
echo -n "password123" | argon2 "$(openssl rand -base64 16)" -id -t 3 -m 16 -p 4
echo -n "password123" | argon2 somesalt -id -t 3 -m 16 -p 4
```

- Sudo password (SHA-512 crypt):
```bash
openssl passwd -6 "password123"
```
Why SHA-512 here? The base image doesn’t support Argon2 for system account passwords. Using `-6` generates a compatible SHA-512 hash.

3. Create a `.env` file:
```bash
CODER_UID=1000
CODER_GID=1000
HASHED_PASSWORD=<argon2id hash for web login>
SUDO_PASSWORD_HASH=<sha512-crypt hash for sudo>
```
Important: Dollar signs `$` must be escaped as `$$` in the `.env` file.

4. Build and start:
```bash
docker compose build
docker compose up -d
```


## Notes
- If you’re not using Traefik, remove the labels and expose port 8080 in `docker-compose.yml`:
```yaml
ports:
  - "8080:8080"
```

- To make keyboard shortcuts work in Firefox install [PWA](https://addons.mozilla.org/en-US/firefox/addon/pwas-for-firefox/)
  - [Coder FAQ](https://github.com/coder/code-server/blob/main/docs/FAQ.md#how-do-i-make-my-keyboard-shortcuts-work)
