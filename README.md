# ProjectEuropeEnergy

## Description
This is a data analysis training project, in which the data from the World Energy Consumption dataset is used to present the usage of different energy sources across
Europe.
The project employs the MySQL RDBMS (Relational Database Management System) for storing and querying the imported data, 
the Python programming language for processing the raw data and generating SQL scripts,
and Tableau Public software for data visualization.

## Technologies
The project is created with:
* Python version 3.8.13
* MySQL Workbench 8.0.27
* Tableau Public 2022.1.1



## How to use the project
### How to create a MySQL database
First, after establishing a connection with a MySQL server, load and run the script generate_db_skeleton.sql. This will create a new
schema named world_energy_v2, and also generate three tables: countries, countries_euro and data. The generated tables will be empty,
containing only the column names, column data types and establish primary keys of each table.

#### Loading processed data into database tables
After the database and its tables were generated, the processed data from the folder processed_data	can be loaded in two ways:
##### Option A - Using LOAD DATA LOCAL INFILE
For this option to work, the option OPT_LOCAL_INFILE must be set to 1 in the connection parameters. In MySQL, this can be done under

Manage Server Connections -> <name of the connection> -> Advanced -> Others:

by adding field OPT_LOCAL_INFILE=1 to the Others tab. Be sure to quit from mysql server before changing connection settings.
The state of the variable OPT_LOCAL_INFILE can be checked with the command
'show global variables like 'local_infile';'

After that, load the script populate_empty_tables.sql and replace set the correct filepath to the .csv data file for each table.
In the file path use either single forward slash '/' or double backslash '\\'.
