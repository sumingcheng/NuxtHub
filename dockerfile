# Build stage
FROM node:18.17-alpine AS builder
WORKDIR /model-hub

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk add --no-cache libc6-compat

ENV PNPM_REGISTRY=https://registry.npmmirror.com
RUN npm install -g pnpm@8.6.2

COPY package.json pnpm-lock.yaml* ./
RUN pnpm install --registry=${PNPM_REGISTRY}

COPY . .

RUN pnpm run build --registry=${PNPM_REGISTRY}

# Production stage
FROM node:18.17-alpine AS production
WORKDIR /model-hub

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk add --no-cache libc6-compat

# Copy the build output and necessary config files
COPY --from=builder /model-hub/.output ./output
COPY --from=builder /model-hub/package.json ./
COPY --from=builder /model-hub/pnpm-lock.yaml* ./
COPY --from=builder /model-hub/public ./public

ENV PNPM_REGISTRY=https://registry.npmmirror.com
RUN npm install -g pnpm@8.6.2 && \
    pnpm install --registry=${PNPM_REGISTRY}

EXPOSE 3000
CMD ["node", "output/server/index.mjs"]
