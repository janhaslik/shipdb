-- Create database (PL/SQL does not directly create databases like MySQL)
-- Assuming you're already connected to the correct schema/user in Oracle.

--DROP TABLE Log;

-- Drop Tables with Foreign Keys
/*
DROP TABLE planes_maintenances;
DROP TABLE planes_shipments;
DROP TABLE planes_crewmembers;

DROP TABLE ships_shipments;
DROP TABLE ships_maintenances;
DROP TABLE ships_crewmembers;

DROP TABLE users;

-- Drop Tables without Foreign Keys
DROP TABLE maintenances;
DROP TABLE shipments;
DROP TABLE crewmembers;

DROP TABLE planes;
DROP TABLE ships;

DROP TABLE owners;
*/

-- Create owners table
CREATE TABLE owners
(
    ownerid       NUMBER PRIMARY KEY,
    name          VARCHAR2(64),
    contactperson VARCHAR2(64),
    contactemail  VARCHAR2(64)
);

-- Create users table
CREATE TABLE users
(
    userid  NUMBER PRIMARY KEY,
    name    VARCHAR2(64),
    email   VARCHAR2(64),
    ownerid NUMBER,
    CONSTRAINT users_fk_ownerid FOREIGN KEY (ownerid) REFERENCES owners (ownerid)
);

-- Create ships table
CREATE TABLE ships
(
    shipnr       NUMBER PRIMARY KEY,
    name         VARCHAR2(64),
    owner        NUMBER,
    type         VARCHAR2(20) CHECK (type IN ('Passenger', 'Cargo')),
    image        VARCHAR2(64),
    currentvalue VARCHAR2(64),
    year         DATE,
    foreign key (owner) references owners (ownerid)
);

-- Create planes table
CREATE TABLE planes
(
    planenr      NUMBER PRIMARY KEY,
    owner        NUMBER,
    type         VARCHAR2(20) CHECK (type IN ('Passenger', 'Cargo')),
    image        VARCHAR2(64),
    currentvalue VARCHAR2(64),
    year         DATE,
    foreign key (owner) references owners (ownerid)
);

-- Create crewmembers table
CREATE TABLE crewmembers
(
    crewmemberid NUMBER PRIMARY KEY,
    name         VARCHAR2(64),
    role         VARCHAR2(64)
);

-- Create ships_crewmembers table
CREATE TABLE ships_crewmembers
(
    id         NUMBER PRIMARY KEY,
    ship       NUMBER,
    crewmember NUMBER,
    CONSTRAINT ships_crewmembers_fk_ship FOREIGN KEY (ship) REFERENCES ships (shipnr),
    CONSTRAINT ships_crewmembers_fk_crewmember FOREIGN KEY (crewmember) REFERENCES crewmembers (crewmemberid),
    CONSTRAINT ships_crewmembers_unique_ship_crewmember UNIQUE (ship, crewmember)
);

-- Create planes_crewmembers table
CREATE TABLE planes_crewmembers
(
    id         NUMBER PRIMARY KEY,
    plane      NUMBER,
    crewmember NUMBER,
    CONSTRAINT planes_crewmembers_fk_planenr FOREIGN KEY (plane) REFERENCES planes (planenr),
    CONSTRAINT planes_crewmembers_fk_crewmember FOREIGN KEY (crewmember) REFERENCES crewmembers (crewmemberid),
    CONSTRAINT planes_crewmembers_unique_plane_crewmember UNIQUE (plane, crewmember)
);

-- Create shipments table
CREATE TABLE shipments
(
    shipmentid        NUMBER PRIMARY KEY,
    starttime         DATE,
    endtime           DATE,
    departurelocation VARCHAR2(64),
    arrivallocation   VARCHAR2(64)
);

-- Create ships_shipments table
CREATE TABLE ships_shipments
(
    id       NUMBER PRIMARY KEY,
    ship     NUMBER,
    shipment NUMBER,
    CONSTRAINT ships_shipments_fk_ship FOREIGN KEY (ship) REFERENCES ships (shipnr),
    CONSTRAINT ships_shipments_fk_shipment FOREIGN KEY (shipment) REFERENCES shipments (shipmentid),
    CONSTRAINT ships_shipments_unique_ship_shipment UNIQUE (ship, shipment)
);

-- Create planes_shipments table
CREATE TABLE planes_shipments
(
    id         NUMBER PRIMARY KEY,
    planenr    NUMBER,
    shipmentid NUMBER,
    CONSTRAINT planes_shipments_fk_planenr FOREIGN KEY (planenr) REFERENCES planes (planenr),
    CONSTRAINT planes_shipments_fk_shipmentid FOREIGN KEY (shipmentid) REFERENCES shipments (shipmentid),
    CONSTRAINT planes_shipments_unique_planenr_shipmentid UNIQUE (planenr, shipmentid)
);

-- Create maintenances table
CREATE TABLE maintenances
(
    maintenanceid          NUMBER PRIMARY KEY,
    maintenanceDate        DATE,
    type                   VARCHAR2(20),
    maintenanceDescription varchar(200)
);

-- Create ships_maintenances table
CREATE TABLE ships_maintenances
(
    id          NUMBER PRIMARY KEY,
    ship        NUMBER,
    maintenance NUMBER,
    CONSTRAINT ships_maintenances_fk_ship FOREIGN KEY (ship) REFERENCES ships (shipnr),
    CONSTRAINT ships_maintenances_fk_maintenance FOREIGN KEY (maintenance) REFERENCES maintenances (maintenanceid),
    CONSTRAINT ships_maintenances_unique_ship_maintenance UNIQUE (ship, maintenance)
);

-- Create planes_maintenances table
CREATE TABLE planes_maintenances
(
    id            NUMBER PRIMARY KEY,
    planenr       NUMBER,
    maintenanceid NUMBER,
    CONSTRAINT planes_maintenances_fk_planenr FOREIGN KEY (planenr) REFERENCES planes (planenr),
    CONSTRAINT planes_maintenances_fk_maintenanceid FOREIGN KEY (maintenanceid) REFERENCES maintenances (maintenanceid),
    CONSTRAINT planes_maintenances_unique_planenr_maintenanceid UNIQUE (planenr, maintenanceid)
);
-- Create Logging Table
CREATE TABLE Log
(
    id          NUMBER GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1) PRIMARY KEY,
    severity    VARCHAR2(15),
    description VARCHAR2(100),
    logDate DATE
);

-- Insert data into owners table
INSERT INTO owners (ownerid, name, contactperson, contactemail)
VALUES (1, 'Red-Haired Shanks', 'Shanks', 'shanks@example.com');
INSERT INTO owners (ownerid, name, contactperson, contactemail)
VALUES (2, 'Monkey D. Dragon', 'Dragon', 'dragon@example.com');
INSERT INTO owners (ownerid, name, contactperson, contactemail)
VALUES (3, 'Donquixote Doflamingo', 'Doflamingo', 'doflamingo@example.com');

-- Insert data into users table
INSERT INTO users (userid, name, email, ownerid)
VALUES (1, 'Luffy', 'luffy@example.com', 1);
INSERT INTO users (userid, name, email, ownerid)
VALUES (2, 'Zoro', 'zoro@example.com', 1);
INSERT INTO users (userid, name, email, ownerid)
VALUES (3, 'Nami', 'nami@example.com', 1);
INSERT INTO users (userid, name, email, ownerid)
VALUES (4, 'Usopp', 'usopp@example.com', 1);
INSERT INTO users (userid, name, email, ownerid)
VALUES (5, 'Chopper', 'chopper@example.com', 2);
INSERT INTO users (userid, name, email, ownerid)
VALUES (6, 'Gol D. Roger', 'gol@example.com', 3);
INSERT INTO users (userid, name, email, ownerid)
VALUES (7, 'Brook', 'brook@example.com', 3);


-- Insert data into ships table
INSERT INTO ships (shipnr, name, owner, type, image, currentvalue, year)
VALUES (899, 'Thousand Sunny', 1, 'Passenger', 'sunny.jpg', '50', TO_DATE('2010-01-01', 'YYYY-MM-DD'));
INSERT INTO ships (shipnr, name, owner, type, image, currentvalue, year)
VALUES (900, 'Going Merry', 1, 'Passenger', 'merry.jpg', '20', TO_DATE('2000-05-15', 'YYYY-MM-DD'));
INSERT INTO ships (shipnr, name, owner, type, image, currentvalue, year)
VALUES (901, 'Oro Jackson', 2, 'Cargo', 'oro.jpg', '0', TO_DATE('2000-05-15', 'YYYY-MM-DD'));
INSERT INTO ships (shipnr, name, owner, type, image, currentvalue, year)
VALUES (902, 'Thriller Bark', 3, 'Passenger', 'thriller.jpg', '2000', TO_DATE('2000-05-15', 'YYYY-MM-DD'));

-- Insert data into crewmembers table
INSERT INTO crewmembers (crewmemberid, name, role)
VALUES (1, 'Monkey D. Luffy', 'Captain');
INSERT INTO crewmembers (crewmemberid, name, role)
VALUES (2, 'Roronoa Zoro', 'Swordsman');
INSERT INTO crewmembers (crewmemberid, name, role)
VALUES (3, 'Nami', 'Navigator');
INSERT INTO crewmembers (crewmemberid, name, role)
VALUES (4, 'Usopp', 'Sniper');
INSERT INTO crewmembers (crewmemberid, name, role)
VALUES (5, 'Tony Tony Chopper', 'Doctor');
INSERT INTO crewmembers (crewmemberid, name, role)
VALUES (6, 'Gol D. Roger', 'Captain');
INSERT INTO crewmembers (crewmemberid, name, role)
VALUES (7, 'Brook', 'Musician');

-- Insert data into ships_crewmembers table
INSERT INTO ships_crewmembers (id, ship, crewmember)
VALUES (1, 899, 1);
INSERT INTO ships_crewmembers (id, ship, crewmember)
VALUES (2, 899, 2);
INSERT INTO ships_crewmembers (id, ship, crewmember)
VALUES (3, 902, 3);
INSERT INTO ships_crewmembers (id, ship, crewmember)
VALUES (4, 899, 4);
INSERT INTO ships_crewmembers (id, ship, crewmember)
VALUES (5, 900, 5);

-- Insert data into shipments table
INSERT INTO shipments (shipmentid, starttime, endtime, departurelocation, arrivallocation)
VALUES (1, TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'Fish-Man Island',
        'Sabaody Archipelago');
INSERT INTO shipments (shipmentid, starttime, endtime, departurelocation, arrivallocation)
VALUES (2, TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'Dress Rosa', 'Wano Kuni');
INSERT INTO shipments (shipmentid, starttime, endtime, departurelocation, arrivallocation)
VALUES (3, TO_DATE('2005-03-10', 'YYYY-MM-DD'), TO_DATE('2005-04-20', 'YYYY-MM-DD'), 'East Blue', 'Alabasta');
INSERT INTO shipments (shipmentid, starttime, endtime, departurelocation, arrivallocation)
VALUES (4, TO_DATE('2005-03-10', 'YYYY-MM-DD'), TO_DATE('2005-04-20', 'YYYY-MM-DD'), 'Water 7', 'Enies Lobby');
INSERT INTO shipments (shipmentid, starttime, endtime, departurelocation, arrivallocation)
VALUES (5, TO_DATE('2015-06-01', 'YYYY-MM-DD'), TO_DATE('2015-07-15', 'YYYY-MM-DD'), 'Florian Triangle',
        'Sabaody Archipelago');

-- Insert data into ships_shipments table
INSERT INTO ships_shipments (id, ship, shipment)
VALUES (1, 899, 1);
INSERT INTO ships_shipments (id, ship, shipment)
VALUES (2, 900, 2);

-- Insert data into maintenances table
INSERT INTO maintenances (maintenanceid, maintenanceDate, type, maintenanceDescription)
VALUES (1, TO_DATE('2022-02-01', 'YYYY-MM-DD'), 'Scheduled', 'Thousand Sunny underwent a major engine overhaul.');
INSERT INTO maintenances (maintenanceid, maintenanceDate, type, maintenanceDescription)
VALUES (2, TO_DATE('2004-05-01', 'YYYY-MM-DD'), 'Emergency', 'Going Merry last repairs');
INSERT INTO maintenances (maintenanceid, maintenanceDate, type, maintenanceDescription)
VALUES (3, TO_DATE('2005-05-01', 'YYYY-MM-DD'), 'Emergency', 'Going Merry underwent extensive repairs at Water 7.');
INSERT INTO maintenances (maintenanceid, maintenanceDate, type, maintenanceDescription)
VALUES (4, TO_DATE('2015-08-01', 'YYYY-MM-DD'), 'Routine', 'Thriller Bark received routine maintenance and repairs.');

-- Insert data into ships_maintenances table
INSERT INTO ships_maintenances (id, ship, maintenance)
VALUES (1, 899, 1);
INSERT INTO ships_maintenances (id, ship, maintenance)
VALUES (2, 900, 2);
INSERT INTO ships_maintenances (id, ship, maintenance)
VALUES (3, 900, 3);
INSERT INTO ships_maintenances (id, ship, maintenance)
VALUES (4, 902, 4);

select *
from owners;

