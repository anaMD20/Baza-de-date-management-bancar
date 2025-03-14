CREATE OR ALTER VIEW View_Informatii_Clienti AS
SELECT
    CM.ID_Client,
    CM.Tip_Client,
    CASE 
        WHEN CM.Tip_Client = 'persoana fizica' THEN CONCAT(PC.Prenume, ' ', PC.Nume)
        ELSE CC.Denumire
    END AS Nume_Or_Denumire,
    CM.Adresa,
    CM.Telefon,
    CM.Email,
    COUNT(DISTINCT BA.ID_Account) AS Numar_Conturi_Bancare,
    SUM(BA.Sold_Actual) AS Sold_Total_Conturi,
    COUNT(DISTINCT L.ID_Loan) AS Numar_Imprumuturi,
    SUM(L.Sold_Ramas) AS Sold_Total_Imprumuturi,
    SUM(CASE WHEN LP.Tip_Plata = 'penalizare' THEN LP.Suma_Plata ELSE 0 END) AS Total_Penalizari
FROM Client_Master CM
LEFT JOIN Personal_Clients PC ON CM.ID_Client = PC.ID_Client
LEFT JOIN Company_Clients CC ON CM.ID_Client = CC.ID_Client
LEFT JOIN Bank_Accounts BA ON CM.ID_Client = BA.ID_Client
LEFT JOIN Loans L ON CM.ID_Client = L.ID_Client
LEFT JOIN Loan_Payments LP ON L.ID_Loan = LP.ID_Loan
GROUP BY
    CM.ID_Client, CM.Tip_Client, CM.Adresa, CM.Telefon, CM.Email, PC.Nume, PC.Prenume, CC.Denumire;

SELECT * FROM View_Informatii_Clienti;