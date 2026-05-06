# Developer Documentation

## Prerequisites

- Debian/Ubuntu-based VM
- Docker Engine + Docker Compose v2
- `sudo` access

## Setup from Scratch

1. Clone the repository
2. Add domain to `/etc/hosts`:
   ```
   127.0.0.1 hoskim.42.fr
   ```
3. Create data directories (done automatically by `make init`):
   ```
   /home/hoskim/data/wordpress
   /home/hoskim/data/mariadb
   ```
4. Configure `srcs/.env` with your credentials (never commit this file)

## Build & Launch

```bash
make        # runs: mkdir data dirs + docker compose up --build
```

## Useful Commands

```bash
# View running containers
docker compose -f srcs/docker-compose.yml ps

# Exec into a container
docker exec -it wordpress bash
docker exec -it mariadb bash

# View logs
docker logs -f nginx

# List volumes
docker volume ls
docker volume inspect srcs_wordpress
```

## Data Persistence

- WordPress files → `/home/hoskim/data/wordpress` (bind mount via named volume)
- MariaDB data → `/home/hoskim/data/mariadb` (bind mount via named volume)
- Data survives `make down` but is removed by `make clean`
