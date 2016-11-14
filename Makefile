GOFMT_FILES?=$$(find . -name '*.go' | grep -v vendor)
TEST?=$$(go list ./...)
PACKAGE=github.com/foodpanda/kmstool

.PHONY: help

default: build

help:
	@echo "KMSTool help\n-------------"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

fmt:	## Fix fmt errors in files
	gofmt -w $(GOFMT_FILES)

test: ## Run tests and checks
	go test $(TEST) -v -timeout=30s -parallel=4

build:	## Generate go binary
	go get
	go install
	go generate

release: build ## Make release
	mkdir -p release
	GOOS=linux GOARCH=amd64 go build -o release/kmstool-linux-amd64 $(package)
	GOOS=linux GOARCH=386 go build -o release/kmstool-linux-386 $(package)
	GOOS=linux GOARCH=arm go build -o release/kmstool-linux-arm $(package)

