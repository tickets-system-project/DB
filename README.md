# System Kolejkowy - Dokumentacja Obsługi

### Scenariusz 1: Mam konto internetowe i rejestruję się do urzędu przez internet

#### Opis:
- System przypisuje sprawę do odpowiedniego stanowiska w zależności od wybranej usługi.
- Tworzy rekord w tabeli `Terminarz`, przypisując użytkownika do konkretnego terminu i stanowiska.
- Kod potwierdzenia jest generowany, aby użytkownik mógł go użyć jako potwierdzenie wizyty.

#### Użytkownik:
- Po zalogowaniu na konto internetowe użytkownik wybiera usługę i termin wizyty w urzędzie.
- Na jego koncie pojawia się wybrany termin.
- Użytkownik ma dostęp do swojego terminu oraz kodu potwierdzenia przez konto.
- Po zalogowaniu wie, do którego stanowiska i na którą godzinę ma przyjść.

#### SQL:
```sql
INSERT INTO Terminarz (id_petenta, id_stanowiska, data_godzina, status, kod_potwierdzenia)
VALUES (1, 2, '2025-03-20 10:00:00', 'Oczekujacy', 'ABC123');
```

### Scenariusz 2: Przychodzę do urzędu i biorę numerek do stanowiska, bez przedstawiania się

#### Opis:
- System przypisuje sprawę do odpowiedniego stanowiska w zależności od wybranej usługi, bez konieczności logowania się wcześniej.
- Tworzy rekord w tabeli Terminarz, który zawiera dane petenta oraz wybrany termin.
- Generuje kod potwierdzenia, który użytkownik może wykorzystać jako dowód przybycia.

#### Niezarejestrowany petent:

- Po przyjściu do urzędu z tabeltu odbiera termin i kod potwierdzenia
- Na podstawie numeru stanowiska i godziny, system przypisuje go do odpowiedniego stanowiska.

#### SQL:
```sql
INSERT INTO Terminarz (id_petenta, id_stanowiska, data_godzina, status, kod_potwierdzenia)
VALUES (NULL, 2, '2025-03-20 10:00:00', 'Oczekujacy', 'XYZ456');
```


### Scenariusz 3: Po przyjściu do stanowiska, okazuję dokument co łączy termin z id_petenta

#### Opis:

- Po przybyciu do stanowiska, użytkownik okazuje dokument, który jest powiązany z rekordem id_petenta w tabeli Terminarz.
- W przypadku braku wcześniejszej rejestracji online (np. rejestracja na tablecie w urzędzie), rekord w tabeli Petenci jest tworzony, a numer id_petenta zostaje przypisany do odpowiedniego terminu.
- Podanie kodu potwierdzenia jest obowiązkowe dla identyfikacji użytkownika.

#### SQL:
```sql
-- Jeżeli użytkownik nie ma konta, tworzymy rekord w tabeli Petenci
INSERT INTO Petenci (imie, nazwisko, pesel, adres) 
VALUES ('Jan', 'Kowalski', '12345678901', 'ul. Przykładowa 1, 00-001 Warszawa');

-- Tworzenie rekordu w tabeli Terminarz
UPDATE Terminarz
SET id_petenta = VAL, status = 'Obslugiwany'
WHERE kod_potwierdzenia = 'LMN789' AND id_petenta IS NULL;
```



