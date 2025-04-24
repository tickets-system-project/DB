#!/bin/bash

# Ustawienie ścieżki do pliku SQL
OUTPUT_FILE="dane2.sql"

# Funkcja do generowania losowego kodu potwierdzenia (8 znaków: duże litery lub cyfry)
generate_confirmation_code() {
  cat /dev/urandom | tr -dc 'A-Z0-9' | fold -w 8 | head -n 1
}

# Funkcja do generowania losowego kodu kolejki
generate_queue_code() {
  # Generuje 3 losowe litery i 3 cyfry
  local letters=$(cat /dev/urandom | tr -dc 'A-Z' | fold -w 3 | head -n 1)
  local numbers=$(cat /dev/urandom | tr -dc '0-9' | fold -w 3 | head -n 1)
  echo "${letters}${numbers}"
}

# Pobierz dzisiejszą datę
TODAY=$(date +%Y-%m-%d)

# Rozpocznij plik SQL
echo "-- Mockowe dane wygenerowane $(date)" > $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Dodaj komentarz informacyjny
echo "-- ================== UWAGA =================" >> $OUTPUT_FILE
echo "-- Skrypt usuwa istniejące dane z tabel:" >> $OUTPUT_FILE
echo "--  - Windows_and_Categories" >> $OUTPUT_FILE
echo "--  - Slots" >> $OUTPUT_FILE
echo "--  - Reservations" >> $OUTPUT_FILE
echo "--  - Queue" >> $OUTPUT_FILE
echo "-- ===========================================" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Dodaj instrukcje usuwające istniejące dane
echo "-- Usuwanie istniejących danych" >> $OUTPUT_FILE
echo "DELETE FROM \"Queue\";" >> $OUTPUT_FILE
echo "DELETE FROM \"Reservations\";" >> $OUTPUT_FILE
echo "DELETE FROM \"Slots\";" >> $OUTPUT_FILE
echo "DELETE FROM \"Windows_and_Categories\";" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Stałe
WINDOWS_COUNT=13
CATEGORIES_COUNT=13
CLERKS_STARTING_ID=2
CLERKS_ENDING_ID=10
CLERKS_COUNT=$((CLERKS_ENDING_ID - CLERKS_STARTING_ID + 1))

# Przygotowanie mapy przypisującej urzędników do kategorii
declare -A clerks_per_category
for category_id in $(seq 1 $CATEGORIES_COUNT); do
  # Przypisz 1-2 urzędników na kategorię (dla większych kategorii 2, dla mniejszych 1)
  if [ $category_id -le 6 ]; then
    clerks_per_category[$category_id]=2
  else
    clerks_per_category[$category_id]=1
  fi
done

# Generowanie danych dla Windows_and_Categories
echo "-- Generowanie danych dla Windows_and_Categories" >> $OUTPUT_FILE
echo "INSERT INTO \"Windows_and_Categories\" (\"WindowID\", \"CategoryID\", \"Date\", \"ClerkID\") VALUES" >> $OUTPUT_FILE

FIRST=true
WINDOW_COUNTER=1

for i in {-7..7}; do
  CURRENT_DATE=$(date -d "@$(($(date +%s) + $i*86400))" +%Y-%m-%d)


  # Resetujemy licznik okien dla każdego dnia
  WINDOW_COUNTER=1

  # Reset dostępnych urzędników dla każdego dnia
  AVAILABLE_CLERKS=()
  for CLERK_ID in $(seq $CLERKS_STARTING_ID $CLERKS_ENDING_ID); do
    AVAILABLE_CLERKS+=($CLERK_ID)
  done

  # Mieszanie tablicy urzędników
  for ((j=0; j<${#AVAILABLE_CLERKS[@]}; j++)); do
    random_index=$((RANDOM % ${#AVAILABLE_CLERKS[@]}))
    temp=${AVAILABLE_CLERKS[$j]}
    AVAILABLE_CLERKS[$j]=${AVAILABLE_CLERKS[$random_index]}
    AVAILABLE_CLERKS[$random_index]=$temp
  done

  available_clerk_index=0

  # Dla każdej kategorii przydziel odpowiednią liczbę urzędników i okien
  for CATEGORY_ID in $(seq 1 $CATEGORIES_COUNT); do
    clerks_needed=${clerks_per_category[$CATEGORY_ID]}

    for ((clerk_count=0; clerk_count<clerks_needed; clerk_count++)); do
      if [ $available_clerk_index -lt ${#AVAILABLE_CLERKS[@]} ]; then
        CLERK_ID=${AVAILABLE_CLERKS[$available_clerk_index]}
        available_clerk_index=$((available_clerk_index + 1))

        if [ "$FIRST" = true ]; then
          FIRST=false
        else
          echo "," >> $OUTPUT_FILE
        fi

        echo -n "($WINDOW_COUNTER, $CATEGORY_ID, '$CURRENT_DATE', $CLERK_ID)" >> $OUTPUT_FILE
        WINDOW_COUNTER=$((WINDOW_COUNTER + 1))
      fi
    done
  done
done
echo ";" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Generowanie danych dla Slots
echo "-- Generowanie danych dla Slots" >> $OUTPUT_FILE
echo "INSERT INTO \"Slots\" (\"CategoryID\", \"Date\", \"Time\", \"MaxReservations\", \"CurrentReservations\") VALUES" >> $OUTPUT_FILE

FIRST=true
for i in {-7..7}; do
  CURRENT_DATE=$(date -d "@$(($(date +%s) + $i*86400))" +%Y-%m-%d)

  # Dla każdej kategorii
  for CATEGORY_ID in $(seq 1 $CATEGORIES_COUNT); do
    # Ustaw MaxReservations równą liczbie urzędników dostępnych dla tej kategorii
    MAX_RESERVATIONS=${clerks_per_category[$CATEGORY_ID]}

    # Generowanie slotów co godzinę od 8:00 do 16:00
    for HOUR in {8..16}; do
      TIME=$(printf "%02d:00:00" $HOUR)

      # Początkowo nie ma rezerwacji
      CURRENT_RESERVATIONS=0

      if [ "$FIRST" = true ]; then
        FIRST=false
      else
        echo "," >> $OUTPUT_FILE
      fi

      echo -n "($CATEGORY_ID, '$CURRENT_DATE', '$TIME', $MAX_RESERVATIONS, $CURRENT_RESERVATIONS)" >> $OUTPUT_FILE
    done
  done
done
echo ";" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Generowanie danych dla Reservations
echo "-- Generowanie danych dla Reservations" >> $OUTPUT_FILE
echo "INSERT INTO \"Reservations\" (\"ClientID\", \"CategoryID\", \"StatusID\", \"Date\", \"Time\", \"ConfirmationCode\") VALUES" >> $OUTPUT_FILE

# Struktura do śledzenia liczby rezerwacji na każdą godzinę dla danej kategorii i daty
declare -A reservation_count

# Inicjalizacja liczników rezerwacji
for i in {-7..7}; do
  CURRENT_DATE=$(date -d "@$(($(date +%s) + $i*86400))" +%Y-%m-%d)
  for CATEGORY_ID in $(seq 1 $CATEGORIES_COUNT); do
    for HOUR in {8..16}; do
      TIME=$(printf "%02d:00:00" $HOUR)
      reservation_count["$CURRENT_DATE,$CATEGORY_ID,$TIME"]=0
    done
  done
done

# Generuj rezerwacje
RESERVATION_ID=1
FIRST=true
QUEUE_DATA=()

for i in {-7..7}; do
  CURRENT_DATE=$(date -d "@$(($(date +%s) + $i*86400))" +%Y-%m-%d)
  TODAY_DATE=$(date +%Y-%m-%d)

  # Określ status na podstawie daty (przeszłość = 6, przyszłość = 1)
  if [[ "$CURRENT_DATE" < "$TODAY_DATE" ]]; then
    STATUS_ID=6  # Zakończona dla przeszłości
  else
    STATUS_ID=1  # W przygotowaniu dla przyszłości
  fi

  # Dla każdej kategorii
  for CATEGORY_ID in $(seq 1 $CATEGORIES_COUNT); do
    MAX_SLOTS=${clerks_per_category[$CATEGORY_ID]}

    # Generowanie rezerwacji dla kilku losowych godzin
    for HOUR in $(shuf -i 8-16 -n 5); do  # 5 losowych godzin z przedziału 8-16
      TIME=$(printf "%02d:00:00" $HOUR)
      KEY="$CURRENT_DATE,$CATEGORY_ID,$TIME"

      # Sprawdź czy nie przekroczono limitu rezerwacji dla tego slotu
      if [ ${reservation_count[$KEY]} -lt $MAX_SLOTS ]; then
        # Losowa liczba rezerwacji dla tego slotu (ale nie więcej niż dostępne miejsca)
        SLOTS_LEFT=$((MAX_SLOTS - ${reservation_count[$KEY]}))
        NUM_TO_ADD=$((RANDOM % (SLOTS_LEFT + 1) + 1))
        if [ $NUM_TO_ADD -gt $SLOTS_LEFT ]; then
          NUM_TO_ADD=$SLOTS_LEFT
        fi

        for j in $(seq 1 $NUM_TO_ADD); do
          # Losowy klient
          CLIENT_ID=$((RANDOM % 15 + 1))

          # Kod potwierdzenia (8 znaków - duże litery lub cyfry)
          CONFIRMATION_CODE=$(generate_confirmation_code)

          if [ "$FIRST" = true ]; then
            FIRST=false
          else
            echo "," >> $OUTPUT_FILE
          fi

          echo -n "($CLIENT_ID, $CATEGORY_ID, $STATUS_ID, '$CURRENT_DATE', '$TIME', '$CONFIRMATION_CODE')" >> $OUTPUT_FILE

          # Zwiększ licznik rezerwacji dla tego slotu
          reservation_count[$KEY]=$((${reservation_count[$KEY]} + 1))

          RESERVATION_ID=$((RESERVATION_ID + 1))
        done

        # Aktualizuj currentReservations w Slots
        # (będzie zaktualizowane w późniejszym etapie)
      fi
    done
  done
done
echo ";" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Aktualizacja CurrentReservations w tabeli Slots
echo "-- Aktualizacja CurrentReservations w tabeli Slots" >> $OUTPUT_FILE
for KEY in "${!reservation_count[@]}"; do
  if [ ${reservation_count[$KEY]} -gt 0 ]; then
    IFS=',' read -r DATE CATEGORY_ID TIME <<< "$KEY"
    echo "UPDATE \"Slots\" SET \"CurrentReservations\" = ${reservation_count[$KEY]} WHERE \"CategoryID\" = $CATEGORY_ID AND \"Date\" = '$DATE' AND \"Time\" = '$TIME';" >> $OUTPUT_FILE
  fi
done
echo "" >> $OUTPUT_FILE

echo "-- Koniec generowania danych" >> $OUTPUT_FILE
echo "Wygenerowano mockowe dane do pliku $OUTPUT_FILE"
