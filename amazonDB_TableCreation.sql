create database amazonDB

use amazonDB 
drop table if exists Users
CREATE TABLE Users (
    UserId INT PRIMARY KEY,
    Active BIT,
    CreatedDate DATETIME,
    LastLogin DATETIME,
    Role NVARCHAR(255),
    SignUpSource NVARCHAR(255),
    State NVARCHAR(255)
);

drop table if exists Brands
CREATE TABLE Brands (
    BrandId INT PRIMARY KEY,
    Name NVARCHAR(255),
    Category NVARCHAR(255)
); 
drop table if exists Receipts
CREATE TABLE Receipts (
    ReceiptId INT PRIMARY KEY,
    UserId INT,
    PurchaseDate DATETIME,
    TotalSpent MONEY,
    RewardsReceiptStatus NVARCHAR(50),
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

drop table if exists ReceiptItems
CREATE TABLE ReceiptItems (
    ReceiptItemId INT PRIMARY KEY,
    ReceiptId INT,
    BrandId INT,
    Quantity INT,
    Price MONEY,
    FOREIGN KEY (ReceiptId) REFERENCES Receipts(ReceiptId),
    FOREIGN KEY (BrandId) REFERENCES Brands(BrandId)
);


CREATE TABLE TempJSON (JsonContent NVARCHAR(MAX));

select @@SERVERNAME  

select * from TempJSON  

INSERT INTO Users (UserId, SignUpDate, Email, Name)
SELECT UserId, SignUpDate, Email, Name
FROM TempJSON 
CROSS APPLY OPENJSON(JsonContent)
WITH (
    UserId INT '$.userId',
    SignUpDate DATETIME '$.signUpDate',
    Email NVARCHAR(255) '$.email',
    Name NVARCHAR(255) '$.name'
) WHERE UserId is not NULL



