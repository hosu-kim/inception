*This project has been created as part of the 42 curriculum by hoskim.*

# Inception

## Description
This project aims to broaden knowledge of system administration by virtualizing several Docker images using Docker Compose. The infrastructure is composed of NGINX, WordPress with php-fpm, and MariaDB, all running in separate, dedicated containers running on Debian 12 without using pre-made DockerHub images.

## Instructions
1. Add `127.0.0.1 hoskim.42.fr` to your `/etc/hosts` file.
2. Configure your credentials by creating and editing `srcs/.env` based on the preset.
3. Run `make` at the root of the repository to setup directories and start the containers.
4. Access the site via `https://hoskim.42.fr`.

## Use of Docker and Sources
The project leverages custom written Dockerfiles for each service. All services pull from the base image `debian:bookworm` and configure the necessary daemons manually.

### Virtual Machines vs Docker
Virtual Machines virtualize the hardware, meaning each VM runs a full guest operating system, which is heavy and resource-intensive. Docker virtualizes the OS, sharing the host's kernel and making containers lightweight, fast to start, and portable.

### Secrets vs Environment Variables
Environment variables are often used for configuration, but they can be exposed to running processes and logs, making them less secure for sensitive data like passwords. Docker Secrets are encrypted in transit and at rest, and only temporarily mounted in memory to containers that explicitly need them.

### Docker Network vs Host Network
A Host Network shares the host's networking namespace entirely with the container, bypassing network isolation. A Docker Network (like a bridge) provides internal DNS and isolates the container's ports, so they must be explicitly mapped to the host, offering better security and control over traffic.

### Docker Volumes vs Bind Mounts
Bind mounts link a specific path on the host to a path in the container. Docker volumes are completely managed by Docker, separate from the host's core file system, meaning they are easier to back up, migrate, and manage without worrying about host OS file permissions or directory structures.

## Resources
- [Docker Documentation](https://docs.docker.com/)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)
- **AI Usage**: AI was primarily used as an assistant to reduce repetitive tasks such as scaffolding directory structures, generating boilerplate configurations for Makefile and Docker Compose, and providing formatting reference for these Markdown documentation files. All generated configurations were reviewed and verified.
