  gcloud dataflow flex-template build gs://my-storage-stunning-system-370901/samples/dataflow/templates/wordcount-go.json ^
     --image us-west1-docker.pkg.dev/stunning-system-370901/my-repository/dataflow/wordcount-go:latest ^
     --sdk-language GO ^
     --metadata-file wordcount/metadata.json
