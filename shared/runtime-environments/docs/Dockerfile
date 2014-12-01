FROM dockerfile/nginx

VOLUME ["/var/www/html"]

CMD 'nginx'

# Serve docs/dir on $HOST:8080
# docker run -d -p 8080:80 -v <docs/dir>:/var/www/html docs