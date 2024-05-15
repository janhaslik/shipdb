-- Business logic

-- Add a owner
/* Jan Haslik */
CREATE OR REPLACE FUNCTION add_owner(
    v_ownerid_param IN NUMBER,
    v_name_param IN VARCHAR2,
    v_contactperson_param IN VARCHAR2,
    v_contactemail_param IN VARCHAR2
) RETURN VARCHAR2 IS
BEGIN
    INSERT INTO owners (ownerid, name, contactperson, contactemail)
    VALUES (v_ownerid_param, v_name_param, v_contactperson_param, v_contactemail_param);

    COMMIT;

    RETURN 'Owner added successfully';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RETURN 'Owner with the same ID already exists';
    WHEN OTHERS THEN
        RETURN 'Error adding owner';
END add_owner;

-- Add a user
/* Jan Haslik */
CREATE OR REPLACE FUNCTION add_user(
    v_userid_param IN NUMBER,
    v_name_param IN VARCHAR2,
    v_email_param IN VARCHAR2,
    v_ownerid_param IN NUMBER
) RETURN VARCHAR2 IS
    owner_count NUMBER;
BEGIN
    -- Check if the owner exists
    SELECT COUNT(*) INTO owner_count FROM owners WHERE ownerid = v_ownerid_param;
    IF owner_count = 0 THEN
        RETURN 'Owner not found';
    END IF;

    INSERT INTO users (userid, name, email, ownerid)
    VALUES (v_userid_param, v_name_param, v_email_param, v_ownerid_param);

    COMMIT;

    RETURN 'User added successfully';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RETURN 'User with the same NR already exists';
    WHEN OTHERS THEN
        RETURN 'Error adding user';
END add_user;

-- Add a ship
/* Jan Haslik */
CREATE OR REPLACE FUNCTION add_ship(
    v_shipnr_param IN NUMBER,
    v_name_param IN VARCHAR2,
    v_owner_param IN NUMBER,
    v_type_param IN VARCHAR2,
    v_image_param IN VARCHAR2,
    v_currentvalue_param IN VARCHAR2,
    v_year_param IN DATE
) RETURN VARCHAR2 IS
    owner_count NUMBER;
BEGIN
    -- Check if the owner exists
    SELECT COUNT(*) INTO owner_count FROM owners WHERE ownerid = v_owner_param;
    IF owner_count = 0 THEN
        RETURN 'Owner not found';
    END IF;

    INSERT INTO ships (shipnr, name, owner, type, image, currentvalue, year)
    VALUES (v_shipnr_param, v_name_param, v_owner_param, v_type_param, v_image_param, v_currentvalue_param,
            v_year_param);

    COMMIT;

    RETURN 'Ship added successfully';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RETURN 'Ship with the same NR already exists';
    WHEN OTHERS THEN
        RETURN 'Error adding ship';
END add_ship;

-- Add a plane
/* Daniel Kunesch */
CREATE OR REPLACE FUNCTION add_plane(
    v_planenr_param IN NUMBER,
    v_owner_param IN NUMBER,
    v_type_param IN VARCHAR2,
    v_image_param IN VARCHAR2,
    v_currentvalue_param IN VARCHAR2,
    v_year_param IN DATE
) RETURN VARCHAR2 IS
    owner_count NUMBER;
BEGIN
    -- Check if the owner exists
    SELECT COUNT(*) INTO owner_count FROM owners WHERE ownerid = v_owner_param;
    IF owner_count = 0 THEN
        RETURN 'Owner not found';
    END IF;

    INSERT INTO planes (planenr, owner, type, image, currentvalue, year)
    VALUES (v_planenr_param, v_owner_param, v_type_param, v_image_param, v_currentvalue_param, v_year_param);

    COMMIT;

    RETURN 'Plane added successfully';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RETURN 'Plane with the same ID already exists';
    WHEN OTHERS THEN
        RETURN 'Error adding Plane';
END add_plane;

-- Add a crewmember
/* Daniel Kunesch */
CREATE OR REPLACE FUNCTION add_crewmember(
    v_crewmemberid_param IN NUMBER,
    v_name_param IN VARCHAR2,
    v_role_param IN VARCHAR2
) RETURN VARCHAR2 IS
BEGIN
    INSERT INTO crewmembers (crewmemberid, name, role)
    VALUES (v_crewmemberid_param, v_name_param, v_role_param);

    COMMIT;

    RETURN 'Crewmember added successfully';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RETURN 'Crewmember with the same ID already exists';
    WHEN OTHERS THEN
        RETURN 'Error adding Crewmember';
END add_crewmember;

-- Add a crewmember to a ship
/* Daniel Kunesch */
CREATE OR REPLACE FUNCTION add_ship_crewmember(
    v_id_param IN NUMBER,
    v_ship_param IN NUMBER,
    v_crewmember_param IN NUMBER
) RETURN VARCHAR2 IS
    ship_count       NUMBER;
    crewmember_count NUMBER;
BEGIN
    -- Check if the owner exists
    SELECT COUNT(*) INTO ship_count FROM ships WHERE shipnr = v_ship_param;
    IF ship_count = 0 THEN
        RETURN 'Ship not found';
    END IF;

    SELECT COUNT(*) INTO crewmember_count FROM crewmembers WHERE crewmemberid = v_crewmember_param;
    IF crewmember_count = 0 THEN
        RETURN 'Crewmember not found';
    END IF;

    INSERT INTO ships_crewmembers (id, ship, crewmember)
    VALUES (v_id_param, v_ship_param, v_crewmember_param);

    COMMIT;

    RETURN 'Ships_Crewmember added successfully';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RETURN 'Ships_Crewmember with the same id or combination already exists';
    WHEN OTHERS THEN
        RETURN 'Error adding Ships_Crewmember';
END add_ship_crewmember;

-- Add a crewmember to a plane
/* Daniel Kunesch */
CREATE OR REPLACE FUNCTION add_plane_crewmember(
    v_id_param IN NUMBER,
    v_plane_param IN NUMBER,
    v_crewmember_param IN NUMBER
) RETURN VARCHAR2 IS
    plane_count      NUMBER;
    crewmember_count NUMBER;
BEGIN
    -- Check if the owner exists
    SELECT COUNT(*) INTO plane_count FROM planes WHERE planenr = v_plane_param;
    IF plane_count = 0 THEN
        RETURN 'Plane not found';
    END IF;

    SELECT COUNT(*) INTO crewmember_count FROM crewmembers WHERE crewmemberid = v_crewmember_param;
    IF crewmember_count = 0 THEN
        RETURN 'Crewmember not found';
    END IF;

    INSERT INTO ships_crewmembers (id, ship, crewmember)
    VALUES (v_id_param, v_plane_param, v_crewmember_param);

    COMMIT;

    RETURN 'Ships_Crewmember added successfully';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RETURN 'Ships_Crewmember with the same id or combination already exists';
    WHEN OTHERS THEN
        RETURN 'Error adding Plane_Crewmember';
END add_plane_crewmember;

-- Add a shipment
/* Daniel Kunesch*/
CREATE OR REPLACE FUNCTION add_shipment(
    v_shipmentid_param IN NUMBER,
    v_starttime_param IN DATE,
    v_endtime_param IN DATE,
    v_departurelocation_param IN VARCHAR2,
    v_arrivallocation_param IN VARCHAR2
) RETURN VARCHAR2 IS
BEGIN
    INSERT INTO shipments (shipmentid, starttime, endtime, departurelocation, arrivallocation)
    VALUES (v_shipmentid_param, v_starttime_param, v_endtime_param, v_departurelocation_param, v_arrivallocation_param);

    COMMIT;

    RETURN 'Shipment added successfully';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RETURN 'Shipment with the same ID already exists';
    WHEN OTHERS THEN
        RETURN 'Error adding Shipment';
END add_shipment;

-- Add a shipment to a ship
/* Daniel Kunesch */
CREATE OR REPLACE FUNCTION add_ship_shipment(
    v_id_param IN NUMBER,
    v_ship_param IN NUMBER,
    v_shipment_param IN NUMBER
) RETURN VARCHAR2 IS
    ship_count     NUMBER;
    shipment_count NUMBER;
BEGIN
    -- Check if the owner exists
    SELECT COUNT(*) INTO ship_count FROM ships WHERE shipnr = v_ship_param;
    IF ship_count = 0 THEN
        RETURN 'Ship not found';
    END IF;

    SELECT COUNT(*) INTO shipment_count FROM shipments WHERE shipmentid = v_shipment_param;
    IF shipment_count = 0 THEN
        RETURN 'Shipment not found';
    END IF;

    INSERT INTO ships_shipments (id, ship, shipment)
    VALUES (v_id_param, v_ship_param, v_shipment_param);

    COMMIT;

    RETURN 'Ships_Shipment added successfully';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RETURN 'Ships_Shipment with the same id or combination already exists';
    WHEN OTHERS THEN
        RETURN 'Error adding Ships_Shipment';
END add_ship_shipment;

-- Add a shipment to a plane
/* Daniel Kunesch */
CREATE OR REPLACE FUNCTION add_plane_shipment(
    v_id_param IN NUMBER,
    v_plane_param IN NUMBER,
    v_shipment_param IN NUMBER
) RETURN VARCHAR2 IS
    plane_count    NUMBER;
    shipment_count NUMBER;
BEGIN
    -- Check if the owner exists
    SELECT COUNT(*) INTO plane_count FROM planes WHERE planenr = v_plane_param;
    IF plane_count = 0 THEN
        RETURN 'Plane not found';
    END IF;

    SELECT COUNT(*) INTO shipment_count FROM shipments WHERE shipmentid = v_shipment_param;
    IF shipment_count = 0 THEN
        RETURN 'Shipment not found';
    END IF;

    INSERT INTO ships_shipments (id, ship, shipment)
    VALUES (v_id_param, v_plane_param, v_shipment_param);

    COMMIT;

    RETURN 'Planes_Shipment added successfully';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RETURN 'Planes_Shipment with the same id or combination already exists';
    WHEN OTHERS THEN
        RETURN 'Error adding Planes_Shipment';
END add_plane_shipment;

-- Add a maintenance
/**/

-- Schedule a Maintenance for a Ship
/**/

-- Schedule a Maintenance for a Plane
/**/

-- Trigger to prevent Insertion between 23:00 and 05:00
/* Jan Haslik */
create or replace trigger BusinessHoursTriggerShipments
    before insert or update or delete
    on SHIPMENTS
    for each row
begin
    if sysdate between '23:00' and '05:00' then
        raise_application_error(-20001, 'not allowed between 5 and 23');
    end if;
end;
-- Trigger to prevent Insertion between 23:00 and 05:00
/* Jan Haslik */
create or replace trigger BusinessHoursTriggerMaintenances
    before insert or update or delete
    on MAINTENANCES
    for each row
begin
    if sysdate between '23:00' and '05:00' then
        raise_application_error(-20001, 'not allowed between 5 and 23');
    end if;
end;

-- Complex Procedure Generate_Owner_Plane_Fleet_Report
/* Jan Haslik */
CREATE OR REPLACE PROCEDURE Generate_Owner_Plane_Fleet_Report(p_ownerid IN NUMBER) IS
BEGIN
    -- Output owner details
    FOR owner_rec IN (
        SELECT name, contactperson, contactemail
        FROM owners
        WHERE ownerid = p_ownerid
        )
        LOOP
            DBMS_OUTPUT.PUT_LINE('Owner: ' || owner_rec.name);
            DBMS_OUTPUT.PUT_LINE('Contact Person: ' || owner_rec.contactperson);
            DBMS_OUTPUT.PUT_LINE('Contact Email: ' || owner_rec.contactemail);
            DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
        END LOOP;

    -- Output planes details
    FOR plane_rec IN (
        SELECT planenr, type, image, currentvalue, year
        FROM planes
        WHERE owner = p_ownerid
        )
        LOOP
            DBMS_OUTPUT.PUT_LINE('Plane Number: ' || plane_rec.planenr);
            DBMS_OUTPUT.PUT_LINE('Type: ' || plane_rec.type);
            DBMS_OUTPUT.PUT_LINE('Image: ' || plane_rec.image);
            DBMS_OUTPUT.PUT_LINE('Current Value: ' || plane_rec.currentvalue);
            DBMS_OUTPUT.PUT_LINE('Year: ' || TO_CHAR(plane_rec.year, 'YYYY'));
            DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');

            -- Output associated crewmembers
            DBMS_OUTPUT.PUT_LINE('Crewmembers:');
            FOR crew_rec IN (
                SELECT c.name, c.role
                FROM crewmembers c
                         JOIN planes_crewmembers pc ON c.crewmemberid = pc.crewmember
                WHERE pc.plane = plane_rec.planenr
                )
                LOOP
                    DBMS_OUTPUT.PUT_LINE('    Name: ' || crew_rec.name || ', Role: ' || crew_rec.role);
                END LOOP;

            DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');

            -- Output associated shipments
            DBMS_OUTPUT.PUT_LINE('Shipments:');
            FOR shipment_rec IN (
                SELECT s.shipmentid, s.starttime, s.endtime, s.departurelocation, s.arrivallocation
                FROM shipments s
                         JOIN planes_shipments ps ON s.shipmentid = ps.shipmentid
                WHERE ps.planenr = plane_rec.planenr
                )
                LOOP
                    DBMS_OUTPUT.PUT_LINE('    Shipment ID: ' || shipment_rec.shipmentid);
                    DBMS_OUTPUT.PUT_LINE('    Departure: ' || shipment_rec.departurelocation || ', Arrival: ' ||
                                         shipment_rec.arrivallocation);
                    DBMS_OUTPUT.PUT_LINE('    Start Time: ' || shipment_rec.starttime || ', End Time: ' ||
                                         shipment_rec.endtime);
                END LOOP;

            DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');

            -- Output associated maintenances
            DBMS_OUTPUT.PUT_LINE('Maintenances:');
            FOR maintenance_rec IN (
                SELECT m.maintenanceid, m.maintenanceDate, m.type, m.maintenanceDescription
                FROM maintenances m
                         JOIN planes_maintenances pm ON m.maintenanceid = pm.maintenanceid
                WHERE pm.planenr = plane_rec.planenr
                )
                LOOP
                    DBMS_OUTPUT.PUT_LINE('    Maintenance ID: ' || maintenance_rec.maintenanceid);
                    DBMS_OUTPUT.PUT_LINE('    Date: ' || maintenance_rec.maintenanceDate);
                    DBMS_OUTPUT.PUT_LINE('    Type: ' || maintenance_rec.type);
                    DBMS_OUTPUT.PUT_LINE('    Description: ' || maintenance_rec.maintenanceDescription);
                END LOOP;

            DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
        END LOOP;

    -- Check if no ships or planes found
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No fleet found for owner with ID: ' || p_ownerid);
    END IF;
END;

-- Complex Procedure Generate_Owner_Ship_Fleet_Report
/* Jan Haslik */
CREATE OR REPLACE PROCEDURE Generate_Owner_Ship_Fleet_Report(p_ownerid IN NUMBER) IS
BEGIN
    -- Output owner details
    FOR owner_rec IN (
        SELECT name, contactperson, contactemail
        FROM owners
        WHERE ownerid = p_ownerid
        )
        LOOP
            DBMS_OUTPUT.PUT_LINE('Owner: ' || owner_rec.name);
            DBMS_OUTPUT.PUT_LINE('Contact Person: ' || owner_rec.contactperson);
            DBMS_OUTPUT.PUT_LINE('Contact Email: ' || owner_rec.contactemail);
            DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
        END LOOP;

    -- Output ships details
    FOR ship_rec IN (
        SELECT shipnr, name, type, image, currentvalue, year
        FROM ships
        WHERE owner = p_ownerid
        )
        LOOP
            DBMS_OUTPUT.PUT_LINE('Ship Number: ' || ship_rec.shipnr);
            DBMS_OUTPUT.PUT_LINE('Name: ' || ship_rec.name);
            DBMS_OUTPUT.PUT_LINE('Type: ' || ship_rec.type);
            DBMS_OUTPUT.PUT_LINE('Image: ' || ship_rec.image);
            DBMS_OUTPUT.PUT_LINE('Current Value: ' || ship_rec.currentvalue);
            DBMS_OUTPUT.PUT_LINE('Year: ' || TO_CHAR(ship_rec.year, 'YYYY'));
            DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');

            -- Output associated crewmembers
            DBMS_OUTPUT.PUT_LINE('Crewmembers:');
            FOR crew_rec IN (
                SELECT c.name, c.role
                FROM crewmembers c
                         JOIN ships_crewmembers sc ON c.crewmemberid = sc.crewmember
                WHERE sc.ship = ship_rec.shipnr
                )
                LOOP
                    DBMS_OUTPUT.PUT_LINE('    Name: ' || crew_rec.name || ', Role: ' || crew_rec.role);
                END LOOP;

            DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');

            -- Output associated shipments
            DBMS_OUTPUT.PUT_LINE('Shipments:');
            FOR shipment_rec IN (
                SELECT s.shipmentid, s.starttime, s.endtime, s.departurelocation, s.arrivallocation
                FROM shipments s
                         JOIN ships_shipments ss ON s.shipmentid = ss.shipment
                WHERE ss.ship = ship_rec.shipnr
                )
                LOOP
                    DBMS_OUTPUT.PUT_LINE('    Shipment ID: ' || shipment_rec.shipmentid);
                    DBMS_OUTPUT.PUT_LINE('    Departure: ' || shipment_rec.departurelocation || ', Arrival: ' ||
                                         shipment_rec.arrivallocation);
                    DBMS_OUTPUT.PUT_LINE('    Start Time: ' || shipment_rec.starttime || ', End Time: ' ||
                                         shipment_rec.endtime);
                END LOOP;

            DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');

            -- Output associated maintenances
            DBMS_OUTPUT.PUT_LINE('Maintenances:');
            FOR maintenance_rec IN (
                SELECT m.maintenanceid, m.maintenanceDate, m.type, m.maintenanceDescription
                FROM maintenances m
                         JOIN ships_maintenances sm ON m.maintenanceid = sm.maintenance
                WHERE sm.ship = ship_rec.shipnr
                )
                LOOP
                    DBMS_OUTPUT.PUT_LINE('    Maintenance ID: ' || maintenance_rec.maintenanceid);
                    DBMS_OUTPUT.PUT_LINE('    Date: ' || maintenance_rec.maintenanceDate);
                    DBMS_OUTPUT.PUT_LINE('    Type: ' || maintenance_rec.type);
                    DBMS_OUTPUT.PUT_LINE('    Description: ' || maintenance_rec.maintenanceDescription);
                END LOOP;

            DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
        END LOOP;

    -- Check if no ships or planes found
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No fleet found for owner with ID: ' || p_ownerid);
    END IF;
END;

-- Complex Procedure Identify_Unassigned_Crew_Members
/* Jan Haslik*/
CREATE OR REPLACE PROCEDURE Identify_Unassigned_Crew_Members IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Unassigned Crew Members');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');

    FOR crew_rec IN (
        SELECT c.crewmemberid, c.name, c.role
        FROM crewmembers c
                 LEFT JOIN ships_crewmembers sc ON c.crewmemberid = sc.crewmember
                 LEFT JOIN planes_crewmembers pc ON c.crewmemberid = pc.crewmember
        WHERE sc.crewmember IS NULL
          AND pc.crewmember IS NULL
        )
        LOOP
            DBMS_OUTPUT.PUT_LINE('Crewmember ID: ' || crew_rec.crewmemberid);
            DBMS_OUTPUT.PUT_LINE('Name: ' || crew_rec.name);
            DBMS_OUTPUT.PUT_LINE('Role: ' || crew_rec.role);
            DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
        END LOOP;
END;

-- Complex Procedure Generate_Utilization_Report
/* Jan Haslik */
CREATE OR REPLACE PROCEDURE Generate_Utilization_Report IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Utilization Report');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');

    -- Output utilization details for ships
    DBMS_OUTPUT.PUT_LINE('Ships:');
    FOR ship_utilization_rec IN (
        SELECT s.name                                                                AS ship_name,
               (SELECT COUNT(*) FROM ships_shipments ss WHERE ss.ship = s.shipnr)    AS shipment_count,
               (SELECT COUNT(*) FROM ships_maintenances sm WHERE sm.ship = s.shipnr) AS maintenance_count
        FROM ships s
        )
        LOOP
            DBMS_OUTPUT.PUT_LINE('Ship Name: ' || ship_utilization_rec.ship_name);
            DBMS_OUTPUT.PUT_LINE('Number of Shipments: ' || ship_utilization_rec.shipment_count);
            DBMS_OUTPUT.PUT_LINE('Number of Maintenances: ' || ship_utilization_rec.maintenance_count);
            DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
        END LOOP;

    -- Output utilization details for planes
    DBMS_OUTPUT.PUT_LINE('Planes:');
    FOR plane_utilization_rec IN (
        SELECT p.planenr                                                                  AS plane_number,
               (SELECT COUNT(*) FROM planes_shipments ps WHERE ps.planenr = p.planenr)    AS shipment_count,
               (SELECT COUNT(*) FROM planes_maintenances pm WHERE pm.planenr = p.planenr) AS maintenance_count
        FROM planes p
        )
        LOOP
            DBMS_OUTPUT.PUT_LINE('Plane Number: ' || plane_utilization_rec.plane_number);
            DBMS_OUTPUT.PUT_LINE('Number of Shipments: ' || plane_utilization_rec.shipment_count);
            DBMS_OUTPUT.PUT_LINE('Number of Maintenances: ' || plane_utilization_rec.maintenance_count);
            DBMS_OUTPUT.PUT_LINE('-------------------------------------------------');
        END LOOP;
END;

-- Report: Ship Fleet Value
-- Description: This procedure calculates and prints the total value of ships owned by a specified owner,
-- along with the individual value of each ship.
-- Input: owner_id_in - The ID of the owner whose fleet value is to be calculated.
-- Output: Prints the total value of the ship fleet owned by the specified owner,
-- as well as the value of each ship.
/* Daniel Kunesch */
CREATE OR REPLACE PROCEDURE Generate_Ship_Fleet_Value_Report(owner_id_in IN NUMBER) IS
    total_value   NUMBER := 0;
    owner_name    VARCHAR2(100);
BEGIN
    -- Fetch owner details
    SELECT name
    INTO owner_name
    FROM owners
    WHERE ownerid = owner_id_in;

    -- Print owner details
    DBMS_OUTPUT.PUT_LINE('Owner Details:');
    DBMS_OUTPUT.PUT_LINE('Owner Name: ' || owner_name);

    -- Print header for ship values
    DBMS_OUTPUT.PUT_LINE('Ship Values:');
    DBMS_OUTPUT.PUT_LINE('--------------------------');
    DBMS_OUTPUT.PUT_LINE('Ship ID | Ship Value');
    DBMS_OUTPUT.PUT_LINE('--------------------------');

    -- Declare cursor for ships owned by the specified owner
    DECLARE
        CURSOR ship_cursor IS
            SELECT shipnr, currentvalue
            FROM ships
            WHERE owner = owner_id_in;

    BEGIN
        FOR ship IN ship_cursor
            LOOP

                EXIT WHEN ship_cursor%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(ship.shipnr || ' | ' || ship.currentvalue);
                total_value := total_value + ship.currentvalue; -- Calculate total value
            END LOOP;

    END;

    -- Print the total fleet value
    DBMS_OUTPUT.PUT_LINE('--------------------------');
    DBMS_OUTPUT.PUT_LINE('Total value of ship fleet owned by owner ' || owner_id_in || ': ' || total_value);
END;

-- Report: Plane Fleet Value
-- Description: This procedure calculates and prints the total value of planes owned by a specified owner,
-- along with the individual value of each plane.
-- Input: owner_id_in - The ID of the owner whose fleet value is to be calculated.
-- Output: Prints the total value of the plane fleet owned by the specified owner,
-- as well as the value of each plane.
/* Jan Haslik */
CREATE OR REPLACE PROCEDURE Generate_Ships_Value_Report(owner_id_in IN NUMBER) IS
    total_value   NUMBER := 0;
    owner_name    VARCHAR2(100);
BEGIN
    -- Fetch owner details
    SELECT name
    INTO owner_name
    FROM owners
    WHERE ownerid = owner_id_in;

    -- Print owner details
    DBMS_OUTPUT.PUT_LINE('Owner Details:');
    DBMS_OUTPUT.PUT_LINE('Owner Name: ' || owner_name);

    -- Print header for plane values
    DBMS_OUTPUT.PUT_LINE('Plane Values:');
    DBMS_OUTPUT.PUT_LINE('--------------------------');
    DBMS_OUTPUT.PUT_LINE('Plane ID | Plane Value');
    DBMS_OUTPUT.PUT_LINE('--------------------------');

    -- Declare cursor for planes owned by the specified owner
    DECLARE
        CURSOR plane_cursor IS
            SELECT planenr, currentvalue
            FROM planes
            WHERE owner = owner_id_in;

    BEGIN

        FOR plane IN plane_cursor
            LOOP
                EXIT WHEN plane_cursor%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(plane.planenr || ' | ' || plane.currentvalue);
                total_value := total_value + plane.currentvalue; -- Calculate total value
            END LOOP;

    END;

    -- Print the total fleet value
    DBMS_OUTPUT.PUT_LINE('--------------------------');
    DBMS_OUTPUT.PUT_LINE('Total value of plane fleet owned by owner ' || owner_id_in || ': ' || total_value);
END;



