CREATE TABLE "Roles" ( 
    "ID" SERIAL PRIMARY KEY,
    "Name" VARCHAR(50) NOT NULL
);

CREATE TABLE "CaseCategories" (
    "ID" SERIAL PRIMARY KEY,
    "Letter" VARCHAR(100) NOT NULL,
    "Name" VARCHAR(100) NOT NULL
);

CREATE TABLE "Windows" (
    "ID" SERIAL PRIMARY KEY,
    "WindowNumber" VARCHAR(50) NOT NULL
);

CREATE TABLE "Status" (
    "ID" SERIAL PRIMARY KEY,
    "Name" VARCHAR(50) NOT NULL
);

CREATE TABLE "Clients" (
    "ID" SERIAL PRIMARY KEY,
    "FirstName" VARCHAR(50) NOT NULL,
    "LastName" VARCHAR(50) NOT NULL,
    "PESEL" VARCHAR(11) UNIQUE NOT NULL,
    "Phone" VARCHAR(20),
    "Email" VARCHAR(100)
);

CREATE TABLE "Users" (
    "ID" SERIAL PRIMARY KEY,
    "FirstName" VARCHAR(50) NOT NULL,
    "LastName" VARCHAR(50) NOT NULL,
    "Username" VARCHAR(50) NOT NULL,
    "Email" VARCHAR(100),
    "RoleID" INT,
    FOREIGN KEY ("RoleID") REFERENCES "Roles"("ID")
);

CREATE TABLE "Reservations" (
    "ID" SERIAL PRIMARY KEY,
    "ClientID" INT,
    "CategoryID" INT,
    "StatusID" INT,
    "Date" DATE,
    "Time" TIME,
    "ConfirmationCode" VARCHAR(50),
    FOREIGN KEY ("StatusID") REFERENCES "Status"("ID") ON DELETE CASCADE,
    FOREIGN KEY ("ClientID") REFERENCES "Clients"("ID") ON DELETE CASCADE,
    FOREIGN KEY ("CategoryID") REFERENCES "CaseCategories"("ID") ON DELETE CASCADE
);

CREATE TABLE "Slots" (
    "ID" SERIAL PRIMARY KEY,
    "CategoryID" INT,
    "Date" DATE,
    "Time" TIME,
    "MaxReservations" INT,
    "CurrentReservations" INT,
    FOREIGN KEY ("CategoryID") REFERENCES "CaseCategories"("ID") ON DELETE CASCADE
);

CREATE TABLE "Windows_and_Categories" (
    "ID" SERIAL PRIMARY KEY,
    "WindowID" INT,
    "CategoryID" INT,
    "Date" DATE,
    "ClerkID" INT,
    FOREIGN KEY ("WindowID") REFERENCES "Windows"("ID") ON DELETE CASCADE,
    FOREIGN KEY ("CategoryID") REFERENCES "CaseCategories"("ID") ON DELETE CASCADE,
    FOREIGN KEY ("ClerkID") REFERENCES "Users"("ID") ON DELETE CASCADE
);

CREATE TABLE "Queue" (
    "ID" SERIAL PRIMARY KEY,
    "WindowID" INT,
    "ReservationID" INT,
    "QueueCode" VARCHAR(50),
    FOREIGN KEY ("WindowID") REFERENCES "Windows"("ID") ON DELETE CASCADE,
    FOREIGN KEY ("ReservationID") REFERENCES "Reservations"("ID") ON DELETE CASCADE
);

CREATE TABLE "LoginData" (
    "ID" SERIAL PRIMARY KEY,
    "UserID" INT,
    "PasswordHash" VARCHAR(255) NOT NULL,
    FOREIGN KEY ("UserID") REFERENCES "Users"("ID") ON DELETE CASCADE
);
