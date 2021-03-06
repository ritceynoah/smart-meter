#!/bin/bash

## ./compose/combine_services.sh "_secrets" inject_metrics

SECRET_MODE="$1"
shift 1

source ./compose/services_hierachy.sh

targets=$(echo "$@" | sed s/["^ "]*/'$'\&/g)

eval echo "$targets" \
  | xargs -n1 | sort -u | xargs \
  | sed s/["^ "]*/"## "\&/g

docker run -v $(pwd)/compose:/files logimethods/yamlreader \
  $( eval echo "$targets" \
  | xargs -n1 | sort -u | xargs \
  | sed s/["^ "]*/docker-compose-\&.yml/g )

