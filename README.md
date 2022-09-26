# California Unclaimed Property SQLite Database Generator/Search Toolkit

This is a toolkit to dive a little deeper into California Unclaimed Property database than what the state controller's site offers.

> California’s Unclaimed Property Law requires banks, insurance companies, corporations, and certain other entities to report and submit their customers’ property to the State Controller’s Office when there has been no activity for a period of time (generally three years).

For most people who have done business or lived in California, the search for these properties can be done through:

https://ucpi.sco.ca.gov/en/Property/SearchIndex

You may find a small amount of money or a large pile of money. The database is always being updated, so you probably want to periodically check. This is the most convenient way to do so.

Unfortunately, like all databases, sometimes the data is a bit wonky and the limited search interface such as the one on the state controller's site might not be enough to locate all the properties of interest.

Some known limitations:

* You must enter a name.
  * You can't search on the state controller's site with only street address. Your property might not be under your exact name or it is misspelled. There is no "no name" option.
* Name entries can sometimes appear in the address.
  * If you have a loan-out, your name might be in "street address 1" or an even more obscure field.
* An anti-automation Recaptcha is present on the state controller's site to prevent bulk queries.
  * You may want to do many queries.
* Maybe the address was wrong, but you also don't know the exact names too.
  * You cannot fuzzy search with their interface.

Unlike many other states, California offers their database for download. It's a 3GB ZIP with a 18GB CSV. You can find an updated version here every Thursday:

https://www.sco.ca.gov/upd_download_property_records.html

Hint: it's probably best to download on Friday.

Processing the ZIP/CSV is left to the user. This toolkit is a set of scripts to create your own SQLite database for searching. It also links to a live version of the database exposed with a [customized datasette-lite][cdsl] for light queries that runs completely from your computer but it's a bit slow. You may also just download the 28GB SQLite database outright from the service as well.

## Usage

The first question to ask is: Do you actually need this? Use the [state controller's site][castatesearch] first. It's much more convenient.

### datasette-lite (experimental, easy, slow, maybe fast?)

This is the easiest way to use the database. It's a live version of the database that you can query with SQL from your web browser. The database engine runs completely in your web browser but certain workloads require a lot of little reads and this greatly increases query times. It is also rather experimental and may be a bit buggy and slow.

Start with this simple query that takes about 30 seconds to run and hack at the query to your heart's content for the next query to run:

https://datasette-lite.mindflakes.com/index.html?url=https://datasette-lite.mindflakes.com/ca_unclaimed_property.sqlite#/ca_unclaimed_property?sql=SELECT+*+FROM+records+WHERE+records+MATCH+%22Donald+Trump%0A%22+ORDER+BY+CAST%28CURRENT_CASH_BALANCE+AS+FLOAT%29+DESC%3B

### Use my pregenerated SQLite database

That same database targeted above? You can just download it outright, and open it with a [SQLite browser][sqlite_browser] or similar.

https://datasette-lite.mindflakes.com/ca_unclaimed_property.sqlite (~28GB)

It's hosted on Cloudflare R2. I do not care about the bandwidth usage.

### Generate Locally

You can also generate the SQLite database locally. The generation process takes about 80 minutes. I don't think many will do this but it's here if there's something the pre-generated database doesn't have and you want to customize something.

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
