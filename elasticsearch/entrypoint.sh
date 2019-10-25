#!/bin/sh

until curl -X GET "es01:9200/_cluster/state/blocks" &> /dev/null 
do 
    echo "Waiting for elasticsearch to start"
    sleep 5
done

response=$(curl -s -o /dev/null/ -w "%{http_code}" -X GET "es01:9200/agenda_items")
echo $response
if [ $response != 200 ]; then
    curl -s -o /dev/null/ -X PUT "es01:9200/agenda_items" -H "Content-Type: application/json" -d'
    {
        "settings": {
            "number_of_shards" : 1
        },
        "mappings": {
            "dynamic":"strict",
            "properties": {
                "date": {
                        "type": "date"
                    },
                "agenda_item_id": {
                        "type": "long"
                    },
                "agenda_id": {
                        "type": "long"
                    },
                "title": {
                        "type": "text",
                        "index": "true",
                        "index_phrases": "true"
                    },
                "recommendations": {
                        "type": "text",
                        "index": "true",
                        "index_phrases": "true"
                    },
                "body": {
                        "type": "text",
                        "index": "true",
                        "index_phrases": "true"
                    },
                "department": {
                        "type": "keyword"
                    },
                "sponsors": {
                        "type": "text"
                    },
                "tags": {
                        "type": "keyword"
                    },
                "committee": {
                        "type": "text"
                    },
                "committee_id": {
                        "type": "long",
                        "index": "true"
                    }
            }
        }
    }
    '
    echo "Index created."
else
    echo "Index already exist."
fi