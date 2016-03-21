FROM islandora-claw/karaf
MAINTAINER Nigel Banks <nigel.g.banks@gmail.com>

LABEL "License"="GPLv3" \
      "Version"="0.0.1"

RUN apk-install git php-phar php-ctype php-json php-curl php-xml php-posix php-openssl && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin && \
    mv /usr/local/bin/composer.phar /usr/local/bin/composer && \
    chmod a+x /usr/local/bin/composer && \
    cleanup

RUN git clone https://github.com/Islandora-CLAW/CLAW.git /opt/claw && \
    cd /opt/claw/camel/commands; composer install && \
    cd /opt/claw/camel; mvn clean install -Dmaven.repo.local=${M2_HOME}/repository && \
    cleanup

COPY rootfs /