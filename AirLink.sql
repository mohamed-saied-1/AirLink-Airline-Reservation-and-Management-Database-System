CREATE DATABASE AirLink;
USE AirLink;

-- ==============================

DROP TABLE IF EXISTS BoardingPass;
DROP TABLE IF EXISTS CheckIn;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Passenger;
DROP TABLE IF EXISTS Seat;
DROP TABLE IF EXISTS Flight;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Airport;
DROP TABLE IF EXISTS Airline;

-- ==============================

CREATE TABLE Passenger (
    PassengerID INT PRIMARY KEY,
    Passenger_Name VARCHAR(100),
    Email VARCHAR(100),
    PassportNumber VARCHAR(50),
    Nationality VARCHAR(50),
    Phone VARCHAR(20)
);

CREATE TABLE Airline (
    AirLineID INT PRIMARY KEY,
    AirLine_Name VARCHAR(100),
    Country VARCHAR(50)
);

CREATE TABLE Airport (
    AirLPortID INT PRIMARY KEY,
    Airport_Name VARCHAR(100),
    Country VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    AirLPortID INT,
    Employee_Name VARCHAR(50),
    Position VARCHAR(50),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Salary DECIMAL(10, 2),
    FOREIGN KEY (AirLPortID) REFERENCES Airport(AirLPortID)
);

CREATE TABLE Flight (
    FlightID INT PRIMARY KEY,
    FlightNumber VARCHAR(20),
    Origin INT,
    Destination INT,
    DepartureTime DATETIME,
    ArrivalTime DATETIME,
    AirLineID INT,
    FOREIGN KEY (Origin) REFERENCES Airport(AirLPortID),
    FOREIGN KEY (Destination) REFERENCES Airport(AirLPortID),
    FOREIGN KEY (AirLineID) REFERENCES Airline(AirLineID)
);

CREATE TABLE Seat (
    SeatID INT PRIMARY KEY,
    FlightID INT,
    SeatNumber VARCHAR(10),
    Class VARCHAR(20),
    IsAvailable BIT,
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);

CREATE TABLE Booking (
    BookingID INT PRIMARY KEY,
    PassengerID INT,
    FlightID INT,
    BookingDate DATE,
    Booking_Status VARCHAR(20),
    TotalCost INT,
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID),
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);

CREATE TABLE CheckIn (
    CheckID INT PRIMARY KEY,
    BookingID INT,
    CheckInTime DATETIME,
    BaggageCount INT,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

CREATE TABLE BoardingPass (
    PassID INT PRIMARY KEY,
    CheckID INT,
    QRCode VARCHAR(255),
    GateNumber VARCHAR(10),
    Boarding_Zone VARCHAR(10),
    FOREIGN KEY (CheckID) REFERENCES CheckIn(CheckID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    BookingID INT,
    Amount INT,
    Payment_Date DATE,
    Method VARCHAR(50),
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);

-- ==============================

INSERT INTO Airport (AirLPortID, Airport_Name, Country, City) VALUES
(301, 'JFK International', 'USA', 'New York'), 
(302, 'Heathrow', 'UK', 'London'),             
(303, 'Dubai Intl', 'UAE', 'Dubai'),           
(304, 'Indira Gandhi Intl', 'India', 'Delhi'), 
(305, 'Charles de Gaulle', 'France', 'Paris'), 
(306, 'Haneda Airport', 'Japan', 'Tokyo'),     
(307, 'Frankfurt Airport', 'Germany', 'Frankfurt'), 
(308, 'Incheon Airport', 'South Korea', 'Seoul'),   
(309, 'Toronto Pearson', 'Canada', 'Toronto'),      
(310, 'Beijing Capital', 'China', 'Beijing');       

INSERT INTO Airline (AirLineID, AirLine_Name, Country) VALUES
(401, 'SkyHigh Airlines', 'USA'),        
(402, 'AirGlobal', 'UK'),                
(403, 'FlyAsia', 'India'),               
(404, 'Desert Wings', 'UAE'),            
(405, 'EuroWings', 'Germany'),           
(406, 'Pacific Skies', 'Japan'),         
(407, 'NorthLines', 'Canada'),           
(408, 'Sahara Air', 'Egypt'),            
(409, 'Qatar Airlines', 'UK'),        
(410, 'Air France', 'France');           

INSERT INTO Flight (FlightID, FlightNumber, Origin, Destination, DepartureTime, ArrivalTime, AirLineID) VALUES
(201, 'SH101', 301, 302, '2025-06-01 08:00', '2025-06-01 12:00', 401),
(202, 'AG202', 302, 303, '2025-06-02 09:00', '2025-06-02 13:00', 402),
(203, 'FA303', 301, 304, '2025-06-03 10:00', '2025-06-03 14:00', 403),
(204, 'DW404', 303, 305, '2025-06-04 11:00', '2025-06-04 15:00', 404),
(205, 'EW505', 305, 301, '2025-06-05 12:00', '2025-06-05 16:00', 405),
(206, 'PS606', 304, 302, '2025-06-06 13:00', '2025-06-06 17:00', 406),
(207, 'NL707', 306, 307, '2025-06-07 14:00', '2025-06-07 18:00', 407),
(208, 'SA808', 307, 303, '2025-06-08 15:00', '2025-06-08 19:00', 408),
(209, 'QR909', 308, 309, '2025-06-09 16:00', '2025-06-09 20:00', 409),
(210, 'AF010', 309, 301, '2025-06-10 17:00', '2025-06-10 21:00', 410);

INSERT INTO Seat (SeatID, FlightID, SeatNumber, Class, IsAvailable) VALUES
(501, 201, '1A', 'Business', 1),
(502, 201, '1B', 'Business', 1),
(503, 202, '12A', 'Economy', 0),
(504, 202, '12B', 'Economy', 1),
(505, 203, '2A', 'Business', 1),
(506, 204, '15C', 'Economy', 1),
(507, 205, '3B', 'Premium', 0),
(508, 206, '6D', 'Economy', 1),
(509, 207, '4C', 'Economy', 1),
(510, 208, '5A', 'Premium', 1);

INSERT INTO Passenger (PassengerID, Passenger_Name, Email, PassportNumber, Nationality, Phone) VALUES
(101, 'Ahmed Ali', 'Ahmed.j@example.com', 'P123456', 'Egypt', '+12015550101'),
(102, 'Mohammed Khan', 'm.khan@example.com', 'P234567', 'UAE', NULL),
(103, 'Chen Wei', 'c.wei@example.cn', 'P345678', 'China', NULL),
(104, 'Priya Sharma', 'p.sharma@example.in', 'P456789', 'India', NULL),
(105, 'Carlos Gomez', 'c.gomez@example.mx', 'P567890', 'Mexico', NULL),
(106, 'Laura Müller', 'l.muller@example.de', 'P678901', 'Germany', NULL),
(107, 'Yuki Tanaka', 'y.tanaka@example.jp', 'P789012', 'Japan', NULL),
(108, 'Ahmed Ali', 'a.ali@example.sa', 'P890123', 'Saudi Arabia', NULL),
(109, 'Sophia Lee', 's.lee@example.kr', 'P901234', 'UK', NULL),
(110, 'John Smith', 'j.smith@example.ca', 'P012345', 'UK', NULL);

INSERT INTO Booking (BookingID, PassengerID, FlightID, BookingDate, Booking_Status, TotalCost) VALUES
(301, 101, 201, '2025-05-01', 'Confirmed', 500),
(302, 102, 202, '2025-05-02', 'Confirmed', 600),
(303, 103, 203, '2025-05-03', 'Confirmed', 700),
(304, 104, 204, '2025-05-04', 'Confirmed', 800),
(305, 105, 205, '2025-05-05', 'Confirmed', 900),
(306, 106, 206, '2025-05-06', 'Confirmed', 1000),
(307, 107, 207, '2025-05-07', 'Confirmed', 1100),
(308, 108, 208, '2025-05-08', 'Confirmed', 1200),
(309, 109, 209, '2025-05-09', 'Confirmed', 1300),
(310, 110, 210, '2025-05-10', 'Confirmed', 1400);

INSERT INTO CheckIn (CheckID, BookingID, CheckInTime, BaggageCount) VALUES
(401, 301, '2025-06-01 06:00', 3),
(402, 302, '2025-06-02 07:00', 3),
(403, 303, '2025-06-03 08:00', 4),
(404, 304, '2025-06-04 09:00', 3),
(405, 305, '2025-06-05 10:00', 5),
(406, 306, '2025-06-06 11:00', 6),
(407, 307, '2025-06-07 12:00', 5),
(408, 308, '2025-06-08 13:00', 5),
(409, 309, '2025-06-09 14:00', 1),
(410, 310, '2025-06-10 15:00', 2);

INSERT INTO BoardingPass (PassID, CheckID, QRCode, GateNumber, Boarding_Zone) VALUES
(501, 401, 'QR1A', 'A1', 'Zone 1'),
(502, 402, 'QR2A', 'B2', 'Zone 2'),
(503, 403, 'QR3A', 'C3', 'Zone 3'),
(504, 404, 'QR4A', 'D4', 'Zone 4'),
(505, 405, 'QR5A', 'E5', 'Zone 5'),
(506, 406, 'QR6A', 'F6', 'Zone 6'),
(507, 407, 'QR7A', 'G7', 'Zone 7'),
(508, 408, 'QR8A', 'H8', 'Zone 8'),
(509, 409, 'QR9A', 'I9', 'Zone 9'),
(510, 410, 'QR10A', 'J10', 'Zone 10');

INSERT INTO Payment (PaymentID, BookingID, Amount, Payment_Date, Method) VALUES
(601, 301, 500, '2025-05-01', 'Credit Card'),
(602, 302, 600, '2025-05-02', 'Debit Card'),
(603, 303, 700, '2025-05-03', 'PayPal'),
(604, 304, 800, '2025-05-04', 'Credit Card'),
(605, 305, 900, '2025-05-05', 'Debit Card'),
(606, 306, 1000, '2025-05-06', 'PayPal'),
(607, 307, 1100, '2025-05-07', 'Credit Card'),
(608, 308, 1200, '2025-05-08', 'Debit Card'),
(609, 309, 1300, '2025-05-09', 'PayPal'),
(610, 310, 1400, '2025-05-10', 'Credit Card');

INSERT INTO Employee (EmployeeID, AirLPortID, Employee_Name, Position, Phone, Email, Salary) VALUES
(501, 301, 'John Doe', 'Manager', '+12015550101', 'j.doe@example.com', 50000.00),
(502, 302, 'Jane Smith', 'Clerk', '+12015550102', 'j.smith@example.com', 40000.00),
(503, 303, 'Mark Brown', 'Security', '+12015550103', 'm.brown@example.com', 35000.00),
(504, 304, 'Emily White', 'Ticket Agent', '+12015550104', 'e.white@example.com', 42000.00),
(505, 305, 'Michael Green', 'Ground Staff', '+12015550105', 'm.green@example.com', 37000.00),
(506, 306, 'Sarah Blue', 'Customer Service', '+12015550106', 's.blue@example.com', 45000.00),
(507, 307, 'David Black', 'Maintenance', '+12015550107', 'd.black@example.com', 48000.00),
(508, 308, 'Linda Yellow', 'Baggage Handler', '+12015550108', 'l.yellow@example.com', 36000.00),
(509, 309, 'Chris Red', 'Pilot', '+12015550109', 'c.red@example.com', 70000.00),
(510, 310, 'Patricia Pink', 'Flight Attendant', '+12015550110', 'p.pink@example.com', 44000.00);

--======================

ALTER TABLE Passenger ADD EmergencyContact VARCHAR(100);

-- =====================

-- Insert
INSERT INTO Passenger VALUES (111, 'Eva Green', 'eva.g@example.com', 'P112233', 'UK', '+442011234567');

-- Update
UPDATE Passenger SET Phone = '+1234567890' WHERE PassengerID = 111;


-- Delete
DELETE FROM Passenger WHERE PassengerID = 111;

-- Select
SELECT * FROM Passenger;

-- ======================
CREATE USER ecu FOR LOGIN ecu;

GRANT SELECT, INSERT ON Passenger TO ecu;
REVOKE INSERT ON Passenger FROM ecu;

-- ======================

BEGIN TRANSACTION;
UPDATE Seat SET IsAvailable = 0 WHERE SeatID = 501;
COMMIT;

-- ======================

SELECT * FROM Passenger;

SELECT COUNT(*) AS UK_Passengers FROM Passenger WHERE Nationality = 'UK';


SELECT P.Passenger_Name, b.BookingID, b.BookingDate, b.Booking_Status
FROM Passenger p
JOIN Booking b ON p.PassengerID = b.PassengerID;