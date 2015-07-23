#!/bin/sh

set -e

./_createlink "$0"
