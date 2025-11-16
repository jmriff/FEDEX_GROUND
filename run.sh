#!/usr/bin/bash

# Color output text using ANSI escape codes
RED='\033[0;31m' # Red
NC='\033[0m' # No Color


# Remember:  add "Trade Documents Upload API" API to project on developer.fedex.com

ENDPOINT_TOKEN="https://apis-sandbox.fedex.com/oauth/token"
ENDPOINT_SHIPPING="https://apis-sandbox.fedex.com/ship/v1/shipments"
ENDPOINT_UPLOADIMAGE="https://documentapitest.prod.fedex.com/sandbox/documents/v1/lhsimages/upload"

CLIENT_ID="l732c7277d3cb64683bac0afbe6dc25e2c"
CLIENT_SECRET="57a47eac06c344088d8dcdd81e832e6f"


clear

##
##  Generate Token
echo "First call :: Generate OAuth 2.0 Bearer Token"
echo -e "${RED}API:  API Authorization${NC}"

responseToken=`curl --silent -X POST "${ENDPOINT_TOKEN}" \
   -H "Content-Type: application/x-www-form-urlencoded" \
   -d "grant_type=client_credentials&client_id=${CLIENT_ID}&client_secret=${CLIENT_SECRET}"`

echo $responseToken | jq '.' 
bearer_token=`echo $responseToken | jq -r '.access_token'`  #  Store access token in $bearer_token


##
##  Create Shipping Label
echo -e "\n\nSecond call :: Create shipping label for shipment."
echo -e "${RED}API:  Ship${NC}"

curl --compressed --output response.json \
   -H "Authorization: Bearer ${bearer_token}" \
   -H "Content-Type: application/json" \
   -H "x-locale:  en_US" \
   -H "x-customer-transaction-id:  624deea6-b709-470c-8c39-4b5511281492" \
   -d @request.json \
   "${ENDPOINT_SHIPPING}"

echo -e "\n\nHit <enter> to see the RESPONSE from FedEx..."
read a
cat response.json | jq | less
