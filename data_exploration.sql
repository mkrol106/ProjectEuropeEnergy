USE world_energy_v2;

-- to make sure it all works, show countries, iso codes of countries and population for year 2015
-- ignore entries without an iso_code to ignore aggregate regions
-- then sort by population
SELECT countries.country, countries.iso_code, data.population
FROM countries
LEFT JOIN data ON countries.country = data.country
WHERE
		data.year = 2015 AND countries.iso_code IS NOT NULL
        AND countries.iso_code NOT LIKE "%WRL"
ORDER BY data.population DESC;

-- now, for european countries only, show country, subregion, population, GDP and calculate GDP per capita
SELECT countries_euro.country, countries_euro.subregion, data.population, data.gdp,
		data.gdp / data.population AS gdp_per_capita
FROM countries_euro
LEFT JOIN data ON countries_euro.country = data.country
WHERE year = 2015
ORDER BY gdp_per_capita DESC;

-- using the previous query as a subquery, aggregate the data for european subregions
SELECT subquery.subregion, SUM(subquery.population) AS total_population,
		SUM(subquery.gdp) AS total_gdp, ROUND(AVG(subquery.gdp_per_capita)) AS average_gdp_per_capita
FROM
		(SELECT countries_euro.country, countries_euro.subregion, data.population, data.gdp,
		data.gdp / data.population AS gdp_per_capita
		FROM countries_euro
		LEFT JOIN data ON countries_euro.country = data.country
		WHERE year = 2015
		ORDER BY gdp_per_capita DESC) AS subquery
GROUP BY subquery.subregion
ORDER BY average_gdp_per_capita DESC;

-- show top 10 european countries with the highest share of nuclear electricity in 2020
SELECT countries_euro.country, data.nuclear_share_elec AS nuclear_elec_share_pct
FROM countries_euro
LEFT JOIN data ON countries_euro.country = data.country
WHERE data.year = 2020
ORDER BY nuclear_elec_share_pct DESC LIMIT 10;

-- using a CTE, show energy breakdown for each european region in 2020
WITH electricity_breakdown (country, subregion, fossil_electricity, renewables_electricity, nuclear_electricity, total_electricity) AS
		-- for every european country, show production of electricity in TWh from fossil fuels, renewables and nuclear for 2020
		(SELECT countries_euro.country, countries_euro.subregion,
				data.fossil_electricity, data.renewables_electricity, data.nuclear_electricity,
				data.electricity_generation AS total_electricity
		FROM countries_euro
		LEFT JOIN data ON countries_euro.country = data.country
		WHERE data.year = 2020)
SELECT subregion,
		ROUND(100 * SUM(fossil_electricity) / SUM(total_electricity), 2) AS fossil_share_pct,
        ROUND(100 * SUM(renewables_electricity) / SUM(total_electricity), 2) AS renewables_share_pct,
        ROUND(100 * SUM(nuclear_electricity) / SUM(total_electricity), 2) AS nuclear_share_pct,
        ROUND(SUM(total_electricity), 1) AS total_region_electricity_TWh
FROM electricity_breakdown
GROUP BY subregion;

-- create a view showing all combined data for european countries for all fossil fuels
DROP VIEW IF EXISTS data_euro_all_fossil;
CREATE VIEW data_euro_all_fossil AS
		SELECT countries.country, countries.iso_code, countries_euro.subregion,
				data.population, data.gdp, data.gdp / data.population AS gdp_per_capita, data.year,
				data.fossil_cons_change_pct, data.fossil_share_energy, data.fossil_cons_change_twh,
                data.fossil_fuel_consumption, data.fossil_energy_per_capita, data.fossil_cons_per_capita,
                data.fossil_share_elec
        FROM countries_euro
        LEFT JOIN countries ON countries_euro.country = countries.country
        LEFT JOIN data ON countries_euro.country = data.country
        WHERE year > 2000
;
SELECT * FROM data_euro_all_fossil;

-- create a view showing all combined data for european countries for all renewables
DROP VIEW IF EXISTS data_euro_all_renewables;
CREATE VIEW data_euro_all_renewables AS
		SELECT countries.country, countries.iso_code, countries_euro.subregion, 
				data.population, data.gdp, data.gdp / data.population AS gdp_per_capita, data.year,
				data.renewables_elec_per_capita, data.renewables_share_elec, data.renewables_cons_change_pct,
                data.renewables_share_energy, data.renewables_cons_change_twh, data.renewables_consumption,
                data.renewables_energy_per_capita
        FROM countries_euro
        LEFT JOIN countries ON countries_euro.country = countries.country
        LEFT JOIN data ON countries_euro.country = data.country
        WHERE year > 2000
;
SELECT * FROM data_euro_all_renewables;

-- create a view showing all combined data for european countries for nuclear power
DROP VIEW IF EXISTS data_euro_nuclear;
CREATE VIEW data_euro_nuclear AS
		SELECT countries.country, countries.iso_code, countries_euro.subregion, 
				data.population, data.gdp, data.gdp / data.population AS gdp_per_capita, data.year,
				data.nuclear_electricity, data.nuclear_share_elec, data.nuclear_cons_change_pct,
				data.nuclear_share_energy, data.nuclear_cons_change_twh, data.nuclear_consumption,
				data.nuclear_elec_per_capita, data.nuclear_energy_per_capita
        FROM countries_euro
        LEFT JOIN countries ON countries_euro.country = countries.country
        LEFT JOIN data ON countries_euro.country = data.country
        WHERE year > 2000
;
SELECT * FROM data_euro_nuclear;





