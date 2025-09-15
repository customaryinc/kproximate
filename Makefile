.PHONY: test build lint helm-lint clean

# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GOTEST=$(GOCMD) test
GOMOD=$(GOCMD) mod

# Build the application
build:
	cd kproximate && $(GOBUILD) -v ./...

# Run tests
test:
	cd kproximate && $(GOTEST) -v ./...

# Run tests with coverage
test-coverage:
	cd kproximate && $(GOTEST) -v -coverprofile=coverage.out ./...
	cd kproximate && $(GOCMD) tool cover -html=coverage.out -o coverage.html

# Lint Go code
lint:
	cd kproximate && golangci-lint run

# Lint Helm chart
helm-lint:
	helm lint chart/kproximate

# Template Helm chart with example values
helm-template:
	helm template test chart/kproximate --values examples/example-values-with-taints.yaml

# Clean build artifacts
clean:
	cd kproximate && $(GOCMD) clean
	cd kproximate && rm -f coverage.out coverage.html

# Tidy go modules
tidy:
	cd kproximate && $(GOMOD) tidy

# Run all checks (used by CI)
ci: tidy test lint helm-lint helm-template
