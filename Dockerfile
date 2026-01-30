# Stage 1: Builder (Node 20)
FROM node:20 AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build -- --configuration production --output-path=/dist

# Stage 2: Nginx
FROM nginx:1.24

# 1. Copiamos la plantilla en lugar del conf directo
COPY nginx.conf.template /etc/nginx/nginx.conf.template

# 2. Copiamos el script de entrypoint
COPY entrypoint.sh /docker-entrypoint.sh

# 3. Damos permisos de ejecución al script
RUN chmod +x /docker-entrypoint.sh

# 4. Limpiamos y copiamos el build de Angular
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /dist/browser /usr/share/nginx/html

EXPOSE 8080

# 5. Definimos nuestro script como el punto de entrada
ENTRYPOINT ["/docker-entrypoint.sh"]

# 6. El comando final sigue siendo arrancar nginx
CMD ["nginx", "-g", "daemon off;"]