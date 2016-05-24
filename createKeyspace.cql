//
//  Create keyspace should be edited to reflect an appropriate replication strategy and replication factor
//

CREATE KEYSPACE IF NOT EXISTS bootcamp   WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };


// us_locations table is a ~300mb dataset downloaded from the US Geospatial Intelligence Agency - it is a list
// of US placenames, types, elevations and locations.

CREATE TABLE IF NOT EXISTS bootcamp.us_locations (
	feature_id int primary key,
	feature_name varchar,
	feature_class varchar,
	state_alpha varchar,
	state_numeric varchar,
	county_name varchar,
	county_numeric varchar,
	primary_lat_dms varchar,
	primary_long_dms varchar,
	primary_lat_dec varchar,
	primary_long_dec varchar,
	source_lat_dms varchar,
	source_long_dms varchar,
	source_lat_dec varchar,
	source_long_dec varchar,
	elevation_in_miles float,
	elevation_in_ft int,
	map_name varchar,
	date_created timestamp,
	date_edited timestamp)	
WITH
  compaction = { 'class' :  'LeveledCompactionStrategy'};
