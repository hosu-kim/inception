# User Documentation

## Services

| Service   | Description                        |
|-----------|------------------------------------|
| NGINX     | Reverse proxy, HTTPS only (443)    |
| WordPress | CMS with php-fpm                   |
| MariaDB   | Database backend                   |

## Start / Stop

```bash
make        # Build and start all services
make down   # Stop all services
make clean  # Stop and remove volumes + data
```

## Access

- Website: `https://hoskim.42.fr`
- Admin panel: `https://hoskim.42.fr/wp-admin`

> Make sure `/etc/hosts` contains: `127.0.0.1 hoskim.42.fr`

## Credentials

All credentials are in `srcs/.env` (not committed to git).

## Check services

```bash
docker compose -f srcs/docker-compose.yml ps
docker logs nginx
docker logs wordpress
docker logs mariadb
```
