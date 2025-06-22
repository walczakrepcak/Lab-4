#!/bin/bash

# Uzycie konstrukcji 'case' dla elastycznego parsowania argumentow
case "$1" in
    "--date")
        echo "Dzisiejsza data: $(date +%Y-%m-%d)"
        ;;
    "--logs")
        # Okreslenie liczby plikow logow do utworzenia. Domyślnie 100, jesli drugi argument jest pusty.
        NUM_FILES=${2:-100}
        for i in $(seq 1 "$NUM_FILES"); do
            FILENAME="log${i}.txt"
            # Zapis nazwy pliku, nazwy skryptu i daty do pliku
            echo "Nazwa pliku: $FILENAME" > "$FILENAME"
            echo "Nazwa skryptu: skrypt.sh" >> "$FILENAME"
            echo "Data utworzenia: $(date +%Y-%m-%d_%H-%M-%S)" >> "$FILENAME"
        done
        echo "Utworzono ${NUM_FILES} plikow logx.txt."
        ;;
    # Tutaj beda dodawane kolejne warunki dla flag, np. --help, --init, --error
    # ...
    *)
        # Domyślny komunikat dla nieznanych opcji
        echo "Nieznana opcja. Uzyj --help aby zobaczyc dostepne opcje."
        ;;
esac
