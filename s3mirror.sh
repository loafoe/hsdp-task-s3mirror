#!/bin/bash
ENCRYPT_INFO=""

if [[ -n ${source_sse_customer_key} ]]; then
  ENCRYPT_INFO="--encrypt-key source=${source_sse_customer_key}"
fi

if [[ -n ${dest_sse_customer_key} ]]; then
  ENCRYPT_INFO="--encrypt-key dest=${dest_sse_customer_key}"
fi

if [[ -n ${source_sse_customer_key} && -n ${dest_sse_customer_key} ]]; then
  ENCRYPT_INFO="--encrypt-key source=${source_sse_customer_key},dest=${dest_sse_customer_key}"
fi

mc alias set source https://${source_endpoint} ${source_access_key} ${source_secret_key}
mc alias set dest https://${dest_endpoint} ${dest_access_key} ${dest_secret_key}

mc mirror --overwrite source/${source_bucket}${source_prefix} dest/${dest_bucket}${dest_prefix} ${ENCRYPT_INFO}
