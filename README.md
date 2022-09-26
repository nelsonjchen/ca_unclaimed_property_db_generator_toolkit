# California Unclaimed Property SQLite Database Generator/Search Toolkit

This is a toolkit to dive a little deeper into California Unclaimed Property database than what the state controller's site offers.

---

> California’s Unclaimed Property Law requires banks, insurance companies, corporations, and certain other entities to report and submit their customers’ property to the State Controller’s Office when there has been no activity for a period of time (generally three years).

For most people who have done business or lived in California, the search for these properties can be done through the state controller's site:

https://ucpi.sco.ca.gov/en/Property/SearchIndex

You may find a small amount of money or a large pile of money. The database is always being updated, so you probably want to periodically check. This is the most convenient way to do so.

Unfortunately, like many databases, sometimes the data is a bit wonky and the limited search interface to it such as the one on the state controller's site might not be enough to locate all the properties of interest.

Some known limitations:

* You must enter a name.
  * You can't search on the state controller's site with only street address. Your property might not be under your exact name or it is misspelled. There is no "no name" option. If you try, you get no error, but also no results. 
* Name entries can sometimes appear in the address.
  * If you have a loan-out, your name might be in "street address 1" or an even more obscure field.
* An anti-automation Recaptcha is present on the state controller's site to prevent bulk queries.
  * You may want to do many queries.
* Maybe the address was wrong, but you also don't know the exact names too.
  * You cannot fuzzy search with their interface.

Unlike many other states, California offers their database for download. It's a 3GB ZIP with a 18GB CSV. You can find an version here updated every Thursday:

https://www.sco.ca.gov/upd_download_property_records.html

Processing the ZIP/CSV is an exercise left to the user. This toolkit is a set of scripts to create your own SQLite database for searching. It also links to a live version of the database exposed with a [customized datasette-lite][cdsl] for light queries that runs completely from your computer but it's a bit slow. You may also just download the 28GB SQLite database outright from the service as well.

## Usage

The first question to ask is: Do you actually need this? Use the [state controller's site][castatesearch] first. It's much more convenient.

### Custom datasette-lite (experimental, easy, slow, maybe fast?)

![datasette-lite mindflakes com_index html_url=https___datasette-lite mindflakes com_odb sqlite(iPad Air)](https://user-images.githubusercontent.com/5363/192173696-46b71fac-8156-48af-bca3-b5f42c9d06f4.png)

This is the easiest way to use the database. It's a web version of the database that you can query with SQL. The database engine runs completely in your web browser but certain workloads require a lot of little reads and this greatly increases query times. It is also rather experimental and may be a bit buggy and slow.

Start with this simple query for the use case of looking up unclaimed properties at an address that takes about 9 seconds to run and hack at the query to your heart's content for the next query to run:

https://datasette-lite.mindflakes.com/index.html?url=https://datasette-lite.mindflakes.com/odb.sqlite#/odb?sql=SELECT+*+FROM+records+WHERE+records+MATCH+%0A%22%7BOWNER_STREET_1+OWNER_STREET_2+OWNER_STREET_3%7D%3A+2665+ticatica%22%0AORDER+BY+cast%28current_cash_balance+AS+float%29+DESC%3B

[This is a customized version of datasette-lite that pulls from ](https://github.com/simonw/datasette-lite/pull/49)

### Use my pregenerated SQLite database

That same database targeted above? You can just download it outright, and open it with a [SQLite browser][sqlite_browser] or similar.

https://datasette-lite.mindflakes.com/ca_unclaimed_property.sqlite (~28GB)

This file is hosted on Cloudflare R2. I do _not_ care about the bandwidth consumption.

### Generate Locally

You can also generate the SQLite database locally. The generation process takes about 80 minutes. I don't think many will do this but it's here if there's something the pre-generated database doesn't have and you want to customize something. It may also be useful if for some reason the hosted database is too stale.

#### Requirements

* Some *nix.
* `make`
* `sqlite`
* `aria2c`
* `unzip`
* Space for the 28GB SQLite database. The 18GB CSV. The 3GB ZIP.

#### Steps

Just run `make`. It will download the ZIP, extract the CSV, and generate the SQLite database. A database file called `ca_unclaimed_property.sqlite` will appear at the root of this project.

## License

The unclaimed property data was collected by the State of California and I believe it to be public domain under the [California Public Records Act][cpra]. I am not a lawyer, so if this is a concern, please seek professional legal advice.

The toolkit is licensed under the MIT License.

[castatesearch]: https://ucpi.sco.ca.gov/en/Property/SearchIndex
[cdsl]: https://github.com/simonw/datasette-lite/pull/49
[sqlite_browser]: https://sqlitebrowser.org/
[cpra]: https://en.wikipedia.org/wiki/California_Public_Records_Act
