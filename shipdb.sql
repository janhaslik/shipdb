        drop database if exists kubership;
        create database kubership;

        use kubership;

        create table if not exists owners (
            ownerid int primary key auto_increment,
            name varchar(64),
            contactperson varchar(64),
            contactemail varchar(64)
        );

        create table if not exists users (
            userid int primary key auto_increment,
            name varchar(64),
            email varchar(64),
            ownerid int,
            foreign key (ownerid) references owners(ownerid)
        );

        create table if not exists ships
        (
            shipnr int primary key auto_increment,
            name varchar(64),
            owner int,
            type ENUM('Passenger', 'Cargo'),
            image varchar(64),
            currentvalue varchar(64),
            year DATE
        );

        create table if not exists planes
        (
            planenr int primary key auto_increment,
            owner int,
            type ENUM('Passenger', 'Cargo'),
            image varchar(64),
            currentvalue varchar(64),
            year DATE
        );

        create table if not exists crewmembers(
            crewmemberid int primary key auto_increment,
            name varchar(64),
            role varchar(64)
        );

        create table if not exists ships_crewmembers(
            id int primary key auto_increment,
            ship int,
            crewmember int,
            foreign key (ship) references ships(shipnr),
            foreign key (crewmember) references crewmembers(crewmemberid)
        );

        create table if not exists planes_crewmembers(
            id int primary key auto_increment,
            plane int,
            crewmember int,
            foreign key (plane) references planes(planenr),
            foreign key (crewmember) references crewmembers(crewmemberid)
        );

        CREATE TABLE IF NOT EXISTS shipments
        (
            shipmentid int primary key auto_increment,
            starttime DATE,
            endtime DATE,
            departurelocation VARCHAR(64),
            arrivallocation VARCHAR(64)
        );

        create table if not exists ships_shipments(
            id int primary key auto_increment,
            ship int,
            shipment int,
            foreign key (ship) references ships(shipnr),
            foreign key (shipment) references shipments(shipmentid),
            unique(ship, shipment)
        );

        create table if not exists planes_shipments(
            id int primary key auto_increment,
            planenr int,
            shipmentid int,
            foreign key (planenr) references planes(planenr),
            foreign key (shipmentid) references shipments(shipmentid),
            unique (planenr, shipmentid)
        );


        create table maintenances(
            maintenanceid int primary Key auto_increment,
            date DATE,
            type ENUM('Scheduled','Routine','Emergency'),
            description text
        );

        create table if not exists ships_maintenances(
            id int primary key auto_increment,
            ship int,
            maintenance int,
            foreign key (ship) references ships(shipnr),
            foreign key (maintenance) references maintenances(maintenanceid),
            unique(ship, maintenance)
        );

        create table if not exists planes_maintenances(
            id int primary key auto_increment,
            planenr int,
            maintenanceid int,
            foreign key (planenr) references planes(planenr),
            foreign key (maintenanceid) references maintenances(maintenanceid),
            unique (planenr,maintenanceid)
        );

        INSERT INTO owners (name, contactperson, contactemail)
        VALUES
        ('Red-Haired Shanks', 'Shanks', 'shanks@example.com'),
        ('Monkey D. Dragon', 'Dragon', 'dragon@example.com'),
        ('Donquixote Doflamingo', 'Doflamingo', 'doflamingo@example.com');

        INSERT INTO users (name, email, ownerid)
        VALUES
        ('Luffy', 'luffy@example.com', 1),
        ('Zoro', 'zoro@example.com', 1),
        ('Nami', 'nami@example.com', 1),
        ('Usopp', 'usopp@example.com', 1),
        ('Chopper', 'chopper@example.com', 2),
        ('Gol D. Roger', 'gol@example.com', 3),
        ('Brook', 'brook@example.com', 3);

        INSERT INTO ships (shipnr, name, owner, type, image, currentvalue, year)
        VALUES
        (899,'Thousand Sunny', 1, 'Passenger', 'sunny.jpg', '50', '2010-01-01'),
        (900,'Going Merry', 1, 'Passenger', 'merry.jpg', '20', '2000-05-15'),
        (901,'Oro Jackson', 2, 'Cargo', 'oro.jpg', '0','2000-05-15'),
        (902,'Thriller Bark', 3, 'Passenger', 'thriller.jpg', '2000','2000-05-15');

        INSERT INTO crewmembers (name, role)
        VALUES
        ('Monkey D. Luffy', 'Captain'),
        ('Roronoa Zoro', 'Swordsman'),
        ('Nami', 'Navigator'),
        ('Usopp', 'Sniper'),
        ('Tony Tony Chopper', 'Doctor'),
        ('Gol D. Roger', 'Captain'),
        ('Brook', 'Musician');

        insert into ships_crewmembers(ship, crewmember)
        values (899,1),(899,2),(902,3),(899,4),(900,5);

        INSERT INTO shipments (starttime, endtime, departurelocation, arrivallocation)
        VALUES
        ('2022-01-01', '2022-01-15', 'Fish-Man Island', 'Sabaody Archipelago'),
        ('2024-01-01', '2022-01-15', 'Dress Rosa', 'Wano Kuni'),
        ('2005-03-10', '2005-04-20', 'East Blue', 'Alabasta'),
        ('2005-03-10', '2005-04-20', 'Water 7', 'Enies Lobby'),
        ('2015-06-01', '2015-07-15', 'Florian Triangle', 'Sabaody Archipelago');

        insert into ships_shipments (ship, shipment)
        values (899,1),(900,2);

        INSERT INTO maintenances (date, type, description)
        VALUES
        ('2022-02-01', 'Scheduled', 'Thousand Sunny underwent a major engine overhaul.'),
        ('2004-05-01', 'Emergency', 'Going Merry last repairs'),
        ('2005-05-01', 'Emergency', 'Going Merry underwent extensive repairs at Water 7.'),
        ('2015-08-01', 'Routine', 'Thriller Bark received routine maintenance and repairs.');

        insert into ships_maintenances (ship, maintenance)
        values (899, 1),(900, 2),(900, 3),(902, 4);
