FROM defyma/s2i-fedora34-php74-pdooci

USER root

# Install Libreoffice & python3

COPY ./bahan/LibreOffice_7.3.0_Linux_x86-64_rpm.tar.gz /root/LibreOffice_7.3.0_Linux_x86-64_rpm.tar.gz
RUN dnf install --enablerepo=updates-testing python3.10 -y
RUN dnf install python3.10 -y
RUN yum install cups-libs.x86_64 -y
RUN cd /root/ && tar -xvf LibreOffice_7.3.0_Linux_x86-64_rpm.tar.gz
RUN cd /root/LibreOffice_7.3.0.3_Linux_x86-64_rpm && dnf install RPMS/*.rpm -y
RUN rm /root/LibreOffice_7.3.0_Linux_x86-64_rpm.tar.gz

USER 1001

# Set the default CMD to print the usage of the language image
CMD $STI_SCRIPTS_PATH/usage