#!/bin/bash

if [ "$1" == "--date" ]; then
    echo "Dzisiejsza data: $(date +%Y-%m-%d)"
elif [ "$1" == "--logs" ]; then
    NUM_FILES=${2:-100}
    for i in $(seq 1 "$NUM_FILES"); do
        FILENAME="log${i}.txt"
        echo "Nazwa pliku: $FILENAME" > "$FILENAME"
        echo "Nazwa skryptu: skrypt.sh" >> "$FILENAME"
        echo "Data utworzenia: $(date +%Y-%m-%d_%H-%M-%S)" >> "$FILENAME"
    done
    echo "Utworzono ${NUM_FILES} plikow logx.txt."
elif [ "$1" == "--help" ]; then
    echo "Uzycie: skrypt.sh [OPCJA] [ARGUMENT]"
    echo ""
    echo "Opcje:"
    echo "  --date         : Wyswietla dzisiejsza date w formacie RRRR-MM-DD."
    echo "  --logs [LICZBA]: Tworzy pliki logx.txt. Domyślnie 100 plikow."
    echo "                   Kazdy plik zawiera swoja nazwe, nazwe skryptu i date."
    echo "  --help         : Wyswietla ten komunikat pomocy."
else
    echo "Nieznana opcja. Uzyj --help aby zobaczyc dostepne opcje."
fi
