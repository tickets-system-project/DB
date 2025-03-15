import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import random
import string

def generate_confirmation_code():
    return ''.join(random.choices(string.ascii_uppercase + string.digits, k=6))

class SystemUrzad:
    def __init__(self):
        self.db_params = {
            'dbname': 'UrzadDB',
            'user': 'postgres',
            'password': 'haslo',
            'host': 'localhost',
            'port': '5432'
        }
        self.connection = psycopg2.connect(**self.db_params)
        self.connection.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        self.cursor = self.connection.cursor()
        self.inicjalizuj()
        
    def inicjalizuj(self):
        self.ustaw_role()
        self.dodaj_administratorow()
        self.dodaj_urzednika("Anna","Nowak",600100200)
        self.dodaj_urzednika("Maria","Kowalska",600100201)
        self.dodaj_urzednika("Jacek","Adamek",600100202)
        self.dodaj_urzednika("Anna","Kowalska",600100203)
        
        self.utworz_konto_uzytkownika("Jan","Kowalski","jk@interia.pl",700430234)
        self.utworz_konto_uzytkownika("Robert","Lewandowski","rl9@interia.pl",300432422)
        
        
    def ustaw_role(self):
        self.cursor.execute("""
        INSERT INTO Role (nazwa) VALUES
        ('Administrator'),
        ('Urzednik'),
        ('Petent');
        """)
        return

    def dodaj_administratorow(self):
        self.cursor.execute("""
            INSERT INTO Uzytkownicy (imie, nazwisko, email, telefon, id_roli) VALUES
            ('Admin', 'Systemowy', 'admin@urzad.pl', '+48123456789', 1),
            ('Admin', 'Zapasowy', 'admin2@urzad.pl', '+48987654321', 1)
        """)
        return
    
    def dodaj_urzednika(self, imie, nazwisko, telefon):
        email = f"{imie.lower()}.{nazwisko.lower()}@urzad.pl"  # Tworzenie poprawnego emaila
        self.cursor.execute("""
            INSERT INTO Uzytkownicy (imie, nazwisko, email, telefon, id_roli) 
            VALUES (%s, %s, %s, %s, %s)
        """, (imie, nazwisko, email, telefon, 2))  # Dynamiczne wstawianie danych
        self.connection.commit()  # Zatwierdzenie zmian w bazie
        return f"Użytkownik {imie} {nazwisko} został dodany z emailem {email}"
        
    def wyswietl_terminy_uzytkownika(self, petent_id):
        self.cursor.execute("SELECT * FROM Terminarz WHERE id_petenta = ?", (petent_id,))
        terminy = self.cursor.fetchall()  # Pobranie wszystkich wyników
        
        if not terminy:
            return f"Brak terminów dla użytkownika o ID {petent_id}."
        
        return terminy  # Zwracamy listę terminów

    
    def usun_uzytkownika(self, user_id):
        # Sprawdzenie, czy użytkownik jest administratorem
        self.cursor.execute("SELECT id_roli FROM Uzytkownicy WHERE id = ?", (user_id,))
        wynik = self.cursor.fetchone()
        if wynik and wynik[0] == 1:
            return "Nie można usunąć administratora!"
        self.cursor.execute("DELETE FROM Uzytkownicy WHERE id = ?", (user_id,))
        self.connection.commit()
        return f"Użytkownik o ID {user_id} został usunięty."
        
    def petentid_from_userid(self, id_uzytkownika):
        self.cursor.execute("""
            SELECT id_petenta FROM Petenci WHERE id_uzytkownika = %s
        """, (id_uzytkownika,))
        result = self.cursor.fetchone()
        return result[0] if result else None
    
    def utworz_konto_uzytkownika(self,imie,nazwisko,mail,telefon):
        self.cursor.execute("""
            INSERT INTO Uzytkownicy (imie, nazwisko, email, telefon, id_roli) 
            VALUES (?, ?, ?, ?, ?)
        """, (imie, nazwisko, mail, telefon, 3))
        self.connection.commit()
        return f"Urzednik {imie} {nazwisko} został dodany z emailem {mail}"

    def rejestracja_online(self, id_uzytkownika, id_stanowiska, data_godzina):
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

    def rejestracja_na_miejscu(self, id_stanowiska, data_godzina):
        kod_potwierdzenia = generate_confirmation_code()
        self.cursor.execute("""
            INSERT INTO Terminarz (id_petenta, id_stanowiska, data_godzina, status, kod_potwierdzenia)
            VALUES (NULL, %s, %s, 'Oczekujacy', %s)
        """, (id_stanowiska, data_godzina, kod_potwierdzenia))
        self.connection.commit()
        return kod_potwierdzenia

    def przypisanie_petenta(self, imie, nazwisko, pesel, adres, kod_potwierdzenia):
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
        return petent_id

# Przykładowe użycie systemu
system = SystemUrzad()

# Rejestracja na miejscu
kod_na_miejscu = system.rejestracja_na_miejscu(1, '2025-03-20 10:30:00')
petent_id = system.przypisanie_petenta('Jan', 'Nowak', '12345778901', 'ul. Przykładowa 1, 00-001 Warszawa', kod_na_miejscu)
print(f'Nowy ID petenta: {petent_id}')