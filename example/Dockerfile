FROM defyma/s2i-fedora34-php74-pdooci-libreoffice:latest

COPY . /opt/app-root/src

# RUN cd /opt/app-root/src && php composer.phar install

USER root



# CHMOD  /etc/passwd
RUN chmod g+w /etc/passwd
USER 1001

CMD /opt/app-root/src/start_services.sh
