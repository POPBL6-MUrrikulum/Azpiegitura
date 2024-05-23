# Use Debian Bookworm slim image from 2024-02-11
FROM debian:bookworm-20240211-slim

# Set environment variable to run apt-get in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Update package list and install Python 3 without recommended packages, then clean up
RUN apt-get update && apt-get install -y python3 --no-install-recommends && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set environment variables for the user
ENV USER user
ENV HOME /home/$USER

# Create a group and user with specified user and group ID, create home directory, and set ownership
 RUN groupadd -g 1000 $USER && useradd -u 1000 -g 1000 --create-home --home-dir $HOME $USER && chown -R $USER:$USER $HOME

# Set working directory
WORKDIR $HOME

# Switch to the non-root user
USER $USER

# Copy index.html from the LXC container to the Docker container
#COPY index.html .
COPY python-data/index.html .

# Specify the entrypoint command to start an HTTP server using Python 3
ENTRYPOINT ["/usr/bin/python3", "-m", "http.server"]