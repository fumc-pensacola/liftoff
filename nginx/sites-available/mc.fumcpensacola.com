#
# Redirect all non-encrypted to encrypted
#
server {
    server_name ~^mc\.fumcpensacola\.(com|local)$;
    listen 80;
    https://$host$request_uri;
}

server {
    server_name ~^mc\.fumcpensacola\.(com|local)$;
    listen *:443 ssl spdy;
    listen [::]:443 ssl spdy;
    
    ssl_certificate /etc/nginx/ssl/mc.fumcpensacola.com.crt;
    ssl_certificate_key /etc/nginx/ssl/mc.fumcpensacola.com.key;
    add_header Strict-Transport-Security "max-age=31536000";

    location ~^/assets|[^/]+\.[^/]+$ {
      set $s3_bucket 'fumc-mission-control.s3-website-us-east-1.amazonaws.com';
      proxy_http_version     1.1;
      proxy_set_header       Host $bucket;
      proxy_set_header       Authorization '';
      proxy_hide_header      x-amz-id-2;
      proxy_hide_header      x-amz-request-id;
      proxy_hide_header      Set-Cookie;
      proxy_ignore_headers   "Set-Cookie";
      proxy_buffering        off;
      proxy_intercept_errors on;

      resolver               8.8.8.8;
      resolver_timeout       5s;
      proxy_pass             http://$s3_bucket;
    }
    
    location / {
      set $s3_bucket 'fumc-mission-control.s3-website-us-east-1.amazonaws.com';
      proxy_http_version     1.1;
      proxy_set_header       Host $bucket;
      proxy_set_header       Authorization '';
      proxy_hide_header      x-amz-id-2;
      proxy_hide_header      x-amz-request-id;
      proxy_hide_header      Set-Cookie;
      proxy_ignore_headers   "Set-Cookie";
      proxy_buffering        off;
      proxy_intercept_errors on;

      resolver               8.8.8.8;
      resolver_timeout       5s;
      proxy_pass             http://$s3_bucket/index.html;
    }
}
