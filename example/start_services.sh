#!/bin/bash

#inject if id != 1001
if [ `id -u` != "1001" ]; then
    cat /etc/passwd | sed -e "s/^myusername:/builder:/" > /tmp/passwd
    echo "myusername:x:`id -u`:0:Default Application User:/opt/app-root/src:/sbin/nologin" >> /tmp/passwd
    cat /tmp/passwd > /etc/passwd
    rm /tmp/passwd
fi

/usr/libexec/s2i/run
