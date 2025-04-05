INSERT INTO "Roles" ("Name") VALUES 
('Administrator'),
('Clerk'),
('Client');

INSERT INTO "Users" ("FirstName", "LastName", "Username", "Email", "RoleID") VALUES 
('Jan', 'Kowalski', 'jkowalski', 'j.kowalski@office.com', 1),
('Anna', 'Nowak', 'anowak', 'a.nowak@office.com', 2),
('Piotr', 'Wiśniewski', 'pwisniewski', 'p.wisniewski@office.com', 2),
('Maria', 'Dąbrowska', 'mdabrowska', 'm.dabrowska@office.com', 2);

INSERT INTO "LoginData" ("UserID", "PasswordHash") VALUES 
(1, '$2a$10$N9qo8uLOickgx2ZMRZoMy.MrYV7JhqpSGZ6b4fL7JYV5tN9Y4TvqW'),
(2, '$2a$10$ZuGkFgYqhxvzY5.Q5YVzUe9z7LJ9tY5J5Xz3J5Xz3J5Xz3J5Xz3J5'),
(3, '$2a$10$ZuGkFgYqhxvzY5.Q5YVzUe9z7LJ9tY5J5Xz3J5Xz3J5Xz3J5Xz3J5'),
(4, '$2a$10$ZuGkFgYqhxvzY5.Q5YVzUe9z7LJ9tY5J5Xz3J5Xz3J5Xz3J5Xz3J5');

INSERT INTO "CaseCategories" ("Name") VALUES 
('Dowody osobiste'),
('Rejestracja pojazdów'),
('Paszporty'),
('Wnioski'),
('Akty stanu cywilnego');

INSERT INTO "Windows" ("WindowNumber") VALUES 
('Stanowisko 1'),
('Stanowisko 2'),
('Stanowisko 3'),
('Stanowisko 4');

INSERT INTO "Windows_and_Categories" ("WindowID", "CategoryID", "Date", "ClerkID") VALUES 
(1, 1, '2025-06-01', 2),
(1, 2, '2025-06-01', 2),
(2, 3, '2025-06-01', 3),
(3, 4, '2025-06-01', 4),
(4, 5, '2025-06-01', 2);

INSERT INTO "Clients" ("FirstName", "LastName", "PESEL", "Phone", "Email") VALUES 
('Adam', 'Malinowski', 90010112345, '123456789', 'a.malinowski@email.com'),
('Ewa', 'Zawadzka', 89020254321, '987654321', 'e.zawadzka@email.com'),
('Tomasz', 'Szymański', 88030398765, '555666777', 't.szymanski@email.com'),
('Katarzyna', 'Wójcik', 87040445678, '111222333', 'k.wojcik@email.com');

INSERT INTO "Slots" ("CategoryID", "Date", "Time", "MaxReservations", "CurrentReservations") VALUES 
(1, '2025-06-01', '09:00:00', 5, 2),
(1, '2025-06-01', '10:00:00', 5, 1),
(2, '2025-06-01', '11:00:00', 3, 0),
(3, '2025-06-01', '13:00:00', 4, 1),
(4, '2025-06-02', '14:00:00', 6, 2);

INSERT INTO "Reservations" ("ClientID", "CategoryID", "Date", "Time", "ConfirmationCode") VALUES 
(1, 1, '2025-06-01', '09:00:00', 'ABC123'),
(2, 1, '2025-06-01', '09:30:00', 'DEF456'),
(3, 3, '2025-06-01', '13:00:00', 'GHI789'),
(4, 4, '2025-06-02', '14:00:00', 'JKL012');

INSERT INTO "Queue" ("WindowID", "ReservationID") VALUES 
(1, 1),
(1, 2),
(2, 3),
(3, 4);
