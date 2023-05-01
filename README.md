# Custom Nginx Load Balancer

This custom nginx container is designed to act as a load balancer for the a11y-proxy service in your Docker Compose deployment. The container is built on top of the official nginx image and includes a custom `nginx.conf` configuration file.

## Features

- Load balances traffic between multiple instances of the a11y-proxy service
- Uses the least connection algorithm for load balancing
- Listens on port 80 for incoming requests

## Usage

### Prerequisites

- Docker
- Docker Compose

### Files

Ensure that you have the following files in your project directory:

- `Dockerfile`: Custom Dockerfile for building the nginx container
- `nginx.conf`: Custom nginx configuration file

### Configuration

The nginx.conf configuration file is embedded in the custom nginx container. To modify the load balancer configuration, edit the nginx.conf file and rebuild the container using the docker-compose up --build command.