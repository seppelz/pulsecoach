#!/bin/bash

# Create directories
mkdir -p sdk/bin sdk/lib

# Set SDK version
SDK_VERSION="7.4.3"
SDK_FILE="connectiq-sdk-lin-${SDK_VERSION}.zip"

# Download SDK tools
wget "https://developer.garmin.com/downloads/connect-iq/sdks/${SDK_FILE}"

# Extract SDK
unzip "${SDK_FILE}" -d sdk/

# Cleanup
rm "${SDK_FILE}"

echo "SDK ${SDK_VERSION} setup complete!" 