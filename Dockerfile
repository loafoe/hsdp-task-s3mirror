FROM philipslabs/siderite:debian-v0.12.2 as siderite

FROM minio/mc:latest
COPY --from=siderite /app/siderite /usr/bin/siderite
COPY s3mirror.sh /usr/bin/s3mirror.sh
ENTRYPOINT ["siderite","task"]
