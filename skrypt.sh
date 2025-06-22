#!/bin/bash

if [ "$1" == "--date" ]; then
    echo "Dzisiejsza data: $(date +%Y-%m-%d)"
elif [ "$1" == "--logs" ]; then
    for i in $(seq 1 100); do
        FILENAME="log${i}.txt"
        echo "Nazwa pliku: $FILENAME" > "$FILENAME"
        echo "Nazwa skryptu: skrypt.sh" >> "$FILENAME"
        echo "Data utworzenia: $(date +%Y-%m-%d_%H-%M-%S)" >> "$FILENAME"
        echo "Utworzono $FILENAME"
    done
    echo "Utworzono 100 plikow logx.txt."
fi
