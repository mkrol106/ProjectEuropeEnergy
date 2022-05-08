DROP DATABASE IF EXISTS world_energy_v2;
CREATE DATABASE world_energy_v2;
USE world_energy_v2;

DROP TABLE IF EXISTS countries;
CREATE TABLE countries(
	country VARCHAR(100), iso_code VARCHAR(10),
	PRIMARY KEY(country)
);


DROP TABLE IF EXISTS countries_euro;
CREATE TABLE countries_euro(
	country VARCHAR(100), subregion VARCHAR(50),
	PRIMARY KEY(country)
);


DROP TABLE IF EXISTS data;
CREATE TABLE data(
	country VARCHAR(100), year SMALLINT, population BIGINT,
	gdp BIGINT, biofuel_cons_change_pct FLOAT, biofuel_cons_change_twh FLOAT,
	biofuel_cons_per_capita FLOAT, biofuel_consumption FLOAT, biofuel_elec_per_capita FLOAT,
	biofuel_electricity FLOAT, biofuel_share_elec FLOAT, biofuel_share_energy FLOAT,
	carbon_intensity_elec FLOAT, coal_cons_change_pct FLOAT, coal_cons_change_twh FLOAT,
	coal_cons_per_capita FLOAT, coal_consumption FLOAT, coal_elec_per_capita FLOAT,
	coal_electricity FLOAT, coal_prod_change_pct FLOAT, coal_prod_change_twh FLOAT,
	coal_prod_per_capita FLOAT, coal_production FLOAT, coal_share_elec FLOAT,
	coal_share_energy FLOAT, electricity_generation FLOAT, energy_cons_change_pct FLOAT,
	energy_cons_change_twh FLOAT, energy_per_capita FLOAT, energy_per_gdp FLOAT,
	fossil_cons_change_pct FLOAT, fossil_cons_change_twh FLOAT, fossil_cons_per_capita FLOAT,
	fossil_electricity FLOAT, fossil_energy_per_capita FLOAT, fossil_fuel_consumption FLOAT,
	fossil_share_elec FLOAT, fossil_share_energy FLOAT, gas_cons_change_pct FLOAT,
	gas_cons_change_twh FLOAT, gas_consumption FLOAT, gas_elec_per_capita FLOAT,
	gas_electricity FLOAT, gas_energy_per_capita FLOAT, gas_prod_change_pct FLOAT,
	gas_prod_change_twh FLOAT, gas_prod_per_capita FLOAT, gas_production FLOAT,
	gas_share_elec FLOAT, gas_share_energy FLOAT, hydro_cons_change_pct FLOAT,
	hydro_cons_change_twh FLOAT, hydro_consumption FLOAT, hydro_elec_per_capita FLOAT,
	hydro_electricity FLOAT, hydro_energy_per_capita FLOAT, hydro_share_elec FLOAT,
	hydro_share_energy FLOAT, low_carbon_cons_change_pct FLOAT, low_carbon_cons_change_twh FLOAT,
	low_carbon_consumption FLOAT, low_carbon_elec_per_capita FLOAT, low_carbon_electricity FLOAT,
	low_carbon_energy_per_capita FLOAT, low_carbon_share_elec FLOAT, low_carbon_share_energy FLOAT,
	nuclear_cons_change_pct FLOAT, nuclear_cons_change_twh FLOAT, nuclear_consumption FLOAT,
	nuclear_elec_per_capita FLOAT, nuclear_electricity FLOAT, nuclear_energy_per_capita FLOAT,
	nuclear_share_elec FLOAT, nuclear_share_energy FLOAT, oil_cons_change_pct FLOAT,
	oil_cons_change_twh FLOAT, oil_consumption FLOAT, oil_elec_per_capita FLOAT,
	oil_electricity FLOAT, oil_energy_per_capita FLOAT, oil_prod_change_pct FLOAT,
	oil_prod_change_twh FLOAT, oil_prod_per_capita FLOAT, oil_production FLOAT,
	oil_share_elec FLOAT, oil_share_energy FLOAT, other_renewable_consumption FLOAT,
	other_renewable_electricity FLOAT, other_renewable_exc_biofuel_electricity FLOAT, other_renewables_cons_change_pct FLOAT,
	other_renewables_cons_change_twh FLOAT, other_renewables_elec_per_capita FLOAT, other_renewables_energy_per_capita FLOAT,
	other_renewables_share_elec FLOAT, other_renewables_share_energy FLOAT, per_capita_electricity FLOAT,
	primary_energy_consumption FLOAT, renewables_cons_change_pct FLOAT, renewables_cons_change_twh FLOAT,
	renewables_consumption FLOAT, renewables_elec_per_capita FLOAT, renewables_electricity FLOAT,
	renewables_energy_per_capita FLOAT, renewables_share_elec FLOAT, renewables_share_energy FLOAT,
	solar_cons_change_pct FLOAT, solar_cons_change_twh FLOAT, solar_consumption FLOAT,
	solar_elec_per_capita FLOAT, solar_electricity FLOAT, solar_energy_per_capita FLOAT,
	solar_share_elec FLOAT, solar_share_energy FLOAT, wind_cons_change_pct FLOAT,
	wind_cons_change_twh FLOAT, wind_consumption FLOAT, wind_elec_per_capita FLOAT,
	wind_electricity FLOAT, wind_energy_per_capita FLOAT, wind_share_elec FLOAT,
	wind_share_energy FLOAT,
	PRIMARY KEY(country, year)
);


