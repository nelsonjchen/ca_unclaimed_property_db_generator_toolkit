
all: ca_lost_property.sqlite

.PHONY: upload

00_All_Records.zip:
	aria2c https://dpupd.sco.ca.gov/00_All_Records.zip

00_All_Records/All_Records__File_1_of_1.csv: 00_All_Records.zip
	unzip 00_All_Records.zip -d .
	touch 00_All_Records/All_Records__File_1_of_1.csv

ca_lost_property.sqlite: 00_All_Records/All_Records__File_1_of_1.csv import.sql
	rm $@ || true
	sqlite3 $@ < import.sql

upload: ca_lost_property.sqlite
	aws s3 cp ./ca_lost_property.sqlite s3://datasette-lite/ --profile cf --endpoint-url https://c455dc5b9661861484370320794ab63c.r2.cloudflarestorage.com
