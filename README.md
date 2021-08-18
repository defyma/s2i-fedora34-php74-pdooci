PHP 7.4 Fedora/s2i-base image added PDO_OCI
================

s2i container plese refer to https://github.com/sclorg/s2i-php-container

Run
---
docker run --mount type=bind,src=/your/path/www/,dst=/opt/app-root/src -p 8080:8080 -it defyma/s2i-fedora34-php74-pdooci /usr/libexec/s2i/run

Enter Bash
-----
docker run --mount type=bind,src=/your/path/www/,dst=/opt/app-root/src -p 8080:8080 -it defyma/s2i-fedora34-php74-pdooci bash
