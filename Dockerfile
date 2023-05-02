# Use the official nginx image as the base
FROM nginx:1.24.0 AS base

# Install build-time dependencies
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        wget \
        git \
        libpcre3-dev

# Download and extract the Nginx source code
ENV NGINX_VERSION nginx-1.24.0
RUN wget --no-check-certificate http://nginx.org/download/1.24.0.tar.gz \
    && tar -xvf 1.24.0.tar.gz

# Clone ngx_http_proxy_connect_module repository
RUN git clone https://github.com/chobits/ngx_http_proxy_connect_module.git

# Build Nginx with ngx_http_proxy_connect_module
RUN cd 1.24.0 \
    && ./configure --with-compat --add-dynamic-module=../ngx_http_proxy_connect_module \
    && make modules \
    && cp objs/ngx_http_proxy_connect_module.so /usr/lib/nginx/modules/

# Copy the built ngx_http_proxy_connect_module.so
FROM nginx:1.24.0

COPY --from=base /usr/lib/nginx/modules/ngx_http_proxy_connect_module.so /usr/lib/nginx/modules/

# Copy the nginx configuration file into the image
COPY nginx.conf /etc/nginx/nginx.conf