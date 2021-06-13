local helper = require("suball.lib.testlib.helper")
local suball = helper.require("suball")

describe("suball", function()

  it("can substitute various cases strings with keeping them cases", function()
    helper.set_lines([[
TEST_CASE
test_case
test-case
TestCase
testCase]])

    local cmd = suball.input("test_case", "case_test")
    vim.cmd("%" .. cmd)

    assert.lines([[
CASE_TEST
case_test
case-test
CaseTest
caseTest]])
  end)

end)
