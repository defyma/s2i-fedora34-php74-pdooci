FROM registry.fedoraproject.org/f34/s2i-base:latest

# This image provides an Apache+PHP environment for running PHP
# applications.

EXPOSE 8080
EXPOSE 8443

ENV PHP_VERSION=7.4 \
    PATH=$PATH:/usr/bin

ENV SUMMARY="Platform for building and running PHP $PHP_VERSION applications" \
    DESCRIPTION="PHP $PHP_VERSION available as container is a base platform for \
building and running various PHP $PHP_VERSION applications and frameworks. \
PHP is an HTML-embedded scripting language. PHP attempts to make it easy for developers \
to write dynamically generated web pages. PHP also offers built-in database integration \
for several commercial and non-commercial database management systems, so writing \
a database-enabled webpage with PHP is fairly simple. The most common use of PHP coding \
is probably as a replacement for CGI scripts."

ENV NAME=php \
    VERSION=0 \
    RELEASE=1 \
    ARCH=x86_64

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Apache 2.4 with PHP $PHP_VERSION" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,php" \
      name="$FGC/$NAME" \
      com.redhat.component="$NAME" \
      version="$VERSION" \
      usage="s2i build https://github.com/sclorg/s2i-php-container.git --context-dir=/$PHP_VERSION/test/test-app $FGC/$NAME sample-server" \
      maintainer="SoftwareCollections.org <sclorg@redhat.com>"

# Install Apache httpd and PHP
#RUN INSTALL_PKGS="php php-devel php-mysqlnd php-bcmath php-json \
#                  php-gd php-intl php-ldap php-mbstring php-pdo \
#                  php-process php-soap php-opcache php-xml \
#                  php-gmp php-pecl-apcu mod_ssl hostname" && \
#    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS --nogpgcheck && \
#    rpm -V $INSTALL_PKGS && \
#    yum -y clean all --enablerepo='*'

RUN dnf -y update;
RUN dnf -y install https://rpms.remirepo.net/fedora/remi-release-34.rpm
RUN dnf -y config-manager --set-enabled remi
RUN dnf -y module reset php
RUN dnf -y module install php:remi-7.4

RUN INSTALL_PKGS="php php-cli php-devel php-mysqlnd php-zip php-bcmath php-json \
                  php-gd php-intl php-ldap php-mbstring php-pdo php-mcrypt php-pear php-pgsql \
                  php-process php-soap php-curl php-opcache php-xml \
                  php-gmp php-pecl-apcu mod_ssl hostname" && \
    dnf -y install $INSTALL_PKGS

RUN dnf -y install php-oci8

COPY ./bahan/oracle/instantclient_21_1/oracle-instantclient-basic-21.1.0.0.0-1.x86_64.rpm /root/oracle-instantclient-basic-21.1.0.0.0-1.x86_64.rpm
COPY ./bahan/oracle/instantclient_21_1/oracle-instantclient-devel-21.1.0.0.0-1.x86_64.rpm /root/oracle-instantclient-devel-21.1.0.0.0-1.x86_64.rpm

RUN yum install -y iproute \
    /root/oracle-instantclient-basic-21.1.0.0.0-1.x86_64.rpm \
    /root/oracle-instantclient-devel-21.1.0.0.0-1.x86_64.rpm \
    && yum clean all -y

RUN export ORACLE_HOME=/usr/lib/oracle/21/client64/ \
export PATH=$ORACLE_HOME/bin:$PATH \
export LD_LIBRARY_PATH=$ORACLE_HOME/lib

RUN echo "/usr/lib/oracle/21/client64/lib" > /etc/ld.so.conf.d/oracle21.conf
RUN ldconfig

RUN rm /root/oracle-instantclient-basic-21.1.0.0.0-1.x86_64.rpm
RUN rm /root/oracle-instantclient-devel-21.1.0.0.0-1.x86_64.rpm

ENV PHP_CONTAINER_SCRIPTS_PATH=/usr/share/container-scripts/php/ \
    APP_DATA=${APP_ROOT}/src \
    PHP_DEFAULT_INCLUDE_PATH=/usr/share/pear \
    PHP_SYSCONF_PATH=/etc/ \
    PHP_HTTPD_CONF_FILE=php.conf \
    HTTPD_CONFIGURATION_PATH=${APP_ROOT}/etc/conf.d \
    HTTPD_MAIN_CONF_PATH=/etc/httpd/conf \
    HTTPD_MAIN_CONF_D_PATH=/etc/httpd/conf.d \
    HTTPD_MODULES_CONF_D_PATH=/etc/httpd/conf.modules.d \
    HTTPD_VAR_RUN=/var/run/httpd \
    HTTPD_DATA_PATH=/var/www \
    HTTPD_DATA_ORIG_PATH=/var/www \
    HTTPD_VAR_PATH=/var

# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH
COPY ./s2i/bin/ $STI_SCRIPTS_PATH

# Copy extra files to the image.
COPY ./root/ /

# Reset permissions of filesystem to default values
RUN /usr/libexec/container-setup && rpm-file-permissions

USER 1001

# Set the default CMD to print the usage of the language image
CMD $STI_SCRIPTS_PATH/usage
