#!/bin/bash
set -eu

# $1 will be -w and $2 will be a file under /tmp. See fmt.vim where -w always
# gets added.
gofmt -s -w "$2"
goimports -w "$2"
