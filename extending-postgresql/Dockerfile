FROM postgres:alpine

COPY /docker-entrypoint-initdb.d/* /docker-entrypoint-initdb.d/

RUN set -eux \
	&& wget -O pgsql-http.tgz https://github.com/pramsey/pgsql-http/archive/refs/heads/master.tar.gz \
	&& tar zxfv pgsql-http.tgz \
	&& cd pgsql-http-master \
	&& apk add --no-cache --virtual .build-deps \
        clang19 \
        g++ \
        llvm19 \
        make \
        curl-dev \
	&& make \
	&& make install \
	&& cd .. \
	&& rm -rf pgsql-http* \
	&& apk del \
	    clang19 \
        g++ \
        llvm19 \
        make \
        curl-dev