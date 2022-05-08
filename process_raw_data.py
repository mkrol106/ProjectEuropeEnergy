import csv
import os


def get_table_script(table_name, table_cols, cols_dtypes_dict, primary_keys_list):
    '''
    function for generating SQL script for creating a table
    :return: string containing SQL code
    '''
    entries_in_row = 3

    # write the header
    script = "DROP TABLE IF EXISTS " + table_name + ";\n"
    script += "CREATE TABLE " + table_name + "(\n"

    # write each column name along with it's data type
    for i, col_name in enumerate(table_cols):
        col_dtype = cols_dtypes_dict[col_name]

        if i % entries_in_row == 0:  # for the first entry in row
            script += '\t' + col_name + ' ' + col_dtype
        else:
            script += ', ' + col_name + ' ' + col_dtype

        if (i + 1) == len(table_cols) or (i + 1) % entries_in_row == 0:
            script += ',\n'

    # write the primary keys for the table
    script += '\tPRIMARY KEY('
    for p, primary_key in enumerate(primary_keys_list):
        if p + 1 < len(primary_keys_list):
            script += primary_key + ', '
        else:
            script += primary_key

    script += ')\n);\n\n\n'
    return script


# columns of table countries: country, iso_code
# columns of table countries_euro: country, subregion
# columns of table data: country, year, population, gdp, other_data

db_name = 'world_energy_v2'

file_path_world_energy = os.path.join(os.getcwd(), "raw_data", "World_Energy_Consumption.csv")
file_path_european_countries = os.path.join(os.getcwd(), "raw_data", "European_countries.csv")
file_path_table_countries = os.path.join(os.getcwd(), "processed_data", "data_for_table_countries.csv")
file_path_table_countries_euro = os.path.join(os.getcwd(), "processed_data", "data_for_table_countries_euro.csv")
file_path_table_data = os.path.join(os.getcwd(), "processed_data", "data_for_table_data.csv")

with open(file_path_world_energy, 'r') as file_raw_data:
    # extract a file's header containing column names
    header = file_raw_data.readline().replace('\n', "")
    header = header.split(',')

    # create a dictionary of each column's data type as floats, and overwrite the exceptions
    cols_sql_dtypes = dict([(col_name, 'FLOAT') for col_name in header])
    cols_sql_dtypes['country'] = 'VARCHAR(100)'
    cols_sql_dtypes['iso_code'] = 'VARCHAR(10)'
    cols_sql_dtypes['year'] = 'SMALLINT'            # cannot be of type YEAR, because the years go before 1901
    cols_sql_dtypes['population'] = 'BIGINT'        # population for the WORLD is above regular INT limit
    cols_sql_dtypes['gdp'] = 'BIGINT'

    # for each table, create a list of columns in that table
    table_countries_cols = ['country', 'iso_code']
    table_data_cols = header.copy()
    table_data_cols.remove('iso_code')

    # switch columns in table_data_first_cols to the front, sort the rest of the columns alphabetically
    table_data_first_cols = ['country', 'year', 'population', 'gdp']
    [table_data_cols.remove(col) for col in table_data_first_cols]  # remove columns based on the list above
    table_data_cols.sort()                                          # sort the columns that were not removed
    table_data_cols = table_data_first_cols + table_data_cols       # connect the two lists

    # for each table, create a list of the column indexes corresponding to raw data file columns
    table_countries_indexes = [header.index(col) for col in table_countries_cols]
    table_data_indexes = [header.index(col) for col in table_data_cols]

    # split the raw data file into csv files for each table
    with open(file_path_table_countries, 'w', newline='') as f_countries,\
            open(file_path_table_data, 'w', newline='') as f_data:
        # initialize csv writers for each file
        wr_countries = csv.writer(f_countries)
        wr_data = csv.writer(f_data)

        # write a header for each csv file based on the header and table column indexes
        wr_countries.writerow([header[i] for i in table_countries_indexes])
        wr_data.writerow([header[i] for i in table_data_indexes])

        # create an empty list for storing unique country names
        countries_list = []

        for raw_line in file_raw_data:  # unpack the file line by line, without the header (it was previously unpacked)
            # transform one long row string into list of values
            line = raw_line.replace('\n', "").split(',')

            # for SQL compatibility, replace empty value fields and inf fields with NULL
            line = [item if item != "" else "NULL" for item in line]
            line = [item if item != "inf" else "NULL" for item in line]

            # if the country hasn't appeared before, add it to the dictionary
            country = line[1]
            if country not in countries_list:
                countries_list.append(country)
                wr_countries.writerow([line[i] for i in table_countries_indexes])

            # write a row for each csv file based on the current line and table column indexes
            wr_data.writerow([line[i] for i in table_data_indexes])

    # based on the file European_countries.csv, create a csv file containing country name and subregion
    # for each european country
    with open(file_path_european_countries, 'r') as f_input_euro,\
            open(file_path_table_countries_euro, 'w', newline='') as f_countries_euro:
        # initialize csv writer for the output file
        wr_countries_euro = csv.writer(f_countries_euro)
        f_input_euro.readline()  # skip the header

        # initialize column names and a subregion data type for the countries_euro table
        table_countries_euro_cols = ['country', 'subregion']
        cols_sql_dtypes['subregion'] = "VARCHAR(50)"

        # write the data into the file
        wr_countries_euro.writerow(table_countries_euro_cols)
        for raw_line in f_input_euro:
            country, subregion = raw_line.replace('\n', "").split(',')

            # check if the country name appears in the World_Energy_Consumption file, if not ignore it
            if country in countries_list:
                wr_countries_euro.writerow([country, subregion])
            else:
                print('country', country, 'ignored in the data_for_table_countries_euro file')
                print('\tcountry was not found in the raw data file\n')

    # generate a sql script for creating a database and it's empty tables
    with open("generate_db_skeleton.sql", 'w') as file_out:
        # write the script for creating the database
        script = "DROP DATABASE IF EXISTS " + db_name + ";\n"
        script += "CREATE DATABASE " + db_name + ";\n"
        script += "USE " + db_name + ";\n\n"
        file_out.write(script)

        # append the scripts for creating empty tables
        file_out.write(get_table_script('countries', table_countries_cols, cols_sql_dtypes, ['country']))
        file_out.write(get_table_script('countries_euro', table_countries_euro_cols, cols_sql_dtypes, ['country']))
        file_out.write(get_table_script('data', table_data_cols, cols_sql_dtypes, ['country', 'year']))
