# README

* How to run the test suite

1) Execute $ bundle exec rspec

* Deployment instructions

Please follow the below instructions to install the required software and setup the application.
1) Install Ruby, Nginx, Passenger, MySQL in the server and configure.
Reference: https://gorails.com/deploy/ubuntu/16.04.
2) Copy the application code to the server root folder or clone from your git repository
3) Run the following command by changing directory the application home folder.
    $ bundle install
	It installs all the gems required by the application as per the Gemfile.lock
4) Create app/config/database.yml from app/config/database.yml.sample to configure your database credentials under the corresponding application environment.
5) Create app/config/secrets.yml from app/config/secrets.yml.sample to configure your environment specific secret key.
6) Run the following command to run db migrations:
    $ rake db:migrate
7) Restart Nginx Server.

