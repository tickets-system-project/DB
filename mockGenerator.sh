#!/bin/bash

# Ustawienie ścieżki do pliku SQL
OUTPUT_FILE="dane2.sql"

# Funkcja do generowania losowego kodu potwierdzenia
generate_confirmation_code() {
  # Generuje 2 losowe litery i 6 cyfr
  local letters=$(cat /dev/urandom | tr -dc 'A-Z' | fold -w 2 | head -n 1)
  local numbers=$(cat /dev/urandom | tr -dc '0-9' | fold -w 6 | head -n 1)
  echo "${letters}${numbers}"
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

# Generowanie danych dla Windows_and_Categories
echo "-- Generowanie danych dla Windows_and_Categories" >> $OUTPUT_FILE
echo "INSERT INTO \"Windows_and_Categories\" (\"WindowID\", \"CategoryID\", \"Date\", \"ClerkID\") VALUES" >> $OUTPUT_FILE

WINDOWS_COUNT=13
CATEGORIES_COUNT=13
CLERKS_STARTING_ID=2
CLERKS_ENDING_ID=10
CLERKS_COUNT=$((CLERKS_ENDING_ID - CLERKS_STARTING_ID + 1))

FIRST=true
for i in {-7..7}; do
  CURRENT_DATE=$(date -d "$TODAY $i days" +%Y-%m-%d)
  
  # Dla każdego dnia tworzymy tablicę dostępnych urzędników
  # i mieszamy ją, aby zapewnić losowe przypisanie
  AVAILABLE_CLERKS=()
  for CLERK_ID in $(seq $CLERKS_STARTING_ID $CLERKS_ENDING_ID); do
    AVAILABLE_CLERKS+=($CLERK_ID)
  done
  
  # Mieszanie tablicy
  for ((j=0; j<${#AVAILABLE_CLERKS[@]}; j++)); do
    random_index=$((RANDOM % ${#AVAILABLE_CLERKS[@]}))
    temp=${AVAILABLE_CLERKS[$j]}
    AVAILABLE_CLERKS[$j]=${AVAILABLE_CLERKS[$random_index]}
    AVAILABLE_CLERKS[$random_index]=$temp
  done
  
  # Dla każdego okna przypisz kategorię i urzędnika na dany dzień
  for WINDOW_ID in $(seq 1 $WINDOWS_COUNT); do
    # Przypisz kategorię do okna
    CATEGORY_ID=$(( (WINDOW_ID % CATEGORIES_COUNT) + 1 ))
    
    # Przypisz urzędnika do okna - bierzemy urzędnika z puli dostępnych
    # Jeśli zabraknie urzędników, zaczynamy od początku listy
    CLERK_INDEX=$(( (WINDOW_ID - 1) % ${#AVAILABLE_CLERKS[@]} ))
    CLERK_ID=${AVAILABLE_CLERKS[$CLERK_INDEX]}
    
    if [ "$FIRST" = true ]; then
      FIRST=false
    else
      echo "," >> $OUTPUT_FILE
    fi
    
    echo -n "($WINDOW_ID, $CATEGORY_ID, '$CURRENT_DATE', $CLERK_ID)" >> $OUTPUT_FILE
  done
done
echo ";" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Generowanie danych dla Slots
echo "-- Generowanie danych dla Slots" >> $OUTPUT_FILE
echo "INSERT INTO \"Slots\" (\"CategoryID\", \"Date\", \"Time\", \"MaxReservations\", \"CurrentReservations\") VALUES" >> $OUTPUT_FILE

FIRST=true
for i in {-7..7}; do
  CURRENT_DATE=$(date -d "$TODAY $i days" +%Y-%m-%d)
  
  # Dla każdej kategorii
  for CATEGORY_ID in $(seq 1 $CATEGORIES_COUNT); do
    # Generowanie slotów co godzinę od 8:00 do 16:00
    for HOUR in {8..16}; do
      TIME=$(printf "%02d:00:00" $HOUR)
      
      # Ustal maksymalną i aktualną liczbę rezerwacji (losowo)
      MAX_RESERVATIONS=$(( RANDOM % 5 + 1 ))
      CURRENT_RESERVATIONS=$(( RANDOM % (MAX_RESERVATIONS + 1) ))
      
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

# Generuj rezerwacje
RESERVATION_ID=1
FIRST=true
QUEUE_DATA=()

for i in {-7..7}; do
  CURRENT_DATE=$(date -d "$TODAY $i days" +%Y-%m-%d)
  
  # Dla każdej kategorii
  for CATEGORY_ID in $(seq 1 $CATEGORIES_COUNT); do
    # Generowanie kilku rezerwacji na wybranych slotach
    if (( RANDOM % 2 )); then # 50% szansa na rezerwacje w tej kategorii i dniu
      # Liczba rezerwacji dla tej kategorii i dnia
      NUM_RESERVATIONS=$(( RANDOM % 5 + 1 ))
      
      for j in $(seq 1 $NUM_RESERVATIONS); do
        # Losowy klient
        CLIENT_ID=$(( RANDOM % 15 + 1 ))
        
        # Losowa godzina między 8:00 a 16:00
        HOUR=$(( RANDOM % 9 + 8 ))
        TIME=$(printf "%02d:00:00" $HOUR)
        
        # Losowy status, z większą szansą na status 2 (Oczekujący)
        if (( RANDOM % 5 == 0 )); then
          STATUS_ID=$(( RANDOM % 6 + 1 ))
        else
          STATUS_ID=2 # Oczekujący
        fi
        
        # Kod potwierdzenia
        CONFIRMATION_CODE=$(generate_confirmation_code)
        
        if [ "$FIRST" = true ]; then
          FIRST=false
        else
          echo "," >> $OUTPUT_FILE
        fi
        
        echo -n "($CLIENT_ID, $CATEGORY_ID, $STATUS_ID, '$CURRENT_DATE', '$TIME', '$CONFIRMATION_CODE')" >> $OUTPUT_FILE
        
        # Jeśli status to "Oczekujący" (2), dodaj do kolejki
        if [ $STATUS_ID -eq 2 ]; then
          # Wybierz odpowiednie okno dla tej kategorii
          WINDOW_ID=$(( CATEGORY_ID % WINDOWS_COUNT + 1 ))
          QUEUE_CODE=$(generate_queue_code)
          QUEUE_DATA+=("($WINDOW_ID, $RESERVATION_ID, '$QUEUE_CODE')")
        fi
        
        RESERVATION_ID=$((RESERVATION_ID + 1))
      done
    fi
  done
done
echo ";" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Generowanie danych dla Queue
echo "-- Generowanie danych dla Queue" >> $OUTPUT_FILE
echo "INSERT INTO \"Queue\" (\"WindowID\", \"ReservationID\", \"QueueCode\") VALUES" >> $OUTPUT_FILE

FIRST=true
for QUEUE_ENTRY in "${QUEUE_DATA[@]}"; do
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    echo "," >> $OUTPUT_FILE
  fi
  
  echo -n "$QUEUE_ENTRY" >> $OUTPUT_FILE
done
echo ";" >> $OUTPUT_FILE

echo "-- Koniec generowania danych" >> $OUTPUT_FILE
echo "Wygenerowano mockowe dane do pliku $OUTPUT_FILE"
