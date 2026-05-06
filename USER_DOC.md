# User Documentation

## Services

This stack provides three services, each running in its own Docker container:

| Service   | Description                                              |
|-----------|----------------------------------------------------------|
| NGINX     | Sole entry point. Serves HTTPS only on port 443 (TLSv1.2/1.3). Forwards PHP requests to WordPress via FastCGI. |
| WordPress | CMS powered by php-fpm. Handles all website content and administration. |
| MariaDB   | Relational database. Stores all WordPress data (posts, users, settings). |

HTTP (port 80) is intentionally not exposed. All traffic must go through HTTPS.

---

## Start / Stop

```bash
make        # Build images and start all services
make down   # Stop all services (data is preserved)
make clean  # Stop services and delete all data
make re     # Full rebuild from scratch
```

---

## Access

Before accessing the site, make sure your `/etc/hosts` contains:
```
127.0.0.1 hoskim.42.fr
```

| URL | Description |
|-----|-------------|
| `https://hoskim.42.fr` | WordPress website |
| `https://hoskim.42.fr/wp-admin` | Administration panel |

> A self-signed SSL certificate is used. Your browser will show a security warning — this is expected. Proceed by accepting the exception.

### Admin login
- **URL**: `https://hoskim.42.fr/wp-admin`
- **Username**: defined as `WP_ADMIN_USER` in `srcs/.env`
- **Password**: defined as `WP_ADMIN_PASSWORD` in `srcs/.env`

---

## Credentials

All credentials are stored in `srcs/.env`. This file is **never committed to git**.

```
srcs/.env
├── MYSQL_DATABASE      # WordPress database name
├── MYSQL_USER          # Database user for WordPress
├── MYSQL_PASSWORD      # Database user password
├── MYSQL_ROOT_PASSWORD # MariaDB root password
├── WP_ADMIN_USER       # WordPress administrator username
├── WP_ADMIN_PASSWORD   # WordPress administrator password
├── WP_ADMIN_EMAIL      # WordPress administrator email
├── WP_USER             # Secondary WordPress user
└── WP_USER_PASSWORD    # Secondary user password
```

To update a credential: edit `srcs/.env`, then run `make re` to rebuild.

---

## Check Services

```bash
# View status of all containers
docker compose -f srcs/docker-compose.yml ps

# View logs per service
docker logs nginx
docker logs wordpress
docker logs mariadb

# Follow logs in real time
docker logs -f wordpress

# Check volumes exist
docker volume ls

