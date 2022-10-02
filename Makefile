
all: ca_unclaimed_property.sqlite

UNAME := $(shell uname)

# split

ifeq ($(UNAME), Linux)
	SPLIT_CMD := split
	DATE_CMD := date
else
# Will need homebrew installed coreutils
	SPLIT_CMD := gsplit
	DATE_CMD := gdate
endif

DATE_PREFIX := $(shell $(DATE_CMD) +%Y-%m-%d)

.PHONY: upload split

clean:
	rm -rf 00_All_Records.zip 00_All_Records ca_unclaimed_property.sqlite

00_All_Records.zip:
	aria2c https://dpupd.sco.ca.gov/00_All_Records.zip

00_All_Records/All_Records__File_1_of_1.csv: 00_All_Records.zip
	unzip 00_All_Records.zip -d .
	touch 00_All_Records/All_Records__File_1_of_1.csv

ca_unclaimed_property.sqlite: 00_All_Records/All_Records__File_1_of_1.csv import.sql
	rm $@ || true
	sqlite3 $@ < import.sql

split: ca_unclaimed_property.sqlite
# Get checksum from file
	$(eval CHECKSUM := $(shell xxhsum ca_unclaimed_property.sqlite | awk '{print $$1}'))
	rm -rf sdb/
	mkdir -p sdb/
	echo $(CHECKSUM)
	$(SPLIT_CMD) --numeric-suffixes --suffix-length=4 -b 10m --additional-suffix=.bin ca_unclaimed_property.sqlite sdb/$(DATE_PREFIX)_$(CHECKSUM)_ca_unclaimed_property.sqlite.

upload: ca_unclaimed_property.sqlite
	aws s3 cp ./ca_unclaimed_property.sqlite s3://datasette-lite/ --profile cf --endpoint-url https://c455dc5b9661861484370320794ab63c.r2.cloudflarestorage.com
