# California Lost Property SQLite Database generator

For full text searching, possibly over HTTP!

eg.

The following will take 100+ seconds to look up a random street address. 

https://datasette-lite.mindflakes.com/index.html?url=https://datasette-lite.mindflakes.com/odb.sqlite#/odb?sql=SELECT+*+FROM+records+WHERE+records+MATCH+%223201+Dulzura+Dr%0A%22+ORDER+BY+CAST%28CURRENT_CASH_BALANCE+AS+FLOAT%29+DESC%3B

There's no server on the backend. It's running an experimental fork of datasette-lite and the database engine runs on *your* computer:

https://github.com/nelsonjchen/datasette-lite/tree/createLazyFile

Locally though, it's much faster. Think less than 2 or 3 seconds. 

If so, just download https://datasette-lite.mindflakes.com/odb.sqlite, it'll be ~28GB. 
