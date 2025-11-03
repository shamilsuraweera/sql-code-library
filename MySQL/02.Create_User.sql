# Create a new user (replace 'shamil_suraweera' and 'StrongPassword' with your own)
CREATE USER 'shamil_suraweera'@'localhost' IDENTIFIED BY 'StrongPassword';

# Grant the new user all privileges on all databases (modify as needed for production)
GRANT ALL PRIVILEGES ON *.* TO 'shamil_suraweera'@'localhost' WITH GRANT OPTION;

# Apply the privilege changes
FLUSH PRIVILEGES;

# Exit the MySQL shell
EXIT;