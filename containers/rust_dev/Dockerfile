#make container for rustup
FROM debian
RUN apt update && apt install -y curl ncurses-term clang locales
RUN echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen
ENV RUSTUP_HOME="/home/pooman123/文档/代码/.rust_install/rustup" \
    CARGO_HOME="/home/pooman123/文档/代码/.rust_install/cargo"
RUN echo ". \"$CARGO_HOME/env\"" >> /root/.profile
