FROM ubuntu:xenial

# Install gosu
ENV GOSU_VERSION=1.9
RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates wget \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && apt-get purge -y --auto-remove ca-certificates wget \
    && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install java8
RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common \
    && add-apt-repository -y ppa:webupd8team/java \
    && (echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections) \
    && apt-get update \
    && apt-get install -y oracle-java8-set-default \
    && apt-get purge -y --auto-remove software-properties-common \
    && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install wait-for-it
ENV WAITFORIT_VERSION=v1.4.0
RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends curl \
    && curl -o /usr/local/bin/waitforit -sSL https://github.com/maxcnunes/waitforit/releases/download/$WAITFORIT_VERSION/waitforit-linux_amd64 \
    && chmod +x /usr/local/bin/waitforit \
    && apt-get purge -y --auto-remove curl \
    && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create entrypoint
COPY docker-entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

