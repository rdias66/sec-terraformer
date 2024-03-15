#!/bin/bash

# Function to check if Docker is installed
check_docker() {
    if ! command -v docker &> /dev/null; then
        echo "Docker is not installed. Installing Docker..."
        # Install Docker
        curl -fsSL https://get.docker.com -o get-docker.sh
        sudo sh get-docker.sh
        sudo usermod -aG docker "$USER"  # Add current user to the docker group
        echo "Docker installed successfully."
    else
        echo "Docker is already installed."
    fi
}

# Function to build Docker image
build_docker_image() {
    # Build the Docker image
    docker build -t sec-infra-image .
}

# Function to start the container
start_container() {
    # Start the container
    docker run -dit --name "$CONTAINER_NAME" -p "$PORTS" sec-infra-image
}

# Function to install Go inside the container
install_go() {
    docker exec -it "$CONTAINER_NAME" apt-get update
    docker exec -it "$CONTAINER_NAME" apt-get install -y golang
}

# Function to install Git inside the container
install_git() {
    docker exec -it "$CONTAINER_NAME" apt-get install -y git
}

# Function to install required packages inside the container
install_required_packages() {
    docker exec -it "$CONTAINER_NAME" apt-get install -y sudo nano
    docker exec -it "$CONTAINER_NAME" git clone "https://github.com/rdias66/sec-infra.git"
}

# Define container name + ports * define further later.
CONTAINER_NAME="sec-env"
PORTS="8080:22"

# Check if Docker is installed
check_docker

# Build Docker image
build_docker_image

# Start the container
start_container

# Install Go inside the container
install_go

# Install Git inside the container
install_git

# Install required packages inside the container
install_required_packages
