#!/bin/bash

# Set SDK paths
export CIQ_HOME="$HOME/.Garmin/ConnectIQ"
export CIQ_SDK_PATH="$CIQ_HOME/Sdks/connectiq-sdk-lin-7.4.3-2024-12-11-90ec25e45"

# Create output directory
mkdir -p bin

# Kill any existing simulator processes
pkill -f simulator
sleep 2

# Set minimal environment variables
export DISPLAY=:0
export QT_QPA_PLATFORM=xcb

# Build the app
./build.sh || exit 1

# Run simulator
cd "$CIQ_SDK_PATH/bin" && \
./simulator \
  --configPath="$CIQ_HOME/Devices/fr245m/simulator.json" \
  --devicePath="$HOME/.Garmin/ConnectIQ/Devices/fr245m" \
  --debug 