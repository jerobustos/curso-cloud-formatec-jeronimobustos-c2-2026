FROM nginx:1.27-alpine
ARG APP_VERSION=dev
LABEL org.opencontainers.image.title="banco-patacon-status"
LABEL org.opencontainers.image.revision="${APP_VERSION}"
COPY home.html /usr/share/nginx/html/index.html
EXPOSE 80
HEALTHCHECK --interval=10s --timeout=3s --retries=3 \
  CMD wget -qO- http://127.0.0.1/ >/dev/null || exit 1