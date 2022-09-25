
all: odb.sqlite

.PHONY: upload

00_All_Records.zip:
	aria2c https://dpupd.sco.ca.gov/00_All_Records.zip

00_All_Records/All_Records__File_1_of_1.csv: 00_All_Records.zip
	unzip 00_All_Records.zip -d .
	touch 00_All_Records/All_Records__File_1_of_1.csv

odb.sqlite: 00_All_Records/All_Records__File_1_of_1.csv odb.sql
	rm odb.sqlite || true
	sqlite3 odb.sqlite < odb.sql

upload: odb.sqlite
	aws s3 cp ./odb.sqlite s3://datasette-lite/ --profile cf --endpoint-url https://c455dc5b9661861484370320794ab63c.r2.cloudflarestorage.com
