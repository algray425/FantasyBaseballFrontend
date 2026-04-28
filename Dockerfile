# ── Stage 1: Build ──────────────────────────────────────────────
FROM ghcr.io/cirruslabs/flutter:stable AS builder
WORKDIR /app

# Cache dependencies first
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy source and build for web
COPY . .
RUN flutter build web --release

# ── Stage 2: Serve ──────────────────────────────────────────────
FROM nginx:alpine
WORKDIR /usr/share/nginx/html

RUN rm -rf ./*

COPY --from=builder /app/build/web .

EXPOSE 9393
ENTRYPOINT ["nginx", "-g", "daemon off;"]