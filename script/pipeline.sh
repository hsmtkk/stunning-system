#!/bin/sh
gcloud dataflow flex-template run "wordcount-go-`date +%Y%m%d-%H%M%S`" \
    --template-file-gcs-location "gs://my-storage-stunning-system-370901/samples/dataflow/templates/wordcount-go.json" \
    --parameters output="gs://my-storage-stunning-system-370901/samples/dataflow/templates/counts.txt" \
    --region us-west1
