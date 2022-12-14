FROM golang:1.19.4-bullseye AS build

COPY ./source /app
WORKDIR /app/cmd/mssqldef

ARG VERSION

RUN go build -o mssqldef -tags netgo -installsuffix netgo -ldflags "-w -s -X main.version=${VERSION}"

FROM scratch

COPY --from=build /app/cmd/mssqldef/mssqldef /app

CMD [ "/app/mssqldef" ]