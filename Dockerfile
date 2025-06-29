# Build stage
FROM node:20 AS builder
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

# Cloud Run expects the container to listen on $PORT
ENV PORT 8080
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
