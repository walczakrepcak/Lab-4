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
    "--init")
        # Pobranie URL zdalnego repozytorium
        REPO_URL=$(git config --get remote.origin.url)
        if [ -z "$REPO_URL" ]; then
            echo "Blad: Nie mozna znalezc URL zdalnego repozytorium."
            exit 1
        fi

        CURRENT_DIR=$(pwd) # Aktualny katalog
        CLONE_DIR=$(basename "$REPO_URL" .git) # Nazwa katalogu na podstawie nazwy repozytorium (bez .git)

        echo "Klonowanie repozytorium '$REPO_URL' do '$CLONE_DIR' w biezacym katalogu..."
        git clone "$REPO_URL" "$CLONE_DIR"

        if [ $? -eq 0 ]; then # Sprawdzenie, czy klonowanie sie powiodlo
            echo "Klonowanie zakonczone sukcesem. Dodawanie '$CLONE_DIR' do zmiennej PATH."
            # Dodanie do PATH tymczasowo dla biezacej sesji terminala
            export PATH="$PATH:$CURRENT_DIR/$CLONE_DIR"
            echo "PATH zaktualizowana. Aby zmiana byla trwala, dodaj 'export PATH=\$PATH:\$CURRENT_DIR/\$CLONE_DIR' do pliku .bashrc/.profile"
            echo "Sprawdz nowa sciezke PATH komenda: echo \$PATH"
        else
            echo "Blad podczas klonowania repozytorium. Upewnij sie, ze katalog docelowy nie istnieje i masz uprawnienia."
        fi
        ;;
    "--help") # Tutaj powinien być już wstępny help, rozbudujemy go później
        echo "Uzycie: skrypt.sh [OPCJA] [ARGUMENT]"
        echo ""
        echo "Opcje:"
        echo "  --date         : Wyswietla dzisiejsza date w formacie RRRR-MM-DD."
        echo "  --logs [LICZBA]: Tworzy pliki logx.txt. Domyślnie 100 plikow."
        echo "                   Kazdy plik zawiera swoja nazwe, nazwe skryptu i date."
        echo "  --init         : Klonuje aktualne repozytorium do biezacego katalogu i dodaje je do zmiennej PATH (tymczasowo)."
        echo "  --help         : Wyswietla ten komunikat pomocy."
        ;;
    *)
        # Domyślny komunikat dla nieznanych opcji
        echo "Nieznana opcja. Uzyj --help aby zobaczyc dostepne opcje."
        ;;
    "--error" | "-e")
        NUM_ERRORS=${2:-100} # Domyślnie 100, jeśli $2 jest puste
        for i in $(seq 1 "$NUM_ERRORS"); do
            ERROR_DIR="error${i}"
            ERROR_FILE="${ERROR_DIR}/error${i}.txt"
            mkdir -p "$ERROR_DIR" # Tworzy katalog, jeśli nie istnieje
            echo "To jest plik bledu $i." > "$ERROR_FILE"
            echo "Utworzono $ERROR_FILE"
        done
        echo "Utworzono ${NUM_ERRORS} plikow bledow."
        ;;
    *)
        echo "Nieznana opcja. Uzyj --help lub -h aby zobaczyc dostepne opcje."
        ;;
esac
