luaunit = require('luaunit')
counter = require('countmin')


-- default config
epsilon = 1 / 10000
delta = 0.0001
stringtest = 'testingtesting'
dataset = {}
for line in io.lines('./list') do
  table.insert(dataset, line)
end


-- initialization tests that should pass
function TestInit()
  filter = counter.new(epsilon, delta)
  luaunit.assertEquals(filter.getNumItems(), 0)
  luaunit.assertIsTable(filter)
end


-- initialization tests that should fail
TestInitNotOk = {}

  function TestInitNotOk:testEpsilonMustBeNumber()
    luaunit.assertFalse(pcall(counter.new, "10000", delta))
    luaunit.assertFalse(pcall(counter.new, {}, delta))
    luaunit.assertFalse(pcall(counter.new, false, delta))
    luaunit.assertFalse(pcall(counter.new, nil, delta))
  end

  function TestInitNotOk:testDeltaMustBeNumber()
    luaunit.assertFalse(pcall(counter.new, epsilon, '0.0001'))
    luaunit.assertFalse(pcall(counter.new, epsilon, {}))
    luaunit.assertFalse(pcall(counter.new, epsilon, false))
    luaunit.assertFalse(pcall(counter.new, epsilon, nil))
  end


-- verify that the error rate does not go above what we specified
function TestVerifyErrorRate()
  filter = counter.new(epsilon, delta)
  luaunit.assertIsTable(filter)
  local i
  for x = 1, 7 do
    i = 0
    for _, line in ipairs(dataset) do
      filter.add(line)
      luaunit.assertEquals(filter.check(line), x)
      i = i + 1
    end
  end

  luaunit.assertAlmostEquals(filter.getNumItems(), i, math.ceil(delta * filter.getNumItems()))
end

function TestReset()
  filter = counter.new(epsilon, delta)
  luaunit.assertIsTable(filter)
  luaunit.assertEquals(filter.getNumItems(), 0)

  luaunit.assertEquals(filter.add(stringtest), 1)
  luaunit.assertEquals(filter.getNumItems(), 1)

  filter.reset()
  luaunit.assertEquals(filter.getNumItems(), 0)
end


os.exit(luaunit.LuaUnit.run())
