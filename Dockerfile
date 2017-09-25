# version: v1.2.20160215

FROM registry.cn-hangzhou.aliyuncs.com/marmot/phpfpm-7.0-base:1.0 
ADD ./libmemcached-1.0.18.tar.gz /data/php7extension/libmemcached
ADD ./php7memcached.tar.gz /data/php7extension/memcached
ADD ./php7apcu.tar.gz /data/php7extension/apcu
ADD ./composer.phar /usr/local/bin/composer
ADD ./confd /usr/local/bin/confd
ADD ./marmot.so /usr/local/lib/php/extensions/no-debug-zts-20151012/

RUN apt-get update && apt-get install -y zlib1g-dev git libmemcached-dev  && rm -r /var/lib/apt/lists/* \ 
&& chmod 755 /usr/local/bin/composer \
&& pecl channel-update pecl.php.net \
&& cd /data/php7extension/libmemcached/libmemcached-1.0.18/ \
&& ./configure \
&& make \
&& make install \
&& make clean \
&& cd /data/php7extension/memcached/ \
&& phpize \
&& ./configure \
	 --disable-memcached-sasl \
&& make \
&& make install \
&& make clean \
&& echo "extension=memcached.so" > /usr/local/etc/php/conf.d/memcached.ini \
&& cd /data/php7extension/apcu/ \
&& phpize \
&& ./configure \
&& make \
&& make install \
&& make clean \
&& echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini \
&& pecl install redis \
&& echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
&& pecl install mongodb \
&& echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongodb.ini \
&& echo "extension=marmot.so" > /usr/local/etc/php/conf.d/marmot.ini \
&& set -ex \
&& { \
        echo 'zend_extension=opcache.so'; \
        echo 'opcache.enable=1'; \
        echo 'opcache.enable_cli=1'; \
        echo 'opcache.huge_code_pages=1'; \
} | tee /usr/local/etc/php/conf.d/opcache.ini \
&& { \
        echo 'post_max_size = 5M'; \
        echo "date.timezone = 'PRC'"; \
        echo "memory_limit = '256M'"; \
        echo 'display_errors = off'; \
        echo 'html_errors  = off'; \
        echo 'log_errors = on'; \
        echo 'expose_php = off'; \
} | tee /usr/local/etc/php/conf.d/core.ini \
&& sed -i -e '/pm.max_children/s/5/100/' \
-e '/pm.start_servers/s/2/40/' \
-e '/pm.min_spare_servers/s/1/20/' \
-e '/pm.max_spare_servers/s/3/60/' \
-e 's/;slowlog = log\/$pool.log.slow/slowlog = \/proc\/self\/fd\/2/1' \
-e 's/;request_slowlog_timeout = 0/request_slowlog_timeout = 5s/1' \
/usr/local/etc/php-fpm.d/www.conf \
&& rm -rf /data/php7extension \
