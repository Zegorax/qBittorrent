FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY qbittorrent.AppImage /tmp/qbittorrent.AppImage

RUN chmod +x /tmp/qbittorrent.AppImage \
    && /tmp/qbittorrent.AppImage --appimage-extract \
    && mv squashfs-root /opt/qbittorrent \
    && rm /tmp/qbittorrent.AppImage \
    && ln -s /opt/qbittorrent/usr/bin/qbittorrent-nox /usr/local/bin/qbittorrent-nox

EXPOSE 8080

VOLUME ["/config", "/downloads"]

ENTRYPOINT ["/opt/qbittorrent/AppRun"]
CMD ["--confirm-legal-notice", "--webui-port=8080", "--profile=/config"]
