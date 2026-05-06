# Developer Documentation

## Set up the Environment from Scratch
1. Ensure Docker and Docker Compose are installed on your system.
2. Verify that `/home/hoskim/data` is available as a volume storage location (managed automatically by the Makefile).
3. Confirm the presence of `.env` inside the `srcs/` folder. It must contain the variables: `DOMAIN_NAME`, `LOGIN`, `MYSQL_DATABASE`, `MYSQL_USER`, `MYSQL_PASSWORD`, `MYSQL_ROOT_PASSWORD`, and `WP_*` credentials.
4. Set up `/etc/hosts` to point the target domain (`hoskim.42.fr`) to `127.0.0.1`.

## Build and Launch the Project
A `Makefile` handles all aspects of orchestration. 
To build locally from scratch and launch containers:
```bash
make
```
To do a full clean up including volumes, dangling images, and system pruning:
```bash
make fclean
```

## Useful Commands
- Rebuild containers manually: `docker compose -f srcs/docker-compose.yml build`
- View live logs: `docker compose -f srcs/docker-compose.yml logs -f`
- Enter a running container (e.g., NGINX): `docker exec -it nginx /bin/bash`
- Inspect volumes: `docker volume ls`

## Data Persistence
All persistent data is stored locally on the host machine using named volumes linked to:
- **MariaDB data**: `/home/hoskim/data/mariadb`
- **WordPress files**: `/home/hoskim/data/wordpress`

These files are preserved even if the containers are destroyed or restarted, providing true data security across container lifecycles.
