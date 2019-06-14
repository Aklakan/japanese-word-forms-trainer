SHELL := /bin/bash

src/components/data.json: data.csv data-to-json.sparql
	sparql-integrate --jq data-to-json.sparql <(echo 'SELECT DISTINCT ?s { ?s ?p ?o }') | jq '.[].s' | jq -s . > src/components/data.json

