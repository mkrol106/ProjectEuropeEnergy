USE world_energy_v2;

-- extract data for primary energy consumption
WITH selected_data (
		country, subregion, year,
        energy_per_capita_kwh, energy_cons_twh_fossil, energy_cons_twh_renewables, energy_cons_twh_nuclear,
        energy_cons_twh_total        
)
AS(
		SELECT
				co_eu.country, co_eu.subregion, data.year,
                data.energy_per_capita, data.fossil_fuel_consumption, data.renewables_consumption, data.nuclear_consumption,
				data.fossil_fuel_consumption + data.renewables_consumption + data.nuclear_consumption AS total_consumption
        FROM countries_euro co_eu
		LEFT JOIN data ON co_eu.country = data.country
		WHERE year = 2019 AND data.primary_energy_consumption IS NOT NULL
)
SELECT country, subregion, year,
		energy_per_capita_kwh, energy_cons_twh_total,
		energy_cons_twh_fossil, energy_cons_twh_renewables, energy_cons_twh_nuclear,
        100 * energy_cons_twh_fossil / energy_cons_twh_total AS energy_share_pct_fossil,
        100 * energy_cons_twh_renewables / energy_cons_twh_total AS energy_share_pct_renewables,
        100 * energy_cons_twh_nuclear / energy_cons_twh_total AS energy_share_pct_nuclear
FROM selected_data;

-- extract data about electricity usage
WITH selected_data (
		country, subregion, year,
        electricity_per_capita_kwh, electricity_cons_twh_fossil, electricity_cons_twh_renewables, electricity_cons_twh_nuclear,
        electricity_cons_twh_total        
)
AS(
		SELECT
				co_eu.country, co_eu.subregion, data.year,
                data.per_capita_electricity,
                data.fossil_electricity, data.renewables_electricity, data.nuclear_electricity,
				data.fossil_electricity + data.renewables_electricity + data.nuclear_electricity AS total_consumption
        FROM countries_euro co_eu
		LEFT JOIN data ON co_eu.country = data.country
		WHERE year = 2019 AND data.electricity_generation IS NOT NULL AND data.fossil_electricity IS NOT NULL
)
SELECT country, subregion, year,
		electricity_per_capita_kwh, electricity_cons_twh_total,
		electricity_cons_twh_fossil, electricity_cons_twh_renewables, electricity_cons_twh_nuclear,
        100 * electricity_cons_twh_fossil / electricity_cons_twh_total AS electricity_share_pct_fossil,
        100 * electricity_cons_twh_renewables / electricity_cons_twh_total AS electricity_share_pct_renewables,
        100 * electricity_cons_twh_nuclear / electricity_cons_twh_total AS electricity_share_pct_nuclear
FROM selected_data;
