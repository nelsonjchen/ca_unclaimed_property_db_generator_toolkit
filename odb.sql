PRAGMA journal_mode = OFF;
PRAGMA synchronous = 0;
pragma page_size = 12288;
PRAGMA cache_size = 100000;
PRAGMA locking_mode = EXCLUSIVE;
PRAGMA temp_store = MEMORY;

CREATE VIRTUAL TABLE records USING fts5(
  "PROPERTY_ID",
  "PROPERTY_TYPE",
  "CASH_REPORTED" UNINDEXED,
  "SHARES_REPORTED" UNINDEXED,
  "NAME_OF_SECURITIES_REPORTED",
  "DATE_REPORTED" UNINDEXED,
  "NO_OF_OWNERS" UNINDEXED,
  "OWNER_NAME",
  "OWNER_STREET_1",
  "OWNER_STREET_2",
  "OWNER_STREET_3",
  "OWNER_CITY",
  "OWNER_STATE",
  "OWNER_ZIP",
  "OWNER_COUNTRY_CODE",
  "CURRENT_CASH_BALANCE",
  "NUMBER_OF_PENDING_CLAIMS" UNINDEXED,
  "NUMBER_OF_PAID_CLAIMS" UNINDEXED,
  "DATE_OF_LAST_CONTACT" UNINDEXED,
  "HOLDER_NAME",
  "HOLDER_STREET_1",
  "HOLDER_STREET_2",
  "HOLDER_STREET_3",
  "HOLDER_CITY",
  "HOLDER_STATE",
  "HOLDER_ZIP",
  "CUSIP",
  tokenize="porter ascii"
);
.mode csv
.import 00_All_Records/All_Records__File_1_of_1.csv records

-- https://github.com/segfall/static-wiki/blob/master/scripts/optimize_db.js
INSERT INTO records(records, rank) VALUES ('rank', 'bm25(1, 10)');
INSERT INTO records(records) VALUES ('optimize');

VACUUM;
ANALYZE;
