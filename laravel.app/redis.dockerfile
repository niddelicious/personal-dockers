FROM redis:2

ENV REDIS_USER=redis \
    REDIS_DATA_DIR=/var/lib/redis \
    REDIS_LOG_DIR=/var/log/redis

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y redis-server \
	&& sed 's/^daemonize yes/daemonize no/' -i /etc/redis/redis.conf \
	&& sed 's/^bind 127.0.0.1/bind 0.0.0.0/' -i /etc/redis/redis.conf \
	&& sed 's/^# unixsocket /unixsocket /' -i /etc/redis/redis.conf \
	&& sed 's/^# unixsocketperm 755/unixsocketperm 777/' -i /etc/redis/redis.conf \
	&& sed '/^logfile/d' -i /etc/redis/redis.conf \
	&& rm -rf /var/lib/apt/lists/*

EXPOSE 6379/tcp