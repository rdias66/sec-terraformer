# Use a base image
FROM ubuntu:latest

# Install iptables (or any other firewall management tools)
RUN apt-get update && apt-get install -y iptables

# Set up necessary permissions for making firewall changes
RUN chmod +s /sbin/iptables

# Set the entry point for the container
CMD ["bash"]
