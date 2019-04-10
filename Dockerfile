FROM golang:1.12 AS builder
WORKDIR /build/influxdb_stats_exporter/
COPY go.mod go.sum ./
RUN go mod tidy
COPY . .
RUN make build

FROM busybox:glibc
EXPOSE 9424
USER nobody

COPY --from=builder /build/influxdb_stats_exporter/influxdb_stats_exporter /influxdb_stats_exporter

ENTRYPOINT ["/influxdb_stats_exporter"]
