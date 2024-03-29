FROM golang:1.13.4-buster as build
WORKDIR /go/src/app
COPY . .
ENV GO111MODULE on
RUN go build -o /go/bin/app
FROM gcr.io/distroless/base
ENV ADDRESS localhost:6379
ENV PASSWORD ""
COPY --from=build /go/bin/app /
COPY --from=build /go/src/app/templates /templates
COPY --from=build /go/src/app/static /static
CMD ["/app"]
EXPOSE 8080