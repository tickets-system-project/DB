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

CREATE TABLE Terminarz (
    id_terminu SERIAL PRIMARY KEY,
    id_petenta INTEGER,
    id_stanowiska INTEGER,
    komentarz VARCHAR(100),
    data_godzina TIMESTAMP NOT NULL,
    status VARCHAR(50) DEFAULT 'Oczekujacy' CHECK (status IN ('Oczekujacy', 'Potwierdzony','Obslugiwany', 'Odrzucony', 'Odwolany')),
    kod_potwierdzenia VARCHAR(10) UNIQUE NOT NULL,
    FOREIGN KEY (id_petenta) REFERENCES Petenci(id_petenta) ON DELETE CASCADE,
    FOREIGN KEY (id_stanowiska) REFERENCES Stanowiska(id_stanowiska) ON DELETE CASCADE
);
