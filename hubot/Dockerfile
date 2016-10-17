FROM node:argon

MAINTAINER Andrew Branch "andrew@wheream.io"

# Create directories on container
RUN mkdir -p /var/www
WORKDIR /var/www

# Copy app from host to container
COPY gerty .
COPY .env .env

# Start the app
CMD ["bin/hubot", "-a", "slack"]
