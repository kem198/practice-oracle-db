-- @/opt/oracle/scripts/setup/01_create_appuser.sql
-- Create APPUSER user
CREATE USER APPUSER IDENTIFIED BY appuser_password
;

-- Grant necessary privileges to APPUSER
GRANT CONNECT,
RESOURCE TO APPUSER
;

-- Assign quota on USERS tablespace
ALTER USER APPUSER QUOTA UNLIMITED ON USERS
;

-- Set default tablespace
ALTER USER APPUSER DEFAULT TABLESPACE USERS
;
