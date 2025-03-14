CREATE DATABASE bank_db;

USE bank_db;

CREATE TABLE Client_Master (
    ID_Client INT PRIMARY KEY,
    Tip_Client VARCHAR(20) NOT NULL CHECK (Tip_Client IN ('persoana fizica', 'persoana juridica')),
    Adresa VARCHAR(255) NOT NULL,
    Telefon VARCHAR(15) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Data_Creare DATE NOT NULL
);

CREATE TABLE Personal_Clients (
    ID_Client INT PRIMARY KEY,
    Nume VARCHAR(50) NOT NULL,
    Prenume VARCHAR(50) NOT NULL,
    CNP CHAR(13) UNIQUE NOT NULL,
    FOREIGN KEY (ID_Client) REFERENCES Client_Master(ID_Client)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Company_Clients (
    ID_Client INT PRIMARY KEY,
    Denumire VARCHAR(100) NOT NULL,
    CUI VARCHAR(15) UNIQUE NOT NULL,
    Domeniu_Activitate VARCHAR(50) NOT NULL,
    Numar_Angajati INT NOT NULL CHECK (Numar_Angajati > 0),
    Cifra_Afaceri_Anuala DECIMAL(15, 2) NOT NULL,
    FOREIGN KEY (ID_Client) REFERENCES Client_Master(ID_Client)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Bank_Accounts (
    ID_Account INT PRIMARY KEY,
    ID_Client INT NOT NULL,
    Tip_Cont VARCHAR(20) NOT NULL CHECK (Tip_Cont IN ('curent', 'economii', 'depozit')),
    IBAN VARCHAR(34) UNIQUE NOT NULL,
    Data_Deschidere DATE NOT NULL,
    Sold_Actual DECIMAL(15, 2) NOT NULL CHECK (Sold_Actual >= 0),
    Valuta CHAR(3) NOT NULL CHECK (Valuta IN ('RON', 'EUR', 'USD')),
    FOREIGN KEY (ID_Client) REFERENCES Client_Master(ID_Client)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Transactions (
    ID_Transaction INT PRIMARY KEY,
    ID_Account_Source INT,
    ID_Account_Target INT,
    Tip_Transactie VARCHAR(20) NOT NULL CHECK (Tip_Transactie IN ('depunere', 'retragere', 'transfer')),
    Suma DECIMAL(15, 2) NOT NULL CHECK (Suma > 0),
    Data_Transactie DATE NOT NULL,
    Descriere VARCHAR(255),
    FOREIGN KEY (ID_Account_Source) REFERENCES Bank_Accounts(ID_Account)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (ID_Account_Target) REFERENCES Bank_Accounts(ID_Account)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
);


CREATE TABLE Loans (
    ID_Loan INT PRIMARY KEY,
    ID_Client INT NOT NULL,
    Suma_Imprumutata DECIMAL(15, 2) NOT NULL CHECK (Suma_Imprumutata > 0),
    Dobanda DECIMAL(5, 2) NOT NULL CHECK (Dobanda > 0),
    Data_Acordare DATE NOT NULL,
    Data_Scadenta DATE NOT NULL,
    Sold_Ramas DECIMAL(15, 2) NOT NULL CHECK (Sold_Ramas >= 0),
    Tip_Imprumut VARCHAR(20) NOT NULL CHECK (Tip_Imprumut IN ('persoana fizica', 'persoana juridica')),
    Status VARCHAR(20) NOT NULL CHECK (Status IN ('activ', 'finalizat', 'restant')),
    FOREIGN KEY (ID_Client) REFERENCES Client_Master(ID_Client)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE Loan_Payments (
    ID_Payment INT PRIMARY KEY,
    ID_Loan INT NOT NULL,
    Suma_Plata DECIMAL(15, 2) NOT NULL CHECK (Suma_Plata > 0),
    Data_Plata DATE NOT NULL,
    Tip_Plata VARCHAR(20) NOT NULL CHECK (Tip_Plata IN ('normala', 'penalizare')),
    FOREIGN KEY (ID_Loan) REFERENCES Loans(ID_Loan)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO Client_Master (ID_Client, Tip_Client, Adresa, Telefon, Email, Data_Creare)
VALUES
(1, 'persoana fizica', 'Str. Libertatii, Nr. 10, Bucuresti', '0712345678', 'ion.popescu@example.com', '2020-01-15'),
(2, 'persoana fizica', 'Str. Victoriei, Nr. 5, Cluj', '0712345679', 'maria.ionescu@example.com', '2019-11-23'),
(3, 'persoana juridica', 'Str. IT-ului, Nr. 45, Bucuresti', '0745123456', 'contact@techsolutions.com', '2018-09-01'),
(4, 'persoana juridica', 'Str. Constructorilor, Nr. 12, Brasov', '0734567890', 'office@constructplus.com', '2019-03-15'),
(5, 'persoana fizica', 'Str. Sperantei, Nr. 20, Iasi', '0712345677', 'dan.vasile@example.com', '2021-05-01'),
(6, 'persoana juridica', 'Str. Industriei, Nr. 99, Timisoara', '0732111111', 'industrials@example.com', '2020-02-20'),
(7, 'persoana fizica', 'Str. Pacii, Nr. 8, Constanta', '0712345682', 'mihai.vasile@example.com', '2018-09-10'),
(8, 'persoana fizica', 'Str. Libertatii, Nr. 12, Bucuresti', '0723456789', 'alina.popescu@example.com', '2021-01-20'),
(9, 'persoana fizica', 'Str. Victoria, Nr. 15, Iasi', '0723987654', 'george.ion@example.com', '2022-02-10'),
(10, 'persoana juridica', 'Str. IT-ului, Nr. 20, Bucuresti', '0724111111', 'contact@websoft.com', '2019-03-01'),
(11, 'persoana juridica', 'Str. Constructorilor, Nr. 22, Brasov', '0725555555', 'office@buildplus.com', '2020-05-15'),
(12, 'persoana fizica', 'Str. Pacii, Nr. 8, Constanta', '0723333333', 'ioana.mihai@example.com', '2021-06-05'),
(13, 'persoana fizica', 'Str. Eminescu, Nr. 14, Cluj', '0724444444', 'andrei.vlad@example.com', '2022-07-10'),
(14, 'persoana juridica', 'Str. Industriei, Nr. 99, Timisoara', '0726666666', 'sales@techtrade.com', '2021-09-15'),
(15, 'persoana fizica', 'Str. Mihai Viteazu, Nr. 9, Oradea', '0727777777', 'ana.pop@example.com', '2022-03-20'),
(16, 'persoana juridica', 'Str. Fabricii, Nr. 7, Sibiu', '0728888888', 'office@industrial.ro', '2020-11-01'),
(17, 'persoana fizica', 'Str. Primaverii, Nr. 5, Arad', '0729999999', 'daniel.muntean@example.com', '2021-08-10'),
(18, 'persoana juridica', 'Str. Principala, Nr. 3, Bacau', '0721231234', 'info@agropro.com', '2019-09-25'),
(19, 'persoana fizica', 'Str. Florilor, Nr. 4, Targu Mures', '0723123123', 'florin.george@example.com', '2022-01-15'),
(20, 'persoana juridica', 'Str. Tehnologiei, Nr. 6, Ploiesti', '0724564567', 'contact@innovatech.com', '2021-12-05'),
(21, 'persoana fizica', 'Str. Sperantei, Nr. 20, Iasi', '0712341234', 'cristina.ion@example.com', '2021-04-15'),
(22, 'persoana juridica', 'Str. Constructorilor, Nr. 14, Timisoara', '0734111111', 'office@constructpro.com', '2020-03-10'),
(23, 'persoana fizica', 'Str. Libertatii, Nr. 9, Brasov', '0723451122', 'alex.popescu@example.com', '2021-06-20'),
(24, 'persoana juridica', 'Str. IT-ului, Nr. 33, Iasi', '0732112222', 'sales@digitalsoft.com', '2020-10-01'),
(25, 'persoana fizica', 'Str. Eminescu, Nr. 10, Cluj', '0721115678', 'vlad.andrei@example.com', '2022-05-01'),
(26, 'persoana juridica', 'Str. Fabricii, Nr. 8, Constanta', '0744110000', 'info@productionhub.com', '2021-11-01'),
(27, 'persoana fizica', 'Str. Aviatorilor, Nr. 5, Bucuresti', '0712341244', 'george.ionescu@example.com', '2020-07-15'),
(28, 'persoana juridica', 'Str. Tehnologiei, Nr. 12, Craiova', '0723445678', 'contact@itware.com', '2019-08-25'),
(29, 'persoana fizica', 'Str. Florilor, Nr. 2, Bacau', '0732456789', 'marius.george@example.com', '2021-02-20'),
(30, 'persoana juridica', 'Str. Constructorilor, Nr. 45, Cluj', '0743451234', 'office@buildstrong.com', '2021-12-12');

INSERT INTO Personal_Clients (ID_Client, Nume, Prenume, CNP)
VALUES
(1, 'Popescu', 'Ion', '1985051234567'),
(2, 'Ionescu', 'Maria', '1990071534568'),
(5, 'Vasile', 'Dan', '1993112234569'),
(7, 'Vasile', 'Mihai', '1979112234571'),
(8, 'Popescu', 'Alina', '1992051234567'),
(9, 'Ion', 'George', '1987062345678'),
(12, 'Mihai', 'Ioana', '1989123456789'),
(13, 'Vlad', 'Andrei', '1994045678901'),
(15, 'Pop', 'Ana', '1987112234569'),
(17, 'Muntean', 'Daniel', '1985078912345'),
(19, 'George', 'Florin', '1990034512345'),
(21, 'Ion', 'Cristina', '1988023412345'),
(23, 'Popescu', 'Alex', '1991073412345'),
(25, 'Andrei', 'Vlad', '1994034512345'),
(27, 'Ionescu', 'George', '1991023412345'),
(29, 'George', 'Marius', '1989023412345');

INSERT INTO Company_Clients (ID_Client, Denumire, CUI, Domeniu_Activitate, Numar_Angajati, Cifra_Afaceri_Anuala)
VALUES
(3, 'Tech Solutions SRL', 'RO12345678', 'IT', 50, 1500000.00),
(4, 'Construct Plus SRL', 'RO87654321', 'Constructii', 120, 4500000.00),
(6, 'Industrials TM', 'RO98765432', 'Productie', 300, 7500000.00),
(10, 'WebSoft SRL', 'RO65432100', 'Dezvoltare Software', 25, 1250000.00),
(11, 'Build Plus SRL', 'RO98765410', 'Constructii', 75, 2750000.00),
(14, 'Tech Trade SRL', 'RO76543210', 'Comert IT', 40, 3500000.00),
(16, 'Industrial Solutions SRL', 'RO45678912', 'Productie', 300, 6000000.00),
(18, 'AgroPro SRL', 'RO12349876', 'Agricultura', 150, 2500000.00),
(20, 'InnovaTech SRL', 'RO34567123', 'Tehnologie', 200, 4500000.00),
(22, 'ConstructPro SRL', 'RO56789012', 'Constructii', 100, 3000000.00),
(24, 'DigitalSoft SRL', 'RO67890123', 'Software', 120, 4000000.00),
(26, 'ProductionHub SRL', 'RO78901234', 'Productie', 250, 5500000.00),
(28, 'ITWare SRL', 'RO89012345', 'IT', 150, 4500000.00),
(30, 'BuildStrong SRL', 'RO90123456', 'Constructii', 80, 3500000.00);

INSERT INTO Bank_Accounts (ID_Account, ID_Client, Tip_Cont, IBAN, Data_Deschidere, Sold_Actual, Valuta)
VALUES
(1, 1, 'curent', 'RO49AAAA1B31007593840001', '2020-01-20', 5000.00, 'RON'),
(2, 1, 'economii', 'RO49AAAA1B31007593840002', '2020-01-25', 15000.00, 'RON'),
(3, 3, 'curent', 'RO49AAAA1B31007593840003', '2018-09-01', 100000.00, 'EUR'),
(4, 4, 'economii', 'RO49AAAA1B31007593840004', '2019-03-10', 250000.00, 'RON'),
(5, 5, 'curent', 'RO49AAAA1B31007593840005', '2021-05-01', 750.00, 'RON'),
(6, 6, 'curent', 'RO49AAAA1B31007593840006', '2020-02-15', 500000.00, 'EUR'),
(7, 7, 'curent', 'RO49AAAA1B31007593840007', '2018-09-15', 200.00, 'RON'),
(8, 8, 'curent', 'RO49AAAA1B31007593840008', '2021-01-15', 2500.00, 'RON'),
(9, 9, 'economii', 'RO49AAAA1B31007593840009', '2022-02-10', 10000.00, 'EUR'),
(10, 10, 'curent', 'RO49AAAA1B31007593840010', '2019-03-01', 150000.00, 'EUR'),
(11, 11, 'economii', 'RO49AAAA1B31007593840011', '2020-05-05', 500000.00, 'RON'),
(12, 12, 'curent', 'RO49AAAA1B31007593840012', '2021-06-05', 4000.00, 'RON'),
(13, 13, 'curent', 'RO49AAAA1B31007593840013', '2022-07-15', 12000.00, 'USD'),
(14, 14, 'economii', 'RO49AAAA1B31007593840014', '2021-09-10', 80000.00, 'EUR'),
(15, 15, 'curent', 'RO49AAAA1B31007593840015', '2022-03-20', 3000.00, 'RON'),
(16, 16, 'curent', 'RO49AAAA1B31007593840016', '2020-11-01', 700000.00, 'RON'),
(17, 17, 'curent', 'RO49AAAA1B31007593840017', '2021-08-10', 5000.00, 'USD'),
(18, 18, 'economii', 'RO49AAAA1B31007593840018', '2019-09-25', 350000.00, 'EUR'),
(19, 19, 'curent', 'RO49AAAA1B31007593840019', '2022-01-15', 2500.00, 'RON'),
(20, 20, 'economii', 'RO49AAAA1B31007593840020', '2021-12-05', 450000.00, 'USD'),
(21, 21, 'curent', 'RO49AAAA1B31007593840021', '2021-04-15', 12000.00, 'RON'),
(22, 22, 'curent', 'RO49AAAA1B31007593840022', '2020-03-10', 50000.00, 'EUR'),
(23, 23, 'economii', 'RO49AAAA1B31007593840023', '2021-06-20', 8000.00, 'USD'),
(24, 24, 'curent', 'RO49AAAA1B31007593840024', '2020-10-01', 10000.00, 'EUR'),
(25, 25, 'curent', 'RO49AAAA1B31007593840025', '2022-05-01', 3000.00, 'RON'),
(26, 26, 'curent', 'RO49AAAA1B31007593840026', '2021-11-01', 12000.00, 'RON'),
(27, 27, 'economii', 'RO49AAAA1B31007593840027', '2020-07-15', 2000.00, 'RON'),
(28, 28, 'curent', 'RO49AAAA1B31007593840028', '2019-08-25', 150000.00, 'USD'),
(29, 29, 'curent', 'RO49AAAA1B31007593840029', '2021-02-20', 7000.00, 'RON'),
(30, 30, 'economii', 'RO49AAAA1B31007593840030', '2021-12-12', 6000.00, 'EUR');

INSERT INTO Transactions (ID_Transaction, ID_Account_Source, ID_Account_Target, Tip_Transactie, Suma, Data_Transactie, Descriere)
VALUES
(1, 1, 2, 'transfer', 1000.00, '2023-12-01', 'Transfer economii'),
(2, 3, NULL, 'retragere', 500.00, '2023-12-05', 'Retragere ATM'),
(3, NULL, 4, 'depunere', 300.00, '2023-12-10', 'Depunere cash'),
(4, 5, 6, 'transfer', 200.00, '2023-12-15', 'Plata intre conturi'),
(5, 7, NULL, 'retragere', 250.00, '2023-12-20', 'Retragere cash'),
(6, 8, NULL, 'depunere', 500.00, '2023-12-01', 'Depunere salariu'),
(7, 9, 8, 'transfer', 200.00, '2023-12-05', 'Transfer economii'),
(8, 10, 11, 'transfer', 1000.00, '2023-11-25', 'Plata facturi'),
(9, NULL, 12, 'depunere', 300.00, '2023-11-30', 'Depunere cash'),
(10, 13, 14, 'transfer', 5000.00, '2023-12-10', 'Achizitie echipamente'),
(11, 15, NULL, 'retragere', 150.00, '2023-12-15', 'Retragere ATM'),
(12, 16, 18, 'transfer', 10000.00, '2023-12-20', 'Investitie agrara'),
(13, NULL, 17, 'depunere', 200.00, '2023-12-25', 'Depunere salariu'),
(14, 19, 20, 'transfer', 3000.00, '2023-12-28', 'Plata echipamente'),
(15, 21, 22, 'transfer', 1500.00, '2023-12-29', 'Plata serviciu'),
(16, NULL, 23, 'depunere', 500.00, '2023-12-30', 'Depunere contract'),
(17, 24, 25, 'transfer', 2000.00, '2023-12-31', 'Plata lunara'),
(18, NULL, 26, 'depunere', 1000.00, '2023-12-20', 'Depunere numerar'),
(19, 27, 28, 'transfer', 15000.00, '2023-12-21', 'Investitie IT'),
(20, NULL, 29, 'depunere', 1200.00, '2023-12-22', 'Depunere parteneri'),
(21, 30, 1, 'transfer', 3000.00, '2023-12-31', 'Plata contract finalizat'),
(22, 2, 3, 'transfer', 800.00, '2023-12-25', 'Transfer catre economii'),
(23, 4, NULL, 'retragere', 1200.00, '2023-12-26', 'Retragere numerar'),
(24, NULL, 5, 'depunere', 450.00, '2023-12-27', 'Depunere cash'),
(25, 6, 7, 'transfer', 7500.00, '2023-12-29', 'Plata pentru servicii'),
(26, 8, NULL, 'retragere', 300.00, '2023-12-24', 'Retragere ATM'),
(27, NULL, 9, 'depunere', 150.00, '2023-12-28', 'Depunere bonus'),
(28, 10, 11, 'transfer', 5000.00, '2023-12-23', 'Plata furnizor'),
(29, NULL, 12, 'depunere', 800.00, '2023-12-30', 'Depunere cash numerar'),
(30, 13, 14, 'transfer', 1000.00, '2023-12-21', 'Plata rate leasing'),
(31, 15, NULL, 'retragere', 700.00, '2023-12-20', 'Retragere salariu'),
(32, 16, 17, 'transfer', 12000.00, '2023-12-22', 'Plata investitie productie'),
(33, NULL, 18, 'depunere', 900.00, '2023-12-25', 'Depunere suplimentara'),
(34, 19, 20, 'transfer', 4500.00, '2023-12-26', 'Plata furnizori'),
(35, 21, NULL, 'retragere', 600.00, '2023-12-27', 'Retragere numerar'),
(36, NULL, 22, 'depunere', 1100.00, '2023-12-29', 'Depunere sold economii'),
(37, 23, 24, 'transfer', 3000.00, '2023-12-30', 'Plata achizitie materiale'),
(38, 25, 26, 'transfer', 2500.00, '2023-12-31', 'Plata salarii angajati'),
(39, NULL, 27, 'depunere', 1300.00, '2023-12-20', 'Depunere bonus final de an'),
(40, 28, 29, 'transfer', 6000.00, '2023-12-22', 'Plata finalizare contract');

INSERT INTO Loans (ID_Loan, ID_Client, Suma_Imprumutata, Dobanda, Data_Acordare, Data_Scadenta, Sold_Ramas, Tip_Imprumut, Status)
VALUES
(1, 1, 10000.00, 5.5, '2021-01-10', '2026-01-10', 8000.00, 'persoana fizica', 'activ'),
(2, 3, 500000.00, 4.0, '2020-07-01', '2025-07-01', 300000.00, 'persoana juridica', 'activ'),
(3, 4, 1000000.00, 3.5, '2021-05-15', '2031-05-15', 850000.00, 'persoana juridica', 'activ'),
(4, 5, 5000.00, 6.0, '2022-01-01', '2027-01-01', 4000.00, 'persoana fizica', 'activ'),
(5, 6, 150000.00, 5.0, '2020-10-10', '2030-10-10', 100000.00, 'persoana juridica', 'activ'),
(6, 8, 5000.00, 6.5, '2022-01-15', '2027-01-15', 4000.00, 'persoana fizica', 'activ'),
(7, 10, 250000.00, 4.5, '2021-06-10', '2026-06-10', 200000.00, 'persoana juridica', 'activ'),
(8, 11, 100000.00, 3.0, '2022-05-20', '2032-05-20', 75000.00, 'persoana juridica', 'activ'),
(9, 13, 8000.00, 5.0, '2022-07-01', '2027-07-01', 5000.00, 'persoana fizica', 'activ'),
(10, 14, 100000.00, 4.5, '2021-09-20', '2031-09-20', 90000.00, 'persoana juridica', 'activ'),
(11, 15, 15000.00, 5.0, '2022-03-15', '2027-03-15', 12000.00, 'persoana fizica', 'activ'),
(12, 16, 500000.00, 4.0, '2021-11-01', '2026-11-01', 400000.00, 'persoana juridica', 'activ'),
(13, 17, 8000.00, 5.5, '2022-04-01', '2027-04-01', 6000.00, 'persoana fizica', 'activ'),
(14, 18, 1000000.00, 3.8, '2020-08-15', '2030-08-15', 850000.00, 'persoana juridica', 'activ'),
(15, 19, 5000.00, 6.5, '2022-01-10', '2027-01-10', 3500.00, 'persoana fizica', 'activ'),
(16, 20, 250000.00, 4.2, '2021-12-05', '2026-12-05', 180000.00, 'persoana juridica', 'activ'),
(17, 21, 12000.00, 5.7, '2022-05-01', '2027-05-01', 10000.00, 'persoana fizica', 'activ'),
(18, 22, 300000.00, 3.9, '2020-07-10', '2025-07-10', 200000.00, 'persoana juridica', 'activ'),
(19, 23, 8000.00, 6.0, '2021-09-20', '2026-09-20', 6000.00, 'persoana fizica', 'activ'),
(20, 24, 400000.00, 4.1, '2020-11-01', '2030-11-01', 350000.00, 'persoana juridica', 'activ'),
(21, 25, 10000.00, 5.8, '2022-01-10', '2027-01-10', 7500.00, 'persoana fizica', 'activ'),
(22, 26, 750000.00, 3.5, '2020-02-15', '2030-02-15', 600000.00, 'persoana juridica', 'activ'),
(23, 27, 5000.00, 6.2, '2022-03-20', '2027-03-20', 4000.00, 'persoana fizica', 'activ'),
(24, 28, 300000.00, 4.0, '2021-06-01', '2031-06-01', 250000.00, 'persoana juridica', 'activ'),
(25, 29, 10000.00, 5.6, '2021-08-15', '2026-08-15', 8000.00, 'persoana fizica', 'activ'),
(26, 30, 500000.00, 4.3, '2020-10-01', '2025-10-01', 400000.00, 'persoana juridica', 'activ'),
(27, 1, 20000.00, 5.4, '2023-01-01', '2028-01-01', 18000.00, 'persoana fizica', 'activ'),
(28, 2, 600000.00, 3.8, '2020-09-01', '2025-09-01', 500000.00, 'persoana juridica', 'activ'),
(29, 3, 120000.00, 4.6, '2022-02-15', '2027-02-15', 100000.00, 'persoana juridica', 'activ'),
(30, 4, 5000.00, 6.0, '2023-05-01', '2028-05-01', 4500.00, 'persoana fizica', 'activ');

INSERT INTO Loan_Payments (ID_Payment, ID_Loan, Suma_Plata, Data_Plata, Tip_Plata)
VALUES
(1, 1, 1000.00, '2021-12-15', 'normala'),
(2, 1, 1000.00, '2022-12-15', 'normala'),
(3, 1, 1000.00, '2023-12-15', 'normala'),
(4, 2, 50000.00, '2021-05-15', 'normala'),
(5, 2, 50000.00, '2022-05-15', 'normala'),
(6, 3, 100000.00, '2021-10-10', 'normala'),
(7, 3, 100000.00, '2022-10-10', 'normala'),
(8, 3, 100000.00, '2023-10-10', 'normala'),
(9, 4, 1000.00, '2023-06-15', 'normala'),
(10, 4, 1000.00, '2024-06-15', 'normala'),
(11, 5, 2000.00, '2021-03-01', 'normala'),
(12, 5, 2000.00, '2022-03-01', 'normala'),
(13, 6, 1500.00, '2021-09-15', 'normala'),
(14, 6, 1500.00, '2022-09-15', 'penalizare'),
(15, 6, 1500.00, '2023-09-15', 'normala'),
(16, 7, 50000.00, '2022-12-01', 'normala'),
(17, 7, 50000.00, '2023-06-01', 'penalizare'),
(18, 8, 25000.00, '2023-03-15', 'normala'),
(19, 8, 25000.00, '2023-09-15', 'penalizare'),
(20, 9, 3000.00, '2023-01-15', 'normala'),
(21, 9, 2000.00, '2023-06-10', 'penalizare'),
(22, 10, 10000.00, '2022-05-20', 'normala'),
(23, 10, 10000.00, '2023-05-20', 'normala'),
(24, 11, 3000.00, '2023-03-10', 'normala'),
(25, 11, 3000.00, '2023-09-10', 'penalizare'),
(26, 12, 10000.00, '2022-11-01', 'penalizare'),
(27, 12, 10000.00, '2023-11-01', 'normala'),
(28, 13, 2000.00, '2022-04-01', 'normala'),
(29, 13, 2000.00, '2023-04-01', 'penalizare'),
(30, 14, 50000.00, '2021-12-01', 'normala'),
(31, 14, 50000.00, '2022-12-01', 'normala'),
(32, 15, 1500.00, '2022-06-10', 'penalizare'),
(33, 15, 1000.00, '2023-06-10', 'normala'),
(34, 16, 25000.00, '2022-01-01', 'normala'),
(35, 16, 25000.00, '2023-01-01', 'penalizare'),
(36, 17, 2000.00, '2022-07-10', 'penalizare'),
(37, 17, 2000.00, '2023-07-10', 'normala'),
(38, 18, 50000.00, '2021-08-15', 'normala'),
(39, 18, 50000.00, '2022-08-15', 'penalizare'),
(40, 19, 2000.00, '2021-09-20', 'normala'),
(41, 19, 2000.00, '2022-09-20', 'penalizare'),
(42, 20, 30000.00, '2021-11-15', 'normala'),
(43, 20, 30000.00, '2022-11-15', 'penalizare'),
(44, 21, 1500.00, '2022-05-01', 'penalizare'),
(45, 21, 1500.00, '2023-05-01', 'normala'),
(46, 22, 50000.00, '2021-07-10', 'normala'),
(47, 22, 50000.00, '2022-07-10', 'penalizare'),
(48, 23, 1000.00, '2023-03-20', 'penalizare'),
(49, 23, 1000.00, '2023-09-20', 'normala'),
(50, 24, 20000.00, '2021-06-15', 'normala');