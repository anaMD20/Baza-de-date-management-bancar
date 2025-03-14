CREATE OR ALTER VIEW View_Analiza_Performanta_Conturi_Tranzactii AS
SELECT
    BA.ID_Client,
    CASE 
        WHEN CM.Tip_Client = 'persoana fizica' THEN CONCAT(PC.Prenume, ' ', PC.Nume)
        ELSE CC.Denumire
    END AS Nume_Or_Denumire,
    BA.Tip_Cont,
    COUNT(DISTINCT T.ID_Transaction) AS Numar_Tranzactii,
    SUM(CASE WHEN T.Tip_Transactie = 'depunere' THEN T.Suma ELSE 0 END) AS Total_Depuneri,
    SUM(CASE WHEN T.Tip_Transactie = 'retragere' THEN T.Suma ELSE 0 END) AS Total_Retrageri,
    SUM(CASE WHEN T.Tip_Transactie = 'transfer' THEN T.Suma ELSE 0 END) AS Total_Transferuri,
    SUM(BA.Sold_Actual) AS Sold_Actual,
    COUNT(DISTINCT BA.ID_Account) AS Numar_Conturi
FROM Bank_Accounts BA
JOIN Client_Master CM ON BA.ID_Client = CM.ID_Client
LEFT JOIN Personal_Clients PC ON CM.ID_Client = PC.ID_Client
LEFT JOIN Company_Clients CC ON CM.ID_Client = CC.ID_Client
LEFT JOIN Transactions T ON BA.ID_Account IN (T.ID_Account_Source, T.ID_Account_Target)
WHERE BA.Sold_Actual > 0
GROUP BY 
    BA.ID_Client, 
    CM.Tip_Client, 
    BA.Tip_Cont, 
    PC.Nume, 
    PC.Prenume, 
    CC.Denumire
HAVING 
    COUNT(DISTINCT T.ID_Transaction) > 1
    AND SUM(BA.Sold_Actual) > 20000;

SELECT * FROM View_Analiza_Performanta_Conturi_Tranzactii;
