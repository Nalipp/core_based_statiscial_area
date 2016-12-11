CREATE TABLE geo_area (
  id serial PRIMARY KEY,
  geo_area text NOT NULL,
  state text NOT NULL
);

\copy geo_area (geo_area, state) FROM 'cbsa_geo_area.csv' with NULL AS ' ' csv ;

CREATE TABLE age (
  id serial PRIMARY KEY,
  geo_area_id int NOT NULL,
  less_than_18 text NOT NULL,
  between_18_24 text NOT NULL,
  between_25_34 text NOT NULL,
  between_35_44 text NOT NULL,
  between_45_54 text NOT NULL,
  between_55_64 text NOT NULL,
  between_65_74 text NOT NULL,
  more_than_75 text NOT NULL,
  FOREIGN KEY (geo_area_id) REFERENCES geo_area(id)
);

\copy age (geo_area_id, less_than_18, between_18_24, between_25_34, between_35_44, between_45_54, between_55_64, between_65_74, more_than_75) FROM 'cbsa_age.csv' with NULL AS ' ' csv ;

CREATE TABLE density (
  id serial PRIMARY KEY,
  geo_area_id int NOT NULL,
  pop_2010 text NOT NULL,
  sq_miles text NOT NULL,
  density_2010 text NOT NULL,
  weighted_density_2010 text NOT NULL,
  density_change text NOT NULL,
  FOREIGN KEY (geo_area_id) REFERENCES geo_area(id)
);

\copy density (geo_area_id, pop_2010, sq_miles, density_2010, weighted_density_2010, density_change) FROM 'cbsa_density.csv' with NULL AS ' ' csv ;

CREATE TABLE pop_change (
id serial PRIMARY KEY,
geo_area_id int NOT NULL,
pop_total text NOT NULL,
pop_change text NOT NULL,
pop_percent_change text NOT NULL,
FOREIGN KEY (geo_area_id) REFERENCES geo_area(id)
);

\copy pop_change (geo_area_id, pop_total, pop_change, pop_percent_change) FROM 'cbsa_pop_change.csv' with NULL AS ' ' csv ;

CREATE TABLE race (
id serial PRIMARY KEY,
geo_area_id int NOT NULL,
white text NOT NULL,
black text NOT NULL,
asian text NOT NULL,
hispanic text NOT NULL,
other_native_american_muti_race text NOT NULL,
FOREIGN KEY (geo_area_id) REFERENCES geo_area(id)
);

\copy race (geo_area_id, white, black, asian, hispanic, other_native_american_muti_race) FROM 'cbsa_race.csv' with NULL AS ' ' csv ;
