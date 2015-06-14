FROM nginx:1

MAINTAINER Andrew Branch "andrewbranch@mail.com"

WORKDIR /etc/nginx

# Copy server configuration and sites
COPY . /etc/nginx

# Make and link sites_enabled  
RUN ln -s sites-available sites-enabled
