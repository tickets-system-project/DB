-- NIEAKUTALNE!

INSERT INTO "Roles" ("Name") VALUES
('Administrator'),
('Urzędnik');

INSERT INTO "CaseCategories" ("Letter", "Name") VALUES
('A', 'Dowód osobisty'),
('B', 'Paszport'),
('C', 'Prawo jazdy'),
('D', 'Rejestracja pojazdu'),
('E', 'Akt urodzenia'),
('F', 'Akt małżeństwa'),
('G', 'Zaświadczenie o zameldowaniu'),
('H', 'Podatki lokalne'),
('I', 'Pozwolenie na budowę'),
('J', 'Pomoc społeczna'),
('K', 'Wymiana waluty'),
('L', 'Sprawy obywatelstwa'),
('M', 'Świadczenia rodzinne');

INSERT INTO "Windows" ("WindowNumber") VALUES
('A1'),
('A2'),
('A3'),
('B1'),
('B2'),
('B3'),
('C1'),
('C2'),
('C3'),
('D1'),
('D2'),
('D3'),
('E1');

INSERT INTO "Status" ("Name") VALUES 
('Umówiony'),
('Oczekujący'),
('Odwołany'),
('Wezwany'),
('Obsługiwany'),
('Obsłużony');

INSERT INTO "Clients" ("FirstName", "LastName", "PESEL", "Phone", "Email") VALUES
('Jan', 'Kowalski', '80010112345', '500100200', 'jan.kowalski@email.pl'),
('Anna', 'Nowak', '82030223456', '501200300', 'anna.nowak@email.pl'),
('Piotr', 'Wiśniewski', '75050534567', '502300400', 'piotr.wisniewski@email.pl'),
('Katarzyna', 'Dąbrowska', '90070745678', '503400500', 'katarzyna.dabrowska@email.pl'),
('Andrzej', 'Lewandowski', '85090956789', '504500600', 'andrzej.lewandowski@email.pl'),
('Magdalena', 'Wójcik', '88111067890', '505600700', 'magdalena.wojcik@email.pl'),
('Krzysztof', 'Kamiński', '79010178901', '506700800', 'krzysztof.kaminski@email.pl'),
('Agnieszka', 'Kowalczyk', '83030289012', '507800900', 'agnieszka.kowalczyk@email.pl'),
('Tomasz', 'Zieliński', '77050590123', '508900100', 'tomasz.zielinski@email.pl'),
('Monika', 'Szymańska', '91070701234', '509010200', 'monika.szymanska@email.pl'),
('Grzegorz', 'Woźniak', '86090912345', '510120300', 'grzegorz.wozniak@email.pl'),
('Joanna', 'Kozłowska', '89111023456', '511230400', 'joanna.kozlowska@email.pl'),
('Marek', 'Jankowski', '78010134567', '512340500', 'marek.jankowski@email.pl'),
('Aleksandra', 'Mazur', '84030245678', '513450600', 'aleksandra.mazur@email.pl'),
('Paweł', 'Krawczyk', '76050356789', '514560700', 'pawel.krawczyk@email.pl');

INSERT INTO "Users" ("FirstName", "LastName", "Username", "Email", "RoleID") VALUES
('admin', 'system', 'admin', 'admin@urzad.pl', 1),
('Adam', 'Kowalski', 'akowalski', 'admin1@urzad.pl', 1),
('Barbara', 'Nowak', 'bnowak', 'barbara.nowak@urzad.pl', 2),
('Cezary', 'Wiśniewski', 'cwisniewski', 'cezary.wisniewski@urzad.pl', 2),
('Dorota', 'Dąbrowska', 'ddabrowska', 'dorota.dabrowska@urzad.pl', 2),
('Edward', 'Lewandowski', 'elewandowski', 'edward.lewandowski@urzad.pl', 2),
('Franciszka', 'Wójcik', 'fwojcik', 'franciszka.wojcik@urzad.pl', 2),
('Grzegorz', 'Kamiński', 'gkaminski', 'grzegorz.kaminski@urzad.pl', 2),
('Halina', 'Kowalczyk', 'hkowalczyk', 'halina.kowalczyk@urzad.pl', 2),
('Ireneusz', 'Zieliński', 'izielinski', 'ireneusz.zielinski@urzad.pl', 2),
('Jadwiga', 'Szymańska', 'jszymanska', 'jadwiga.szymanska@urzad.pl', 2);

INSERT INTO "LoginData" ("UserID", "PasswordHash") VALUES
(1, '$2a$11$lSjKafK8vGN2uW28a27gieSQnFr8mtVuuP1Pm6RODJv7qldqpQK1G'),
(2, '$2a$12$dTe5LIzGvZ9K9X5TyQ3jTeZ4JMpK8n0L/vX3Hv7lZnJ7XGyG/9Lt6'),
(3, '$2a$12$9V0sFZ1yG2Uy5nL3X5z8IeZX5K8kR4G5G6sJZ3L7hJ7h5n0L9K5Xq'),
(4, '$2a$12$8K0bX5R7G3G3pP5J5K5J7.bV3V3X3X3X3X3X3X3X3X3X3X3X3X3X3'),
(5, '$2a$12$7M1mM1mM1mM1mM1mM1mM1.O5O5O5O5O5O5O5O5O5O5O5O5O5O5O5O'),
(6, '$2a$12$6L6L6L6L6L6L6L6L6L6L6.N4N4N4N4N4N4N4N4N4N4N4N4N4N4N4N'),
(7, '$2a$12$5K5K5K5K5K5K5K5K5K5K5.M3M3M3M3M3M3M3M3M3M3M3M3M3M3M3M'),
(8, '$2a$12$4J4J4J4J4J4J4J4J4J4J4.L2L2L2L2L2L2L2L2L2L2L2L2L2L2L2L'),
(9, '$2a$12$3H3H3H3H3H3H3H3H3H3H3.K1K1K1K1K1K1K1K1K1K1K1K1K1K1K1K'),
(10, '$2a$12$2G2G2G2G2G2G2G2G2G2G2.J0J0J0J0J0J0J0J0J0J0J0J0J0J0J0J');


INSERT INTO "Windows_and_Categories" ("WindowID", "CategoryID", "Date", "ClerkID") VALUES
(1, 1, '2025-04-15', 2),
(1, 1, '2025-04-16', 2),
(2, 2, '2025-04-15', 3),
(2, 2, '2025-04-16', 3),
(3, 3, '2025-04-16', 5),
(3, 3, '2025-04-17', 5),
(4, 4, '2025-04-16', 7),
(4, 4, '2025-04-17', 7),
(5, 5, '2025-04-17', 8),
(5, 5, '2025-04-18', 8),
(6, 6, '2025-04-17', 2),
(6, 6, '2025-04-18', 2),
(7, 7, '2025-04-17', 3),
(7, 7, '2025-04-18', 3),
(8, 8, '2025-04-18', 5),
(8, 8, '2025-04-19', 5),
(9, 9, '2025-04-18', 7),
(9, 9, '2025-04-19', 7),
(10, 10, '2025-04-18', 8),
(10, 10, '2025-04-19', 8),
(11, 11, '2025-04-19', 2),
(12, 12, '2025-04-19', 6),
(13, 13, '2025-04-19', 5);

INSERT INTO "Slots" ("CategoryID", "Date", "Time", "MaxReservations", "CurrentReservations") VALUES
(1, '2025-04-15', '09:00:00', 5, 2),
(1, '2025-04-15', '10:00:00', 5, 3),
(1, '2025-04-15', '11:00:00', 5, 1),
(2, '2025-04-15', '09:00:00', 4, 1),
(2, '2025-04-15', '11:00:00', 4, 2),
(2, '2025-04-16', '09:00:00', 4, 0),
(3, '2025-04-16', '09:00:00', 3, 1),
(3, '2025-04-16', '10:00:00', 3, 2),
(3, '2025-04-16', '11:00:00', 3, 3),
(4, '2025-04-16', '11:00:00', 6, 3),
(4, '2025-04-16', '12:00:00', 6, 2),
(5, '2025-04-17', '09:00:00', 2, 1),
(5, '2025-04-17', '10:00:00', 2, 2),
(6, '2025-04-17', '10:00:00', 3, 2),
(6, '2025-04-17', '11:00:00', 3, 1),
(7, '2025-04-17', '11:00:00', 4, 1),
(7, '2025-04-17', '12:00:00', 4, 2),
(8, '2025-04-18', '09:00:00', 5, 2),
(8, '2025-04-18', '10:00:00', 5, 3),
(9, '2025-04-18', '10:00:00', 3, 1),
(9, '2025-04-18', '11:00:00', 3, 2),
(10, '2025-04-18', '11:00:00', 4, 2),
(10, '2025-04-18', '12:00:00', 4, 1),
(11, '2025-04-19', '09:00:00', 3, 1),
(12, '2025-04-19', '10:00:00', 4, 2),
(13, '2025-04-19', '11:00:00', 5, 3);

INSERT INTO "Reservations" ("ClientID", "CategoryID", "StatusID", "Date", "Time", "ConfirmationCode") VALUES
(1, 1, 2, '2025-04-15', '09:00:00', 'AB123456'),
(2, 1, 2, '2025-04-15', '09:30:00', 'AC123457'),
(3, 1, 2, '2025-04-15', '11:00:00', 'AD123458'),
(4, 2, 2, '2025-04-15', '09:00:00', 'BE123459'),
(5, 2, 2, '2025-04-15', '11:00:00', 'BF123460'),
(6, 2, 2, '2025-04-15', '11:30:00', 'BG123461'),
(7, 3, 2, '2025-04-16', '09:00:00', 'CQ123462'),
(8, 3, 2, '2025-04-16', '10:00:00', 'CW123463'),
(9, 3, 2, '2025-04-16', '10:30:00', 'CE123464'),
(10, 3, 2, '2025-04-16', '11:00:00', 'CR123465'),
(11, 4, 2, '2025-04-16', '11:00:00', 'DT123466'),
(12, 4, 2, '2025-04-16', '11:30:00', 'DY123467'),
(13, 4, 2, '2025-04-16', '12:00:00', 'DU123468'),
(14, 5, 2, '2025-04-17', '09:00:00', 'EI123469'),
(15, 5, 2, '2025-04-17', '10:00:00', 'EP123470');

INSERT INTO "Queue" ("WindowID", "ReservationID") VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(2, 6),
(3, 7),
(3, 8),
(3, 9),
(3, 10),
(4, 11),
(4, 12),
(4, 13),
(5, 14),
(5, 15);
