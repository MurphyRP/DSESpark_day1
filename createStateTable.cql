//
// Simple table to store state abbreviations and codes
//

CREATE TABLE IF NOT EXISTS bootcamp.states (
	state_alpha varchar primary key,
	state_name varchar
)
WITH
  compaction = { 'class' :  'LeveledCompactionStrategy'};
