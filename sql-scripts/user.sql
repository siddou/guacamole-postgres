-- Create user "myuser" with password "password"
INSERT INTO guacamole_user (username, password_hash, password_salt, password_date)
VALUES ('myuser',
    decode('5522f219fda1924b4f6d3212d1ae66d468580c5535449437d9e80eefaa883a01', 'hex'),  -- 'password'
    decode('b3fa7bbc39903666a190e63c092a90729d1cc94355625e91c63bb738f0454387', 'hex'),
    CURRENT_TIMESTAMP);


-- Grant this user create connections permission
INSERT INTO guacamole_system_permission
SELECT user_id, permission::guacamole_system_permission_type
FROM (
    VALUES
        ('myuser', 'CREATE_CONNECTION')
) permissions (username, permission)
JOIN guacamole_user ON permissions.username = guacamole_user.username;

-- Grant this user permission to read/update/administer self
INSERT INTO guacamole_user_permission
SELECT guacamole_user.user_id, affected.user_id, permission::guacamole_object_permission_type
FROM (
    VALUES
        ('myuser', 'myuser', 'READ'),
        ('myuser', 'myuser', 'UPDATE')
) permissions (username, affected_username, permission)
JOIN guacamole_user          ON permissions.username = guacamole_user.username
JOIN guacamole_user affected ON permissions.affected_username = affected.username;
