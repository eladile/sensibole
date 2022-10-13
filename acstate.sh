#!/bin/bash

if [[ -z "${APIKey}" ]]; then
  ACApiKey="your APIKey from sensibo website here"
else
  ACApiKey="${APIKey}"
fi

PodID="$(curl -sSH "Accept: application/json" "https://home.sensibo.com/api/v2/users/me/pods?apiKey=$ACApiKey" | jq -r .result[0].id)"

ACStatus() {
	curl -sSH "Accept: application/json" "https://home.sensibo.com/api/v2/pods/$PodID/acStates?apiKey=$ACApiKey&limit=1&fields=acState" | jq .
}

ACON() {
	curl -XPOST -sSH "Accept: application/json" "https://home.sensibo.com/api/v2/pods/$PodID/acStates?apiKey=$ACApiKey"  -d '{ "acState": {"on": true} }' | jq .
}

ACOFF() {
	curl -XPOST -sSH "Accept: application/json" "https://home.sensibo.com/api/v2/pods/$PodID/acStates?apiKey=$ACApiKey"  -d '{ "acState": {"on": false} }' | jq .
}


