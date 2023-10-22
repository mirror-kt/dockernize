FROM golang:1.21.3-bullseye AS build

COPY ./source /app
WORKDIR /app/cmd/mysqldef

ARG VERSION

RUN go build -o mysqldef -tags netgo -installsuffix netgo -ldflags "-w -s -X main.version=${VERSION}"

FROM scratch

COPY --from=build /app/cmd/mysqldef/mysqldef /app/

ENTRYPOINT [ "/app/mysqldef" ]