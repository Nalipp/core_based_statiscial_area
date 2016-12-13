CREATE TABLE geo_area (
  id serial PRIMARY KEY,
  geo_area text,
  state text,
  pop_2010 VARCHAR
);

\copy geo_area (geo_area, state, pop_2010) FROM 'cbsa_geo_area.csv' with NULL AS ' ' csv ;

CREATE TABLE age (
  id serial PRIMARY KEY,
  geo_area_id int NOT NULL,
  less_than_18 VARCHAR,
  between_18_24 VARCHAR,
  between_25_34 VARCHAR,
  between_35_44 VARCHAR,
  between_45_54 VARCHAR,
  between_55_64 VARCHAR,
  between_65_74 VARCHAR,
  more_than_75 VARCHAR,
  FOREIGN KEY (geo_area_id) REFERENCES geo_area(id)
);

\copy age (geo_area_id, less_than_18, between_18_24, between_25_34, between_35_44, between_45_54, between_55_64, between_65_74, more_than_75) FROM 'cbsa_age.csv' with NULL AS ' ' csv ;

CREATE TABLE density (
  id serial PRIMARY KEY,
  geo_area_id int NOT NULL,
  sq_miles VARCHAR,
  density_2010 VARCHAR,
  weighted_density_2010 VARCHAR,
  density_change VARCHAR,
  FOREIGN KEY (geo_area_id) REFERENCES geo_area(id)
);

\copy density (geo_area_id, sq_miles, density_2010, weighted_density_2010, density_change) FROM 'cbsa_density.csv' with NULL AS ' ' csv ;

CREATE TABLE pop_change (
id serial PRIMARY KEY,
geo_area_id int NOT NULL,
pop_change VARCHAR,
pop_percent_change VARCHAR,
FOREIGN KEY (geo_area_id) REFERENCES geo_area(id)
);

\copy pop_change (geo_area_id, pop_change, pop_percent_change) FROM 'cbsa_pop_change.csv' with NULL AS ' ' csv ;

CREATE TABLE race (
id serial PRIMARY KEY,
geo_area_id int NOT NULL,
white VARCHAR,
black VARCHAR,
asian VARCHAR,
hispanic VARCHAR,
other_native_american_muti_race VARCHAR,
FOREIGN KEY (geo_area_id) REFERENCES geo_area(id)
);

\copy race (geo_area_id, white, black, asian, hispanic, other_native_american_muti_race) FROM 'cbsa_race.csv' with NULL AS ' ' csv ;
