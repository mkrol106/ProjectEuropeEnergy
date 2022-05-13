USE world_energy_v2;

set global local_infile = TRUE;
show global variables like 'local_infile';

-- populate the countries table
DELETE FROM countries;
LOAD DATA LOCAL INFILE "E:/projects/ProjectEuropeEnergy/processed_data/data_for_table_countries.csv"
INTO TABLE countries
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- populate the countries_euro table
DELETE FROM countries_euro;
LOAD DATA LOCAL INFILE "E:/projects/ProjectEuropeEnergy/processed_data/data_for_table_countries_euro.csv"
INTO TABLE countries_euro
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

-- populate the data table
DELETE FROM data;
LOAD DATA LOCAL INFILE "E:/projects/ProjectEuropeEnergy/processed_data/data_for_table_data.csv"
INTO TABLE data
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;