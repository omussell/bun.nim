import unittest
import ../src/bun

#suite "description for this stuff":
#  echo "suite setup: run once before the tests"
#  
#  setup:
#    echo "run before each test"
#  
#  teardown:
#    echo "run after each test"
#  
#  test "essential truths":
#    # give up and stop if this fails
#    require(true)
#  
#  test "slightly less obvious stuff":
#    # print a nasty message and move on, skipping
#    # the remainder of this block
#    check(1 != 1)
#    check("asd"[2] == 'd')
#  
#  test "out of bounds error is thrown on bad access":
#    let v = @[1, 2, 3]  # you can do initialization here
#  
#  echo "suite teardown: run once after the tests"

suite "Basics":

  #test "if no matching file is found, return default.yaml":
  #  #doAssert hello(5) == 9

  #  doAssert main("nonexistent.fqdn") == "---\nenvironment: production"
  test "fqdn is split into tokens correctly":
    doAssert getTokens("testfqdn") == @["testfqdn"]
    doAssert getTokens("test-fqdn") == @["test", "fqdn"]
    doAssert getTokens("test-fqdn.com") == @["test", "fqdn", "com"]

  test "file for fqdn is found":
    doAssert findMatch(@["testfqdn"]) == "/home/oem/bun.nim/nodes/testfqdn.yaml"
    doAssert findMatch(@["test", "fqdn"]) == "/home/oem/bun.nim/nodes/test-fqdn.yaml"
    doAssert findMatch(@["test", "fqdn", "com"]) == "/home/oem/bun.nim/nodes/test-fqdn-com.yaml"

  test "file for fqdn is not found":
    doAssert findMatch(@["nonexistent", "fqdn"]) == "/home/oem/bun.nim/nodes/default.yaml"
