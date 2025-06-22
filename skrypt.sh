#!/bin/bash

case "$1" in
    "--date" | "-d")
        echo "Dzisiejsza data: $(date +%Y-%m-%d)"
        ;;
    "--logs" | "-l")
        NUM_FILES=${2:-100}
        for i in $(seq 1 "$NUM_FILES"); do
            FILENAME="log${i}.txt"
            echo "Nazwa pliku: $FILENAME" > "$FILENAME"
            echo "Nazwa skryptu: skrypt.sh" >> "$FILENAME"
            echo "Data utworzenia: $(date +%Y-%m-%d_%H-%M-%S)" >> "$FILENAME"
        done
        echo "Utworzono ${NUM_FILES} plikow logx.txt."
        ;;
    "--help" | "-h")
        echo "Uzycie: skrypt.sh [OPCJA] [ARGUMENT]"
        echo ""
        echo "Opcje:"
        echo "  --date (-d)          : Wyswietla dzisiejsza date w formacie RRRR-MM-DD."
        echo "  --logs (-l) [LICZBA]: Tworzy pliki logx.txt. Domyślnie 100 plikow."
        echo "                         Kazdy plik zawiera swoja nazwe, nazwe skryptu i date."
        echo "  --help (-h)          : Wyswietla ten komunikat pomocy."
        ;;
    *)
        echo "Nieznana opcja. Uzyj --help lub -h aby zobaczyc dostepne opcje."
        ;;
esac
