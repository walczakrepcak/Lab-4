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
    "--init")
        REPO_URL=$(git config --get remote.origin.url)
        if [ -z "$REPO_URL" ]; then
            echo "Blad: Nie mozna znalezc URL zdalnego repozytorium."
            exit 1
        fi
        CURRENT_DIR=$(pwd)
        CLONE_DIR=$(basename "$REPO_URL" .git)

        echo "Klonowanie repozytorium '$REPO_URL' do '$CLONE_DIR' w biezacym katalogu..."
        git clone "$REPO_URL" "$CLONE_DIR"
        if [ $? -eq 0 ]; then
            echo "Klonowanie zakonczone sukcesem. Dodawanie '$CLONE_DIR' do zmiennej PATH."
            export PATH="$PATH:$CURRENT_DIR/$CLONE_DIR"
            echo "PATH zaktualizowana. Sprawdz komenda: echo \$PATH"
        else
            echo "Blad podczas klonowania repozytorium."
        fi
        ;;
    "--error" | "-e")
        NUM_ERRORS=${2:-100}
        for i in $(seq 1 "$NUM_ERRORS"); do
            ERROR_DIR="error${i}"
            ERROR_FILE="${ERROR_DIR}/error${i}.txt"
            mkdir -p "$ERROR_DIR"
            echo "To jest plik bledu $i." > "$ERROR_FILE"
            echo "Utworzono $ERROR_FILE"
        done
        echo "Utworzono ${NUM_ERRORS} plikow bledow."
        ;;
    "--help" | "-h")
        echo "Uzycie: skrypt.sh [OPCJA] [ARGUMENT]"
        echo ""
        echo "Opcje:"
        echo "  --date (-d)          : Wyswietla dzisiejsza date w formacie RRRR-MM-DD."
        echo "  --logs (-l) [LICZBA]: Tworzy pliki logx.txt. Domyślnie 100 plikow."
        echo "                         Kazdy plik zawiera swoja nazwe, nazwe skryptu i date."
        echo "  --init               : Klonuje aktualne repozytorium do biezacego katalogu i dodaje do PATH."
        echo "  --error (-e) [LICZBA]: Tworzy pliki bledow errorx/errorx.txt. Domyślnie 100 plikow."
        echo "  --help (-h)          : Wyswietla ten komunikat pomocy."
        ;;
    *)
        echo "Nieznana opcja. Uzyj --help lub -h aby zobaczyc dostepne opcje."
        ;;
esac
