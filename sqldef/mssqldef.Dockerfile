FROM golang:1.24.6-bullseye AS build

COPY ./source /app
WORKDIR /app/cmd/mssqldef

ARG VERSION

RUN go build -o mssqldef -tags netgo -installsuffix netgo -ldflags "-w -s -X main.version=${VERSION}"

FROM gcr.io/distroless/static-debian12:debug-nonroot

COPY --from=build /app/cmd/mssqldef/mssqldef /app/


ENTRYPOINT [ "sh", "-c", "/app/mssqldef" ]