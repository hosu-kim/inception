# Developer Documentation

## Prerequisites

- Debian/Ubuntu-based Virtual Machine
- Docker Engine + Docker Compose v2 installed
- `sudo` access on the VM
- `git` installed

---

## Setup from Scratch

### 1. Clone the repository

```bash
git clone <your-repo-url>
cd inception
```

### 2. Configure the domain

Add this line to `/etc/hosts` on the VM:
```
127.0.0.1 hoskim.42.fr
```

```bash
echo "127.0.0.1 hoskim.42.fr" | sudo tee -a /etc/hosts
```

### 3. Configure environment variables

`srcs/.env` is not committed to git. Create or edit it with your credentials:

```env
DOMAIN_NAME=hoskim.42.fr

MYSQL_DATABASE=wordpress
MYSQL_USER=wpuser
MYSQL_PASSWORD=your_password
MYSQL_ROOT_PASSWORD=your_root_password

WP_TITLE=Inception
WP_ADMIN_USER=hoskim_admin
WP_ADMIN_PASSWORD=your_admin_password
WP_ADMIN_EMAIL=hoskim@student.42.fr
WP_USER=hoskim
WP_USER_PASSWORD=your_user_password
WP_USER_EMAIL=hoskim_user@student.42.fr
```

> ⚠️ Never commit `.env` to git. It is listed in `.gitignore`.

### 4. Data directories

Created automatically by `make init`, but you can also create them manually:

```bash
mkdir -p /home/hoskim/data/wordpress
mkdir -p /home/hoskim/data/mariadb
```

---

## Build & Launch

```bash
make        # init + docker compose up --build (detached)
make down   # docker compose down
make stop   # docker compose stop (keeps containers)
make clean  # down + remove volumes and /home/hoskim/data
make fclean # clean + remove all Docker images
make re     # fclean + full rebuild
```

---

## Managing Containers & Volumes

```bash
# View running containers and their status
docker compose -f srcs/docker-compose.yml ps

# Execute a shell inside a container
docker exec -it nginx bash
docker exec -it wordpress bash
docker exec -it mariadb bash

# View real-time logs
docker logs -f nginx
docker logs -f wordpress
docker logs -f mariadb

# List all volumes
docker volume ls

# Inspect a volume (shows host path)
docker volume inspect srcs_wordpress
docker volume inspect srcs_mariadb

# Connect to MariaDB directly
docker exec -it mariadb mysql -u root -p
```

---

## Data Persistence

| Data | Container path | Host path |
|------|---------------|-----------|
| WordPress files | `/var/www/html` | `/home/hoskim/data/wordpress` |
| MariaDB database | `/var/lib/mysql` | `/home/hoskim/data/mariadb` |

Both are Docker **named volumes** using a local bind-mount driver, so data is stored directly on the host filesystem. Data survives `make down` and VM reboots, but is deleted by `make clean`.

