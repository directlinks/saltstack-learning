# Install Apache
install apache2

# Add user
User for ubuntu is www-data

# Add files to base
copy all the files to the base directory

# run salt

salt '*' state.sls install_apache
