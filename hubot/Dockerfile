FROM node:argon

MAINTAINER Andrew Branch "andrew@wheream.io"

# Create directories on container
RUN mkdir -p /var/www
WORKDIR /var/www

# Copy app from host to container
COPY gerty .
COPY .env .env

# Start the app
EXPOSE 6379
CMD ["bin/hubot", "-a", "slack"]
