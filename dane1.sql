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
