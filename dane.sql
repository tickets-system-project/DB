INSERT INTO Role (Nazwa) VALUES 
('Administrator'),
('Urzędnik'),
('Petent');

INSERT INTO Uzytkownicy (Imie, Nazwisko, Login, Email, ID_Roli) VALUES 
('Jan', 'Kowalski', 'jkowalski', 'j.kowalski@urzad.pl', 1),
('Anna', 'Nowak', 'anowak', 'a.nowak@urzad.pl', 2),
('Piotr', 'Wiśniewski', 'pwisniewski', 'p.wisniewski@urzad.pl', 2),
('Maria', 'Dąbrowska', 'mdabrowska', 'm.dabrowska@urzad.pl', 2);

INSERT INTO Dane_logowania (UzytkownikID, Haslo_hash) VALUES 
(1, '$2a$10$N9qo8uLOickgx2ZMRZoMy.MrYV7JhqpSGZ6b4fL7JYV5tN9Y4TvqW'),
(2, '$2a$10$ZuGkFgYqhxvzY5.Q5YVzUe9z7LJ9tY5J5Xz3J5Xz3J5Xz3J5Xz3J5'),
(3, '$2a$10$ZuGkFgYqhxvzY5.Q5YVzUe9z7LJ9tY5J5Xz3J5Xz3J5Xz3J5Xz3J5'),
(4, '$2a$10$ZuGkFgYqhxvzY5.Q5YVzUe9z7LJ9tY5J5Xz3J5Xz3J5Xz3J5Xz3J5');

INSERT INTO KategorieSpraw (Nazwa) VALUES 
('Wydawanie dowodów osobistych'),
('Rejestracja pojazdów'),
('Zgłoszenie urodzenia dziecka'),
('Sprawy meldunkowe'),
('Wnioski o paszport');

INSERT INTO Okienka (NrOkienka) VALUES 
('Okienko 1'),
('Okienko 2'),
('Okienko 3'),
('Okienko 4');

INSERT INTO Okienka_i_Kategorie (OkienkoID, KategoriaID, Data, UrzednikID) VALUES 
(1, 1, '2025-06-01', 2),
(1, 2, '2025-06-01', 2),
(2, 3, '2025-06-01', 3),
(3, 4, '2025-06-01', 4),
(4, 5, '2025-06-01', 2);

INSERT INTO Petenci (Imie, Nazwisko, PESEL, Telefon, Email) VALUES 
('Adam', 'Malinowski', 90010112345, '123456789', 'a.malinowski@email.com'),
('Ewa', 'Zawadzka', 89020254321, '987654321', 'e.zawadzka@email.com'),
('Tomasz', 'Szymański', 88030398765, '555666777', 't.szymanski@email.com'),
('Katarzyna', 'Wójcik', 87040445678, '111222333', 'k.wojcik@email.com');

INSERT INTO Sloty (KategoriaID, Data, Godzina, MaxRezerwacji, IloscRezerwacji) VALUES 
(1, '2025-06-01', '09:00:00', 5, 2),
(1, '2025-06-01', '10:00:00', 5, 1),
(2, '2025-06-01', '11:00:00', 3, 0),
(3, '2025-06-01', '13:00:00', 4, 1),
(4, '2025-06-02', '14:00:00', 6, 2);

INSERT INTO Rezerwacje (PetentID, KategoriaID, Data, Godzina, KodPotwierdzenia) VALUES 
(1, 1, '2025-06-01', '09:00:00', 'ABC123'),
(2, 1, '2025-06-01', '09:30:00', 'DEF456'),
(3, 3, '2025-06-01', '13:00:00', 'GHI789'),
(4, 4, '2025-06-02', '14:00:00', 'JKL012');

INSERT INTO Kolejka (OkienkoID, RezerwacjaID) VALUES 
(1, 1),
(1, 2),
(2, 3),
(3, 4);
