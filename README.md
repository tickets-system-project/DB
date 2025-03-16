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
        id_petenta = self.petentid_from_userid(id_uzytkownika)
        print(id_petenta)
        if not id_petenta:
            raise ValueError("Użytkownik nie jest powiązany z petentem.")
        
        kod_potwierdzenia = generate_confirmation_code()
        self.cursor.execute("""
            INSERT INTO Terminarz (id_petenta, id_stanowiska, data_godzina, status, kod_potwierdzenia)
            VALUES (%s, %s, %s, 'Oczekujacy', %s)
        """, (id_petenta, id_stanowiska, data_godzina, kod_potwierdzenia))
        self.connection.commit()
        return kod_potwierdzenia
```

### Scenariusz 2: Przychodzę do urzędu i biorę numerek do stanowiska, bez przedstawiania się

#### Opis:
- System przypisuje sprawę do odpowiedniego stanowiska w zależności od wybranej usługi, bez konieczności logowania się wcześniej.
- Tworzy rekord w tabeli Terminarz, który zawiera wybrany termin oraz kod_potwierdzenia. (Brak powiązania z id_petenta).
- Generuje kod potwierdzenia, który użytkownik może wykorzystać jako dowód przybycia.

#### Niezarejestrowany petent:

- Po przyjściu do urzędu z tabeltu odbiera termin i kod potwierdzenia
- Na podstawie numeru stanowiska i godziny, system przypisuje go do odpowiedniego stanowiska.

#### SQL:
```sql
kod_potwierdzenia = generate_confirmation_code()
        self.cursor.execute("""
            INSERT INTO Terminarz (id_petenta, id_stanowiska, data_godzina, status, kod_potwierdzenia)
            VALUES (NULL, %s, %s, 'Oczekujacy', %s)
        """, (id_stanowiska, data_godzina, kod_potwierdzenia))
        self.connection.commit()
        return kod_potwierdzenia
```


### Scenariusz 3: Po przyjściu do stanowiska, okazuję dokument co łączy termin z id_petenta

#### Opis:

- Po przybyciu do stanowiska, użytkownik okazuje dokument, który jest powiązany z rekordem id_petenta w tabeli Terminarz.
- W przypadku braku wcześniejszej rejestracji online (np. rejestracja na tablecie w urzędzie), rekord w tabeli Petenci jest tworzony, a numer id_petenta zostaje przypisany do odpowiedniego terminu.
- Podanie kodu potwierdzenia jest obowiązkowe dla identyfikacji użytkownika.

#### SQL:
```sql
        self.cursor.execute("""
            INSERT INTO Petenci (imie, nazwisko, pesel, adres)
            VALUES (%s, %s, %s, %s) RETURNING id_petenta
        """, (imie, nazwisko, pesel, adres))
        petent_id = self.cursor.fetchone()[0]
        
        self.cursor.execute("""
            UPDATE Terminarz
            SET id_petenta = %s, status = 'Obslugiwany'
            WHERE kod_potwierdzenia = %s AND id_petenta IS NULL
        """, (petent_id, kod_potwierdzenia))
        
        self.connection.commit()
```



