CREATE TABLE main.records AS
SELECT *,
       LOWER(
           COALESCE(CAST(PROPERTY_ID AS VARCHAR), '') || ' ' ||
           COALESCE(PROPERTY_TYPE, '') || ' ' ||
           COALESCE(CAST(CASH_REPORTED AS VARCHAR), '') || ' ' ||
           COALESCE(CAST(SHARES_REPORTED AS VARCHAR), '') || ' ' ||
           COALESCE(NAME_OF_SECURITIES_REPORTED, '') || ' ' ||
           COALESCE(NO_OF_OWNERS, '') || ' ' ||
           COALESCE(OWNER_NAME, '') || ' ' ||
           COALESCE(OWNER_STREET_1, '') || ' ' ||
           COALESCE(OWNER_STREET_2, '') || ' ' ||
           COALESCE(OWNER_STREET_3, '') || ' ' ||
           COALESCE(OWNER_CITY, '') || ' ' ||
           COALESCE(OWNER_STATE, '') || ' ' ||
           COALESCE(OWNER_ZIP, '') || ' ' ||
           COALESCE(OWNER_COUNTRY_CODE, '') || ' ' ||
           COALESCE(CAST(CURRENT_CASH_BALANCE AS VARCHAR), '') || ' ' ||
           COALESCE(CAST(NUMBER_OF_PENDING_CLAIMS AS VARCHAR), '') || ' ' ||
           COALESCE(CAST(NUMBER_OF_PAID_CLAIMS AS VARCHAR), '') || ' ' ||
           COALESCE(HOLDER_NAME, '') || ' ' ||
           COALESCE(HOLDER_STREET_1, '') || ' ' ||
           COALESCE(HOLDER_STREET_2, '') || ' ' ||
           COALESCE(HOLDER_STREET_3, '') || ' ' ||
           COALESCE(HOLDER_CITY, '') || ' ' ||
           COALESCE(HOLDER_STATE, '') || ' ' ||
           COALESCE(HOLDER_ZIP, '') || ' ' ||
           COALESCE(CUSIP, '')
       ) AS full_text
FROM read_csv_auto('00_All_Records/All_Records__File_1_of_1.csv', ignore_errors=true);
