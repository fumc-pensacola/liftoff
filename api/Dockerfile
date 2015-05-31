FROM iojs:2.1

MAINTAINER Andrew Branch "andrewbranch@mail.com"

# Create directories on container
RUN mkdir -p /var/www /tmp
WORKDIR /var/www

# Install node modules
COPY satellite/package.json /tmp/package.json
RUN cd /tmp && npm install
RUN cp -a /tmp/node_modules .

# Copy app from host to container
COPY satellite .
COPY .env .env

# Start the app
EXPOSE 3000
CMD ["npm", "start"]
