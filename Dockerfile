FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    gnupg2 wget lsb-release curl git sudo locales tzdata \
    postgresql-client \
    freeswitch freeswitch-mod-conference freeswitch-mod-console freeswitch-mod-db \
    freeswitch-mod-dptools freeswitch-mod-loopback freeswitch-mod-sofia \
    freeswitch-mod-spandsp freeswitch-mod-voicemail freeswitch-lang-fr \
    freeswitch-mod-lua freeswitch-mod-python3 freeswitch-mod-shout \
    freeswitch-mod-say-fr freeswitch-mod-say-en freeswitch-music \
    nginx php php-pgsql php-fpm php-cli php-curl php-xml php-mbstring php-pear php-gd \
    supervisor

RUN echo "fr_FR.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

RUN git clone https://github.com/fusionpbx/fusionpbx.git /var/www/fusionpbx

COPY nginx-fusionpbx.conf /etc/nginx/sites-available/default
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80 5060/tcp 5060/udp 16384-16393/udp

CMD ["/usr/bin/supervisord"]
