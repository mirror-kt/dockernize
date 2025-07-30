FROM golang:1.24.5-bullseye AS build

COPY ./source /app
WORKDIR /app/cmd/psqldef

ARG VERSION

RUN go build -o psqldef -tags netgo -installsuffix netgo -ldflags "-w -s -X main.version=${VERSION} -linkmode external -extldflags -static"

FROM gcr.io/distroless/static-debian12:debug-nonroot

COPY --from=build /app/cmd/psqldef/psqldef /app/

ENTRYPOINT [ "/app/psqldef" ]