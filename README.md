# Lua count-min sketch
Contains a count-min implementation written in Lua. It has the following properties
* use Kirsh & Mitzenmacher enhanced double hashing to simplify hashing
* pseudorandomized hash seeds every time the filters are reset
* configurable additive factor for accumulated error per added item (epsilon) and probability of estimating counts outside of the accumulated error (delta).
* use one combined array instead of two dimensional array, keeps all numbers in one contiguous space in memory.

## Getting Started
New sketches are created with the new() method. Give it the additive factor for accumulated error per added item and the accepted error rate for estimating counts outside the bounds of the accumulated error.
```
local countmin = require("bloom")

counter = countmin.new(1 / 10000, 0.0001)

a = filter.add('string')
b = filter.add('string')
c = filter.check('string')

print(a .. ' ' .. b .. ' ' .. c)
```
Should print out '1 2 2'.

### Dependencies
The sketch is dependent [lua-xxhash](https://github.com/mah0x211/lua-xxhash). Which can be instlled with LuaRocks.
```
luarocks install xxhash
```

The unit tests depend on [luaunit](https://github.com/bluebird75/luaunit)
```
luarocks install luaunit
```

The performance tests depend on [luasocket](https://github.com/diegonehab/luasocket)
```
luarocks install luasocket
```

### Installing

Install the depencencies, then copy the countmin.lua file into your Lua path.

## Tests
Simple unit tests and performanc test are included. FYI, some of the tests depend on the ./list file being available, the tests should be run in the repository directory.

### Unit tests
```
$ lua tests.lua 
.....
Ran 5 tests in 0.339 seconds, 5 successes, 0 failures
OK
mikalsa@serenity:~/github/lua-count-min$ lua tests.lua -v
Started on Tue Sep 26 20:41:09 2017
    TestInit ... Ok
    TestInitNotOk.testDeltaMustBeNumber ... Ok
    TestInitNotOk.testEpsilonMustBeNumber ... Ok
    TestReset ... Ok
    TestVerifyErrorRate ... Ok
=========================================================
Ran 5 tests in 0.349 seconds, 5 successes, 0 failures
OK
```

### Simple performance tests
```
$ lua perftest.lua 
Initialized the sketch in 19.27685546875 msec
Reinitialized the sketch in 6.5859375 msec

Added 10000 items to the filter in 32.22802734375 msec
310.28892626093 inserts per msec

Checked 10000 items in the filter in 20.63916015625 msec
484.51583903097 inserts per msec
```

## Contributing
Send a pull request if you feel like it.

## Authors
See the list of [contributors](https://github.com/mikalsande/lua-count-min/graphs/contributors) who participated in this project.

## License
Unless another license is specified in the beginning of a file this project is licesed under the Unlicense - see the [LICENSE](LICENSE) file for details
