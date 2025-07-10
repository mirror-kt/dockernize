FROM golang:1.24.5-bullseye AS build

COPY ./source /app
WORKDIR /app/cmd/mssqldef

ARG VERSION

RUN go build -o mssqldef -tags netgo -installsuffix netgo -ldflags "-w -s -X main.version=${VERSION}"

FROM scratch

COPY --from=build /app/cmd/mssqldef/mssqldef /app/


ENTRYPOINT [ "/app/mssqldef" ]