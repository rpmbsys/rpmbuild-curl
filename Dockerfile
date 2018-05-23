FROM centos:6-rpmbuild

RUN yum -y install \
        gnutls-utils \
        libidn2-devel \
        libnghttp2-devel \
        nghttp2 \
        openssl-devel \
        perl-Time-HiRes \
        stunnel \
        zlib-devel \
    && yum clean all && rm -rf /var/cache/yum

COPY SOURCES /root/rpmbuild/SOURCES
COPY SPECS /root/rpmbuild/SPECS

ENTRYPOINT ["/usr/bin/rpmbuild", "curl.spec"]
CMD ["-ba"]
