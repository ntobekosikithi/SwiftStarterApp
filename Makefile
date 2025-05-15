.PHONY: setup generate_project open

# Default task
all: setup

# Setup dependencies and generate project
setup:
	./setup.sh

# Generate Xcode project
generate_project:
	xcodegen generate

# Open Xcode project
open:
	open SwiftStarterApp.xcodeproj

# Clean derived data
clean:
	rm -rf ~/Library/Developer/Xcode/DerivedData/SwiftStarterApp-*

# Help
help:
	@echo "Available commands:"
	@echo "  make setup            - Setup dependencies and generate project"
	@echo "  make generate_project - Generate Xcode project"
	@echo "  make open             - Open Xcode project"
	@echo "  make clean            - Clean derived data" 