#!/bin/sh
gcloud dataflow flex-template run "wordcount-go-`date +%Y%m%d-%H%M%S`" \
    --template-file-gcs-location "gs://BUCKET_NAME/samples/dataflow/templates/wordcount-go.json" \
    --parameters output="gs://BUCKET_NAME/samples/dataflow/templates/counts.txt" \
    --region "REGION"