-- Verify that the EXAMPLES table exists and display its contents
DECLARE
    table_exists NUMBER := 0;
BEGIN
    -- Check if the EXAMPLES table exists in the APPUSER schema
    SELECT COUNT(*)
    INTO table_exists
    FROM ALL_TABLES
    WHERE TABLE_NAME = 'EXAMPLES' AND OWNER = 'APPUSER';

    IF table_exists = 0 THEN
        DBMS_OUTPUT.PUT_LINE('EXAMPLES table does not exist.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('EXAMPLES table exists. Contents:');
        FOR rec IN (SELECT ID, NAME, CREATED_BY FROM APPUSER.EXAMPLES) LOOP
            DBMS_OUTPUT.PUT_LINE(
                'ID: ' || rec.ID || ', NAME: ' || rec.NAME || ', CREATED_BY: ' || rec.CREATED_BY
            );
        END LOOP;
    END IF;
END;
/
