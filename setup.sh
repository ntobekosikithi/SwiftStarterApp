#!/bin/bash

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Setting up Swift Starter Project...${NC}"

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Homebrew not found. Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to install Homebrew. Please install it manually from https://brew.sh${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}Homebrew already installed.${NC}"
fi

# Check if XcodeGen is installed
if ! command -v xcodegen &> /dev/null; then
    echo -e "${YELLOW}XcodeGen not found. Installing XcodeGen...${NC}"
    brew install xcodegen
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}Failed to install XcodeGen. Please install it manually with 'brew install xcodegen'${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}XcodeGen already installed.${NC}"
fi

# Generate Xcode project
echo -e "${YELLOW}Generating Xcode project...${NC}"
xcodegen generate

if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to generate Xcode project. Please check the error message above.${NC}"
    exit 1
fi

echo -e "${GREEN}Xcode project generated successfully.${NC}"
echo -e "${YELLOW}Opening Xcode project...${NC}"

# Open the Xcode project
open SwiftStarterApp.xcodeproj

echo -e "${GREEN}Setup complete!${NC}"
echo -e "${YELLOW}You can now build and run the project in Xcode.${NC}" 