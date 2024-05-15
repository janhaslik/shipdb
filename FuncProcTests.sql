
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
VALUES (v_shipnr_param, v_name_param, v_owner_param, v_type_param, v_image_param, v_currentvalue_param, v_year_param);

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
CREATE OR REPLACE FUNCTION add_ships_crewmember(
    v_id_param IN NUMBER,
    v_ship_param IN NUMBER,
    v_crewmember_param IN NUMBER
) RETURN VARCHAR2 IS
    ship_count NUMBER;
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
        RETURN 'Ships_Crewmember with the same id already exists';
    WHEN OTHERS THEN
        RETURN 'Error adding Ships_Crewmember';
END add_ships_crewmember;



