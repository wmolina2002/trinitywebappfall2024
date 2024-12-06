-- Drop existing tables if they exist
DROP TABLE IF EXISTS Miracles;
DROP TABLE IF EXISTS Prophecies;
DROP TABLE IF EXISTS Teachings;
DROP TABLE IF EXISTS HolyTrinity;

-- Creates the Holy Trinity Database
CREATE DATABASE IF NOT EXISTS HolyTrinity;
USE HolyTrinity;

-- Creates the Holy Trinity Table
CREATE TABLE HolyTrinity (
    Holy_Trinity_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(23) NOT NULL,
    Purpose TEXT,
    Description TEXT
);

-- Creates the Miracles Table
CREATE TABLE Miracles (
    Miracle_ID INT AUTO_INCREMENT PRIMARY KEY,
    Holy_Trinity_ID INT NULL,
    Testament VARCHAR(13) NOT NULL,
    Book VARCHAR(15),
    Verse VARCHAR(10),
    MiracleType VARCHAR(20),
    Summary TEXT,
    FOREIGN KEY (Holy_Trinity_ID) REFERENCES HolyTrinity(Holy_Trinity_ID)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- Creates the Prophecies Table
CREATE TABLE Prophecies (
    Prophecy_ID INT AUTO_INCREMENT PRIMARY KEY,
    Holy_Trinity_ID INT NULL,
    Testament VARCHAR(13) NOT NULL,
    Book VARCHAR(15),
    Verse VARCHAR(10),
    Summary TEXT,
    FOREIGN KEY (Holy_Trinity_ID) REFERENCES HolyTrinity(Holy_Trinity_ID)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- Creates the Teachings Table
CREATE TABLE Teachings (
    Teaching_ID INT AUTO_INCREMENT PRIMARY KEY,
    Holy_Trinity_ID INT NULL,
    Testament VARCHAR(13) NOT NULL,
    Book VARCHAR(15),
    Verse VARCHAR(10),
    MainMessage TEXT,
    Summary TEXT,
    FOREIGN KEY (Holy_Trinity_ID) REFERENCES HolyTrinity(Holy_Trinity_ID)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- Indexes created for frequently queried fields
CREATE INDEX index_Testament_Miracles ON Miracles (Testament);
CREATE INDEX index_Testament_Prophecies ON Prophecies (Testament);
CREATE INDEX index_Testament_Teachings ON Teachings (Testament);

-- Insert sample data for Holy Trinity Table
INSERT INTO HolyTrinity (Name, Purpose, Description)
VALUES
    ('The Father', 'Creator', 'Represents the Father in the Holy Trinity'),
    ('Jesus Christ', 'Savior', 'Represents the Son in the Holy Trinity'),
    ('Holy Spirit', 'Guide', 'Represents the Holy Spirit in the Holy Trinity');

-- Insert sample data for Miracles Table
INSERT INTO Miracles (Holy_Trinity_ID, Testament, Book, Verse, MiracleType, Summary)
VALUES
    (2, 'New Testament', 'John', '2:1-11', 'Transformation', 'Jesus turned water into wine'),
    (NULL, 'Old Testament', 'Exodus', '14:19-31', 'Deliverance', 'God parted the Red Sea'),
    (NULL, 'Old Testament', '2 Kings', '4:18-37', 'Resurrection', 'Elisha raised a boy from the dead');

-- Insert sample data for Prophecies Table
INSERT INTO Prophecies (Holy_Trinity_ID, Testament, Book, Verse, Summary)
VALUES
    (2, 'New Testament', 'Matthew', '16:21', 'Jesus prophesied his own death and resurrection'),
    (NULL, 'Old Testament', 'Isaiah', '53:5', 'Jesus was pierced for our transgressions'),
    (NULL, 'Old Testament', 'Isaiah', '9:6', 'Jesus was born');

-- Insert sample data for Teachings Table
INSERT INTO Teachings (Holy_Trinity_ID, Testament, Book, Verse, MainMessage, Summary)
VALUES
    (2, 'New Testament', 'Matthew', '6:14', 'Forgiveness', 'Jesus taught that forgiveness is essential'),
    (2, 'New Testament', 'Matthew', '22:39', 'Love', 'Jesus taught that love is the greatest commandment'),
    (2, 'New Testament', 'Matthew', '6:33', 'Seek God\'s Kingdom', 'Jesus taught that we should seek God\'s kingdom');

-- User Creation for Python Purposes
CREATE USER 'privateuser'@'localhost' IDENTIFIED BY 'PrivateUser111';
GRANT SELECT, INSERT, UPDATE, DELETE ON holytrinity.* TO 'privateuser'@'localhost';
FLUSH PRIVILEGES;

-- Adding constraints for better data integrity
ALTER TABLE HolyTrinity
MODIFY Name VARCHAR(23) NOT NULL,
MODIFY Purpose VARCHAR(50) NOT NULL;
