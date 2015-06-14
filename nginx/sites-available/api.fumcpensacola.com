server {
    server_name ~^api\.fumcpensacola\.(com|local)$;
    listen *:80;
    listen [::]:80;

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
