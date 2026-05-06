*This project has been created as part of the 42 curriculum by hoskim.*

---

## Description

**Inception** is a system administration project that builds a small but complete web infrastructure using **Docker Compose**, all running inside a Virtual Machine.

The stack is composed of three services, each isolated in its own container:

- **NGINX** — the sole entry point, serving HTTPS only (TLSv1.2/1.3) on port 443 with a self-signed SSL certificate
- **WordPress + php-fpm** — the CMS, running without NGINX, communicating with NGINX via FastCGI on port 9000
- **MariaDB** — the relational database backend for WordPress

Data is persisted through two Docker named volumes mapped to the host filesystem under `/home/hoskim/data/`.

---

## Directory Structure

```
inception/
├── Makefile                          # Build, run, and clean commands
├── README.md
├── USER_DOC.md                       # End-user documentation
├── DEV_DOC.md                        # Developer documentation
├── .gitignore                        # Excludes .env and secrets/
└── srcs/
    ├── .env                          # Environment variables (not committed)
    ├── docker-compose.yml            # Defines all services, volumes, network
    └── requirements/
        ├── nginx/
        │   ├── Dockerfile            # Installs NGINX + generates SSL cert
        │   └── conf/
        │       └── nginx.conf        # TLSv1.2/1.3, port 443, FastCGI to WP
        ├── wordpress/
        │   ├── Dockerfile            # Installs php-fpm, wp-cli
        │   ├── conf/
        │   │   └── www.conf          # php-fpm pool config (port 9000)
        │   └── tools/
        │       └── wp-setup.sh       # Waits for DB, installs WP, runs php-fpm
        └── mariadb/
            ├── Dockerfile            # Installs MariaDB
            ├── conf/
            │   └── 50-server.cnf    # MariaDB server config (bind 0.0.0.0)
            └── tools/
                └── db-setup.sh      # Initializes DB, user, runs mysqld
```

---

## Architecture

```
Browser (HTTPS:443)
        │
        ▼
  ┌──────────┐
  │  NGINX   │  ← only open port (443, TLSv1.2/1.3)
  └────┬─────┘
       │ FastCGI (port 9000)
       ▼
  ┌───────────┐     ┌──────────┐
  │ WordPress │────▶│ MariaDB  │
  │ (php-fpm) │     │          │
  └─────┬─────┘     └────┬─────┘
        │                │
        ▼                ▼
  [wordpress volume] [mariadb volume]
  /home/hoskim/data/wordpress
                   /home/hoskim/data/mariadb
```

All containers communicate over a dedicated Docker bridge network (`inception`). HTTP (port 80) is not exposed at all.

---

## Instructions

### Prerequisites

- Docker Engine + Docker Compose v2 installed on the VM
- Add the domain to `/etc/hosts`:
  ```bash
  echo "127.0.0.1 hoskim.42.fr" | sudo tee -a /etc/hosts
  ```
- Edit `srcs/.env` and set your own passwords before first run

### Run

```bash
make        # Creates data dirs, builds images, starts containers
```

### Stop

```bash
make down   # Stops containers (data is preserved)
```

### Full reset

```bash
make fclean # Stops, removes containers, images, volumes, and data
make re     # fclean + full rebuild
```

### Access

| URL | Description |
|-----|-------------|
| `https://hoskim.42.fr` | WordPress website |
| `https://hoskim.42.fr/wp-admin` | WordPress admin panel |

---

## Design Choices

### Virtual Machines vs Docker
VMs emulate an entire OS with its own kernel, requiring significant resources. Docker containers share the host kernel and are isolated at the process level — much lighter and faster to start. For this project, Docker is ideal since each service only needs its runtime, not a full OS.

### Secrets vs Environment Variables
Environment variables (via `.env`) are convenient but can be exposed through `docker inspect` or logs. Docker Secrets store sensitive data in-memory and are only accessible to authorized services. This project uses `.env` for simplicity, with `.gitignore` preventing accidental commits.

### Docker Network vs Host Network
`network: host` removes network isolation and exposes all container ports directly on the host. A custom Docker bridge network (`inception`) keeps containers isolated from the host and from each other, with only explicitly declared connections allowed.

### Docker Volumes vs Bind Mounts
Bind mounts directly map a host path into a container, which is simpler but less portable and harder to manage. Named volumes are managed by Docker, support drivers, and work better across environments. This project uses **named volumes with bind-mount options** to satisfy both the persistence requirement (`/home/hoskim/data/`) and the named volume requirement from the subject.

---

## Resources

- [Docker documentation](https://docs.docker.com/)
- [Docker Compose reference](https://docs.docker.com/compose/compose-file/)
- [NGINX SSL configuration](https://nginx.org/en/docs/http/ngx_http_ssl_module.html)
- [WP-CLI documentation](https://wp-cli.org/)
- [MariaDB documentation](https://mariadb.com/kb/en/documentation/)
- [php-fpm configuration](https://www.php.net/manual/en/install.fpm.configuration.php)
- [PID 1 and Docker best practices](https://cloud.google.com/architecture/best-practices-for-building-containers)

### AI Usage
AI was used to assist with boilerplate shell script logic, NGINX configuration syntax, MariaDB bootstrap SQL, and README structure. All generated content was reviewed, tested, and fully understood before inclusion in the project.
