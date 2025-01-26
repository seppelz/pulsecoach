#!/bin/bash

# Set SDK paths
export CIQ_HOME="/home/sebastian/.Garmin/ConnectIQ"
export CIQ_SDK_PATH="$CIQ_HOME/Sdks/connectiq-sdk-lin-7.4.3-2024-12-11-90ec25e45"
export PATH="$CIQ_SDK_PATH/bin:$PATH"

# Create output directory if it doesn't exist
mkdir -p bin

# Build the app
"$CIQ_SDK_PATH/bin/monkeyc" \
  -d fr245m \
  -f monkey.jungle \
  -o bin/PulseCoach.prg \
  -y developer-key/developer_key.der \
  --warn 