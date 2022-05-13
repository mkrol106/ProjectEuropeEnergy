# ProjectEuropeEnergy

## Description
This is a data analysis training project, in which the data from the World Energy Consumption dataset is used to present the usage of different energy sources across
Europe.
The project employs:
- MySQL RDBMS (Relational Database Management System) for storing and querying the imported data, 
- Python programming language for processing the raw data and generating SQL scripts,
- Tableau Public software for data visualization.

## Technologies
The project is created with:
* Python version 3.8.13
* MySQL Workbench 8.0.27
* Tableau Public 2022.1.1

## Data Sources
Data for this project comes from the World Energy Consumption dataset, hosted on kaggle under the url

https://www.kaggle.com/datasets/pralabhpoudel/world-energy-consumption,

which contains a single .csv file. This file offers yearly information for each country about its energy and electricity usage, production and consumption,
for each source of energy.

To exclude non-European countries from analysis, the table from the site below offers a list of European countries and the subregion they belong to.

https://www.worldometers.info/geography/how-many-countries-in-europe/

## Processing data
To make it possible for the data to be uploaded into a SQL database, the two imported data files were processed by a python script process_raw_data.py.
The role of the script was to:
- Format the raw data to make it possible for SQL import, by replacing empty and non-standard fields with a '\N' value,
- Extract unique names of countries and their iso codes into a file data_for_table_countries.csv,
- Extract unique names of European countries and their subregions, which appear in both data sources into a file data_for_table_countries_euro.csv, 
- Extract the rest of the data into a file data_for_table_data.csv,
- Create a SQL script generate_db_skeleton.sql, which automatically creates an empty database and populates it with empty tables containing
column names, column data types and primary keys.


After the processed data files were created, the populate_empty_tables.sql script was used to import them into the empty tables. From this point on,
the SQL database was fully operational.


## Data exploration
To make sure the data was loaded correctly and observe basic insights about it, a SQL script data_exploration.sql was created to go through the stored
data. Basic information, like top 10 European countries with highest share of nuclear electricity, was gathered and observed.
The exploration showed that the data after 2016 was partially incomplete, and prohibited the visualization of some important metrics like GDP or population count.


## Extracting key data for visualization
Since the used visualization tool does not allow connection with the SQL database, the file data_extraction.sql containing a final query was written to gather
the following information:
- subregion of the country,
- primary energy consumption per capita,
- primary energy consumption from all sources, only fossil fuels, all renewables and nuclear power,
- Percentage share of three main energy sources in primary energy consumption.
Those metrics were gathered for all European countries in a year 2019, and countries where some data was not available were excluded.
After the query was returned by MySQL, the data was exported to a final .csv file.


## Data visualization
After extraction, the data was visualized with Tableau in the form of three dashboards in a story, which can be accessed with the url

https://public.tableau.com/views/EuropeEnergy2019/Story1?:language=en-US&publish=yes&:display_count=n&:origin=viz_share_link.

The story dashboards present three areas of the project:
- primary energy consumption,
- electricity generation,
- breakdown of sources of energy and electricity.


## Final report
The report in the form of presentation can be accessed in the file Findings_report.pdf.










