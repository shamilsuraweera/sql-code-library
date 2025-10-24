# 1. Update the local package index to ensure you get the latest version info
sudo apt update

# 2. Install the MySQL Server package. The '-y' confirms the installation automatically.
sudo apt install mysql-server -y

# 3. Check the status of the MySQL service (it should be running automatically)
sudo systemctl status mysql

# 4. Run the security script to remove insecure default settings and set a root password
# Follow the on-screen prompts:
#   - Choose a strong password validation policy (level 2 is recommended)
#   - Set a strong password for the root user
#   - Answer 'Y' to all subsequent questions (remove anonymous users, disallow root login remotely, remove test database, reload privilege tables)
sudo mysql_secure_installation

# 5. Connect to the MySQL shell as the root user to create a dedicated user for VS Code
# You will be prompted for the root password you set in the previous step
sudo mysql -u root -p
