use amazonDB;
--What are the top 5 brands by receipts scanned for most recent month?
SELECT TOP 5
    b.Name,
    COUNT(DISTINCT ri.ReceiptId) AS ReceiptsCount
FROM
    Brands b
INNER JOIN
    ReceiptItems ri ON b.BrandId = ri.BrandId
INNER JOIN
    Receipts r ON ri.ReceiptId = r.ReceiptId
WHERE
    r.PurchaseDate >= DATEADD(month, -1, GETDATE())
GROUP BY
    b.Name
ORDER BY
    ReceiptsCount DESC;   

--When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?  
SELECT
    r.RewardsReceiptStatus,
    AVG(r.TotalSpent) AS AverageSpend
FROM
    Receipts r
WHERE
    r.RewardsReceiptStatus IN ('Accepted', 'Rejected')
GROUP BY
    r.RewardsReceiptStatus;

--When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
SELECT
    r.RewardsReceiptStatus,
    SUM(ri.Quantity) AS TotalItems
FROM
    Receipts r
INNER JOIN
    ReceiptItems ri ON r.ReceiptId = ri.ReceiptId
WHERE
    r.RewardsReceiptStatus IN ('Accepted', 'Rejected')
GROUP BY
    r.RewardsReceiptStatus;

--Which brand has the most transactions among users who were created within the past 6 months? 

SELECT TOP 1
    b.Name,
    COUNT(DISTINCT r.ReceiptId) AS TransactionCount
FROM
    Users u
INNER JOIN
    Receipts r ON u.UserId = r.UserId
INNER JOIN
    ReceiptItems ri ON r.ReceiptId = ri.ReceiptId
INNER JOIN
    Brands b ON ri.BrandId = b.BrandId
WHERE
    u.CreatedDate >= DATEADD(month, -6, GETDATE())
GROUP BY
    b.Name
ORDER BY
    TransactionCount DESC;
