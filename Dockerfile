# Use the official nginx image as the base
FROM nginx:latest AS base

# Install build-time dependencies
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        wget \
        git

# Download and extract the Nginx source code
ENV NGINX_VERSION nginx-1.23.4
RUN wget --no-check-certificate http://nginx.org/download/${NGINX_VERSION}.tar.gz \
    && tar -xvf ${NGINX_VERSION}.tar.gz

# Clone ngx_http_proxy_connect_module repository
RUN git clone https://github.com/chobits/ngx_http_proxy_connect_module.git

# Build Nginx with ngx_http_proxy_connect_module
RUN cd ${NGINX_VERSION} \
    && ./configure --with-compat --add-dynamic-module=../ngx_http_proxy_connect_module \
    && make modules \
    && cp objs/ngx_http_proxy_connect_module.so /usr/lib/nginx/modules/

# Copy the built ngx_http_proxy_connect_module.so
FROM nginx:latest

COPY --from=base /usr/lib/nginx/modules/ngx_http_proxy_connect_module.so /usr/lib/nginx/modules/

# Copy the nginx configuration file into the image
COPY nginx.conf /etc/nginx/nginx.conf

# Add the following line at the beginning of the `http` block in nginx.conf:
# load_module modules/ngx_http_proxy_connect_module.so;