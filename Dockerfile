# 直接使用 Alpine 社区包，避免下载失败
FROM alpine:3.18

# 安装 ttyd 和 ca-certificates
RUN apk add --no-cache ttyd ca-certificates \
    && update-ca-certificates

# 创建工作目录
WORKDIR /root

# 环境变量：端口与终端命令可自定义
ENV TTYD_PORT=7681
ENV TTYD_COMMAND=bash

# 暴露端口
EXPOSE ${TTYD_PORT}

# 启动 ttyd，使用基本认证 user:password
ENTRYPOINT ["ttyd", "-p", "${TTYD_PORT}", "-c", "user:password", "${TTYD_COMMAND}"]
