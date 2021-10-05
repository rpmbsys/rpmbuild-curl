ARG centos=7.9.2009
FROM aursu/rpmbuild:${centos}-build

USER root
RUN yum -y install \
        gnutls-utils \
        groff \
        libidn2-devel \
        libnghttp2-devel \
        libpsl-devel \
        nghttp2 \
        openssl-devel \
        perl-Digest-MD5 \
        'perl(IO::Compress::Gzip)' \
        stunnel \
        zlib-devel \
    && yum clean all && rm -rf /var/cache/yum

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER
ENTRYPOINT ["/usr/bin/rpmbuild", "curl.spec"]
CMD ["-ba"]
