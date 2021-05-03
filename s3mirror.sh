#!/bin/bash

mc alias set source https://${source_endpoint} ${source_access_key} ${source_secret_key}
mc alias set dest https://${dest_endpoint} ${dest_access_key} ${dest_secret_key}

mc mirror source/${source_bucket}${source_prefix} dest/${dest_bucket}${dest_prefix}
