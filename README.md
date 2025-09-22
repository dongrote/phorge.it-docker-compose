
# Phorge.it Docker Compose Deployment

This repository contains a `docker-compose.yml` file for standing up a Phorge.it deployment from scratch.

## Prerequisites

Before deploying, ensure you have the following:

1. Docker and Docker Compose installed on your machine.
2. TLS/SSL credentials stored in a local directory named `tls`. The following two files are expected:
   - `privkey.pem` (your private key)
   - `fullchain.pem` (your certificate chain)

## Getting Started

1. **Copy the `.env.template` file to `.env`:**
   ```
   cp .env.template .env
   ```

2. **Populate the `.env` file with your configuration details.** Make sure that the `SERVER_NAME` matches the fully qualified domain name encoded in your TLS certificate materials.

3. **Deploy using Docker Compose:**
   ```
   docker-compose up -d
   ```

This will start the Phorge.it services with TLS/SSL support enabled.