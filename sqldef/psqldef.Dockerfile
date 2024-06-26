FROM golang:1.22.3-bullseye AS build

COPY ./source /app
WORKDIR /app/cmd/psqldef

ARG VERSION

RUN go build -o psqldef -tags netgo -installsuffix netgo -ldflags "-w -s -X main.version=${VERSION} -linkmode external -extldflags -static"

FROM scratch

COPY --from=build /app/cmd/psqldef/psqldef /app/

ENTRYPOINT [ "/app/psqldef" ]