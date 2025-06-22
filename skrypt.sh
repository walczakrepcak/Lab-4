#!/bin/bash

if [ "$1" == "--date" ]; then
    echo "Dzisiejsza data: $(date +%Y-%m-%d)"
fi
