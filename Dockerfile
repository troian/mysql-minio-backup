# Then build our backup image
FROM mariadb
LABEL maintainer="Artur Troian <troian.ap@gmail.com>"
LABEL "org.opencontainers.image.source"="https://github.com/troian/mysql-minio-backup"

# Install the latest ca-certificates package to resolve Lets Encrypt auth issues
RUN apt update && apt install ca-certificates

COPY --from=minio/mc /usr/bin/mc /usr/bin/mc

ENV MINIO_SERVER=""
ENV MINIO_BUCKET="backups"
ENV MINIO_ACCESS_KEY=""
ENV MINIO_SECRET_KEY=""
ENV MINIO_API_VERSION="S3v4"

ENV DATE_FORMAT="+%Y-%m-%d"

ADD entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT [ "/app/entrypoint.sh" ]
