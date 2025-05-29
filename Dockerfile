# 使用官方发行版二进制，避免编译/上下文问题
FROM alpine:3.18

# 安装必要依赖
RUN apk add --no-cache wget ca-certificates \
    && update-ca-certificates

# 下载并安装最新 ttyd 二进制（示例为 v1.7.3，请根据需要替换版本）
ENV TTYD_VERSION=1.7.3
RUN wget -O /tmp/ttyd.tar.gz \
    https://github.com/tsl0922/ttyd/releases/download/${TTTYD_VERSION}/ttyd_linux_amd64.tar.gz \
    && tar -zxC /usr/local/bin -f /tmp/ttyd.tar.gz --strip-components=1 \
    && rm /tmp/ttyd.tar.gz

# 创建工作目录
WORKDIR /root

# 暴露默认端口
EXPOSE 7681

# 环境变量：端口与终端命令可自定义
ENV TTYD_PORT=7681
ENV TTYD_COMMAND=bash

# 启动 ttyd，使用基本认证 user:password
ENTRYPOINT ["ttyd", "-p", "${TTYD_PORT}", "-c", "user:password", "${TTYD_COMMAND}"]
