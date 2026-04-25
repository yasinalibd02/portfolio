#!/bin/bash

# Remove any existing flutter directory to ensure a clean install
if [ -d "flutter" ]; then
  rm -rf flutter
fi

# Clone the stable branch of Flutter
echo "Cloning Flutter stable branch..."
git clone https://github.com/flutter/flutter.git -b stable --depth 1

# Add flutter to PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Print Flutter version
echo "Flutter version:"
flutter --version

# Disable analytics to avoid any prompt issues
flutter config --no-analytics

# Get dependencies
echo "Running flutter pub get..."
flutter pub get

# Build the web app
echo "Building Flutter Web app..."
flutter build web --release --no-source-maps

echo "Build successful!"
