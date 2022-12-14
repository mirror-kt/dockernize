FROM --platform=$BUILDPLATFORM golang:1.19.4-bullseye AS build

COPY ./source /app
WORKDIR /app/cmd/mysqldef

ARG VERSION

RUN go build -o mysqldef -tags netgo -installsuffix netgo -ldflags "-w -s -X main.version=${VERSION}"

FROM scratch

COPY --from=build /app/cmd/mysqldef/mysqldef /app

CMD [ "/app/mysqldef" ]