# Python with Docker

The goal of this repo is run to a simple Python application within a container.

## Install Docker

For simplicity I will use Docker and Docker Compose, but it is possible to use Podman and Podman Compose too.

I would recommend using a Linux machine (or Windows Subsystem for Linux) for ease of install and better compatability of tools.

> Windows and MacOS do not fully support Docker or Podman natively.

**Linux**
- Option 1: Use the install script provided under `scripts`.
```bash
bash 0-docker-install-ubuntu.sh
```
- Option 2: Follow the install guide for your Linux distribution: https://docs.docker.com/engine/install/ubuntu/

**Windows**
- Option 1: Install Windows Subsystem of Linux, then use an install script under `scripts`, or follow the official docker install guide: https://docs.docker.com/engine/install/ubuntu/
- Option 2: Install Windows Subsystem of Linux, and use Docker Desktop.
- Option 3: Use Docker Desktop with the default Linux (QEMU) virtual machine.

**MacOS**
- Option 1: Install Docker Desktop, which uses a Linux (QEMU) virtual machine: https://docs.docker.com/desktop/install/mac-install/


## Python - Processing

First enter the `processing_example` directory.

### Build the container

```bash
docker compose build
```

### Run the container

```bash
docker compose up -d
```

### View the logs

```bash
docker logs processing_script
```

A file named `processed.csv` should be generated in the `output` directory.

## Python - Application

First enter the `app_example` directory.

### Build the container

```bash
docker compose build
```

### Run the container

```bash
docker compose up -d
```

### Access the API server

Go to localhost:9111 to view the served endpoint.

### View the logs

```bash
docker logs app_server
```

You should see a log record of your visit to the root API page.
