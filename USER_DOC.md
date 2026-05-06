# User Documentation

## Services Provided by the Stack
This infrastructure runs a modern web stack over secure TLS connections:
- **NGINX**: The single entrypoint (Reverse Proxy/Web Server) available on port 443 with TLSv1.2 & TLSv1.3.
- **WordPress**: The Content Management System (PHP-FPM) to manage website content.
- **MariaDB**: The relational database used to store WordPress configuration, posts, and user data.

## Start and Stop the Project
- **To start everything**: Navigate to the directory containing the `Makefile` and run:
  ```bash
  make
  ```
- **To stop everything without deleting data**:
  ```bash
  make stop
  ```

## Access the Website and Administration Panel
- **User Interface**: Once running, open your browser and visit: `https://hoskim.42.fr` (A self-signed SSL warning is normal).
- **Admin Panel**: Visit `https://hoskim.42.fr/wp-admin` and login using the WordPress credentials.

## Locate and Manage Credentials
Credentials and environment variables are entirely managed in a single `.env` file located in the `srcs/` directory. Ensure no unauthorized users have read access to this file. Passwords can be changed here prior to the initial build.

## Check that Services are Running Correctly
You can verify the status of the containers by running the following command from the `srcs` directory:
```bash
docker compose ps
```
Alternatively, simply ensuring the website loads on your browser is a direct check for all 3 interoperating services.
