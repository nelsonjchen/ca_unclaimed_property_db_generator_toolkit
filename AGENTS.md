# Repository Guidance

## DuckDB import shape

Keep `import_duckdb.sql` as a compact import of the source CSV columns only. Do not add a stored `full_text` column to the DuckDB table: it duplicates most row data and made the generated database much larger.

The California unclaimed property data occasionally has values in surprising columns. When a broad "search everywhere" query is needed, build the search text ad hoc in the query instead of changing the stored schema. For example:

```sql
SELECT *
FROM records
WHERE lower(concat_ws(' ',
  PROPERTY_ID,
  PROPERTY_TYPE,
  CASH_REPORTED,
  SHARES_REPORTED,
  NAME_OF_SECURITIES_REPORTED,
  NO_OF_OWNERS,
  OWNER_NAME,
  OWNER_STREET_1,
  OWNER_STREET_2,
  OWNER_STREET_3,
  OWNER_CITY,
  OWNER_STATE,
  OWNER_ZIP,
  OWNER_COUNTRY_CODE,
  CURRENT_CASH_BALANCE,
  NUMBER_OF_PENDING_CLAIMS,
  NUMBER_OF_PAID_CLAIMS,
  HOLDER_NAME,
  HOLDER_STREET_1,
  HOLDER_STREET_2,
  HOLDER_STREET_3,
  HOLDER_CITY,
  HOLDER_STATE,
  HOLDER_ZIP,
  CUSIP
)) LIKE '%search text%';
```
