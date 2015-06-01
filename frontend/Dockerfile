FROM iojs:2.1

MAINTAINER Andrew Branch "andrewbranch@mail.com"

# Create directories on container
RUN mkdir -p /data /tmp/npm /tmp/bower /tmp/build
WORKDIR /var/www

# Install node modules
COPY mission-control/package.json /tmp/npm/
RUN cd /tmp/npm && npm install
RUN cp -a /tmp/npm/node_modules /tmp/build/

# Install bower components
COPY mission-control/bower.json /tmp/bower/
COPY mission-control/.bowerrc /tmp/bower/
RUN cd /tmp/bower && mkdir node_modules && cp -a ../build/node_modules/bower node_modules/
RUN cd /tmp/bower && ../build/node_modules/.bin/bower install --allow-root

# Build Ember app
COPY mission-control /tmp/build/
RUN cp -a /tmp/bower/bower_components /tmp/build/
RUN cd /tmp/build && node_modules/.bin/ember build --environment=${EMBER_ENV:-production}
RUN cp -a /tmp/build/dist /data/mission-control

VOLUME /data/mission-control