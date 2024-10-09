FROM alpine:3.14
# LABEL org.opencontainers.image.authors="TheCritic <thecritic@skiff.com>"

EXPOSE 51473

ENV GLIBC_REPO=https://github.com/sgerrand/alpine-pkg-glibc
ENV GLIBC_VERSION=2.30-r0
ENV DIVI_VERSION=3.0.0
ENV DIVI_HASH=9e2f76c

RUN set -ex && \
    apk --update add libstdc++ curl ca-certificates openssl supervisor && \
    for pkg in glibc-${GLIBC_VERSION} glibc-bin-${GLIBC_VERSION}; \
        do curl -sSL ${GLIBC_REPO}/releases/download/${GLIBC_VERSION}/${pkg}.apk -o /tmp/${pkg}.apk; done && \
    apk add --allow-untrusted /tmp/*.apk && \
    rm -v /tmp/*.apk && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib

RUN set -ex && \
    DIVI_URL="https://github.com/DiviProject/Divi/releases/download/v${DIVI_VERSION}/divi-${DIVI_VERSION}-x86_64-linux-gnu-${DIVI_HASH}.tar.gz" && \
    echo "Downloading from URL: $DIVI_URL" && \
    curl -sSL $DIVI_URL -o divi-${DIVI_VERSION}-x86_64-linux.tar.gz && \
    tar xvfz divi-${DIVI_VERSION}-x86_64-linux.tar.gz && \
    mv ./divi-${DIVI_VERSION}/bin/* /usr/bin && \
    rm divi-${DIVI_VERSION}-x86_64-linux.tar.gz && \
    mkdir -p /etc/divi && \
    mkdir -p /var/lib/divid

COPY ./start.sh /usr/local/bin/start.sh
COPY ./supervisord.conf /etc/supervisord.conf
COPY ./divi-cli /usr/local/bin/divi-cli
COPY ./divid /usr/local/bin/divid
RUN set -ex && \
    chmod +x /usr/local/bin/divi-cli && \
    chmod +x /usr/local/bin/divid && \
    chmod +x /usr/local/bin/start.sh
ENTRYPOINT ["/usr/local/bin/start.sh"]
#CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
