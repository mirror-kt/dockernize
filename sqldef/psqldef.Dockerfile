FROM golang:1.19.4-bullseye AS build

COPY ./source /app
WORKDIR /app/cmd/psqldef

ARG VERSION

RUN go build -o psqldef -tags netgo -installsuffix netgo -ldflags "-w -s -X main.version=${VERSION}"

FROM scratch

COPY --from=build /app/cmd/psqldef/psqldef /app/

CMD [ "/app/psqldef" ]