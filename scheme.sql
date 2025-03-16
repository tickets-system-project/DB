CREATE TABLE Role (
    id_roli SERIAL PRIMARY KEY,
    nazwa VARCHAR(50)
);

CREATE TABLE Uzytkownicy (
    id_uzytkownika SERIAL PRIMARY KEY,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefon VARCHAR(20),
    id_roli INTEGER NOT NULL,
    FOREIGN KEY (id_roli) REFERENCES Role(id_roli) ON DELETE CASCADE
);

CREATE TABLE DaneLogowania (
    id_uzytkownika INTEGER PRIMARY KEY,
    haslo_hash TEXT NOT NULL,
    FOREIGN KEY (id_uzytkownika) REFERENCES Uzytkownicy(id_uzytkownika) ON DELETE CASCADE
);

CREATE TABLE Petenci (
    id_petenta SERIAL PRIMARY KEY,
    id_uzytkownika INTEGER UNIQUE,
    imie VARCHAR(50),
    nazwisko VARCHAR(50),
    pesel CHAR(11) UNIQUE NOT NULL,
    adres TEXT,
    FOREIGN KEY (id_uzytkownika) REFERENCES Uzytkownicy(id_uzytkownika) ON DELETE CASCADE,
    CHECK ((id_uzytkownika IS NOT NULL) OR (imie IS NOT NULL AND nazwisko IS NOT NULL))
);

CREATE TABLE Stanowiska (
    id_stanowiska SERIAL PRIMARY KEY,
    nazwa VARCHAR(100) NOT NULL
);

CREATE TABLE Status (
    id_statusu SERIAL PRIMARY KEY,
    nazwa VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE KategoriaSprawy (
    id_kategorii SERIAL PRIMARY KEY,
    nazwa VARCHAR(50) UNIQUE NOT NULL
)

CREATE TABLE Terminarz (
    id_terminu SERIAL PRIMARY KEY, --Klucz
    id_petenta INTEGER,            --Petent - nie musi być przypisany od razu
    id_kategorii INGEGER NOT NULL, --Sprawa musi mieć kategorie (po niej przypisujemy do stanowiska)
    id_stanowiska INTEGER,         --Stanowisko
    id_statusu INTEGER NOT NULL,   --'Oczekujacy', 'Potwierdzony', 'Odrzucony', 'Odwolany', 'Obslugiwany'
    komentarz VARCHAR(100),
    data_godzina TIMESTAMP NOT NULL,--Nusi być
    kod_potwierdzenia VARCHAR(10) UNIQUE NOT NULL, -- Musi być
    FOREIGN KEY (id_petenta) REFERENCES Petenci(id_petenta) ON DELETE CASCADE,
    FOREIGN KEY (id_stanowiska) REFERENCES Stanowiska(id_stanowiska) ON DELETE CASCADE,
    FOREIGN KEY (id_statusu) REFERENCES Status(id_statusu) ON DELETE CASCADE,
    FOREIGN KEY (id_kategorii) REFERENCES KategoriaSprawy(id_kategorii) ON DELETE CASCADE
);
