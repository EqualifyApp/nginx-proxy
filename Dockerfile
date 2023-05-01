# Use the official nginx image as the base
FROM nginx:latest

# Copy the nginx configuration file into the image
COPY nginx.conf /etc/nginx/nginx.conf
