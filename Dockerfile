FROM golang:1.19 AS builder
WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY wordcount/ /app/wordcount/
WORKDIR /app/wordcount
RUN GOOS=linux GOARCH=amd64 go build -o wordcount .

FROM gcr.io/dataflow-templates-base/go-template-launcher-base AS runtime
ARG WORKDIR=/dataflow/template
RUN mkdir -p ${WORKDIR}
COPY --from=builder /app/wordcount/wordcount ${WORKDIR}/wordcount
ENV FLEX_TEMPLATE_GO_BINARY="${WORKDIR}/wordcount"
ENTRYPOINT ["/opt/google/dataflow/go_template_launcher"]
