#
# Redirect all non-encrypted to encrypted
#
server {
    server_name ~^api\.fumcpensacola\.(com|local)$;

    listen *:80;
    listen [::]:80;

    return 301 https://api.fumcpensacola.$1$request_uri;
}

server {
    server_name ~^api\.fumcpensacola\.(com|local)$;
    listen *:443 ssl spdy;
    listen [::]:443 ssl spdy;
    
    ssl_certificate /etc/nginx/ssl/api.fumcpensacola.com.chained.crt;
    ssl_certificate_key /etc/nginx/ssl/api.fumcpensacola.com.key;
    add_header Strict-Transport-Security "max-age=31536000";

    location / {
        proxy_pass http://api:3000;

        proxy_set_header X-Real-IP         $remote_addr;
        proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
        proxy_set_header Host              $http_host;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-NginX-Proxy     true;

        proxy_pass_header X-CSRF-TOKEN;
        proxy_buffering off;
        proxy_redirect off;
    }
}
