## Steps to start

## Run App

    docker compose up -d

## Add Data 1

    curl -X POST "localhost:9200/sample_index/_doc/1" -H 'Content-Type: application/json' -d'
    {
      "user": "Apple",
      "post_date": "2023-11-21T14:12:12",
      "message": "testing Elasticsearch with Apple"
    }
## Add Data 2

    curl -X POST "localhost:9200/sample_index/_doc/1" -H 'Content-Type: application/json' -d'
    {
      "user": "Apple",
      "post_date": "2023-11-21T14:12:12",
      "message": "testing Elasticsearch with Apple"
    }

## Restart App

    docker compose retart

## Test Data

    curl -X GET "localhost:9200/sample_index/_search?pretty"
