CREATE OR ALTER VIEW View_Bilant_Anual_Complex AS
SELECT
    YEAR(T.Data_Transactie) AS An,
    BA.Tip_Cont,
    COUNT(DISTINCT T.ID_Transaction) AS Numar_Tranzactii,
    SUM(CASE WHEN T.Tip_Transactie = 'depunere' THEN T.Suma ELSE 0 END) AS Total_Depuneri,
    SUM(CASE WHEN T.Tip_Transactie = 'retragere' THEN T.Suma ELSE 0 END) AS Total_Retrageri,
    SUM(LP.Suma_Plata) AS Total_Penalizari_Colectate,
    AVG(LP.Suma_Plata) AS Penalizare_Medie,
    SUM(L.Dobanda / 100 * L.Suma_Imprumutata) AS Venituri_Din_Dobanzi,
    AVG(L.Dobanda) AS Dobanda_Medie,
    SUM(BA.Sold_Actual) AS Sold_Total_Conturi,
    SUM(L.Suma_Imprumutata) AS Total_Imprumuturi_Acordate,
    SUM(BA.Sold_Actual) - SUM(L.Suma_Imprumutata) AS Diferenta_Active_Pasive
FROM Bank_Accounts BA
LEFT JOIN Transactions T ON BA.ID_Account = T.ID_Account_Source OR BA.ID_Account = T.ID_Account_Target
LEFT JOIN Loans L ON BA.ID_Client = L.ID_Client
LEFT JOIN Loan_Payments LP ON L.ID_Loan = LP.ID_Loan
WHERE YEAR(T.Data_Transactie) = 2023
   OR YEAR(LP.Data_Plata) = 2023
GROUP BY YEAR(T.Data_Transactie), BA.Tip_Cont
HAVING SUM(LP.Suma_Plata) > 1000;

SELECT * FROM View_Bilant_Anual_Complex;
