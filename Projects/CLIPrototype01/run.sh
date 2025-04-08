#!/bin/bash

cd "$(dirname "$0")"

swiftc \
  CLIPrototype01/*.swift \
  CLIPrototype01/Models/*.swift \
  CLIPrototype01/Utils/*.swift \
  CLIPrototype01/Data/*.swift \
  -o runJourney

./runJourney