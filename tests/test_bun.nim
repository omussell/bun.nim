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

suite "Different file contents":

  test "if no matching file is found, return default.yaml":
    doAssert hello(5) == 9
  
