local helper = require "test.helper"
local assert = helper.assert
local command = helper.command

describe('suball', function ()
  it('can substitute various cases strings with keeping them cases', function ()
    helper.set_lines([[
TEST_CASE
test_case
test-case
TestCase
testCase]])

    local cmd = vim.fn["suball#command"]("test_case", "case_test")
    command("%" .. cmd)

    assert.lines([[
CASE_TEST
case_test
case-test
CaseTest
caseTest]])
  end)
end)
