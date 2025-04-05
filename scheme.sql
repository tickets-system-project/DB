CREATE TABLE Okienka (
    ID SERIAL PRIMARY KEY,
    NrOkienka VARCHAR(50) NOT NULL
);

CREATE TABLE Okienka_i_Kategorie (
    ID SERIAL PRIMARY KEY,
    OkienkoID INT,
    KategoriaID INT,
    Data DATE,
    UrzednikID INT,
    FOREIGN KEY (OkienkoID) REFERENCES Okienka(ID) ON DELETE CASCADE,
    FOREIGN KEY (KategoriaID) REFERENCES KategorieSpraw(ID) ON DELETE CASCADE,
    FOREIGN KEY (UrzednikID) REFERENCES Uzytkownicy(ID) ON DELETE CASCADE
);

CREATE TABLE Kolejka (
    ID SERIAL PRIMARY KEY,
    OkienkoID INT,
    RezerwacjaID INT,
    FOREIGN KEY (OkienkoID) REFERENCES Okienka(ID) ON DELETE CASCADE,
    FOREIGN KEY (RezerwacjaID) REFERENCES Rezerwacje(ID) ON DELETE CASCADE
);

CREATE TABLE Dane_logowania (
    ID SERIAL PRIMARY KEY,
    UzytkownikID INT,
    Haslo_hash VARCHAR(255) NOT NULL,
    FOREIGN KEY (UzytkownikID) REFERENCES Uzytkownicy(ID) ON DELETE CASCADE
);

CREATE TABLE Uzytkownicy (
    ID SERIAL PRIMARY KEY,
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    Login VARCHAR(50) NOT NULL,
    Haslo VARCHAR(255) NOT NULL,
    ID_Roli INT,
    FOREIGN KEY (ID_Roli) REFERENCES Role(ID)
);

CREATE TABLE Role (
    ID SERIAL PRIMARY KEY,
    Nazwa VARCHAR(50) NOT NULL
);

CREATE TABLE KategorieSpraw (
    ID SERIAL PRIMARY KEY,
    Nazwa VARCHAR(100) NOT NULL
);

CREATE TABLE Sloty (
    ID SERIAL PRIMARY KEY,
    KategoriaID INT,
    Data DATE,
    Godzina TIME,
    MaxRezerwacji INT,
    IloscRezerwacji INT,
    FOREIGN KEY (KategoriaID) REFERENCES KategorieSpraw(ID) ON DELETE CASCADE
);

CREATE TABLE Kolejka (
    ID SERIAL PRIMARY KEY,
    OkienkoID INT,
    RezerwacjaID INT,
    FOREIGN KEY (OkienkoID) REFERENCES Okienka(ID) ON DELETE CASCADE,
    FOREIGN KEY (RezerwacjaID) REFERENCES Rezerwacje(ID) ON DELETE CASCADE
);

CREATE TABLE Rezerwacje (
    ID SERIAL PRIMARY KEY,
    PetentID INT,
    KategoriaID INT,
    Data DATE,
    Godzina TIME,
    KodPotwierdzenia VARCHAR(50),
    FOREIGN KEY (PetentID) REFERENCES Petenci(ID) ON DELETE CASCADE,
    FOREIGN KEY (KategoriaID) REFERENCES KategorieSpraw(ID) ON DELETE CASCADE
);

CREATE TABLE Petenci (
    ID SERIAL PRIMARY KEY,
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    Telefon VARCHAR(20),
    Email VARCHAR(100)
);
