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

    local key = "[fire]"
    vim.keymap.set("n", key, function()
      return ":%" .. suball.map("test_case", "") .. "case_test<CR>"
    end, { buffer = true, expr = true })
    vim.api.nvim_feedkeys(key, "rx", true)

    assert.lines([[
CASE_TEST
case_test
case-test
CaseTest
caseTest]])
  end)

  it("can substitute various cases strings even if target and input are one word", function()
    helper.set_lines([[
TEST
test
Test]])

    local key = "[fire]"
    vim.keymap.set("n", key, function()
      return ":%" .. suball.map("test", "") .. "case<CR>"
    end, { buffer = true, expr = true })
    vim.api.nvim_feedkeys(key, "rx", true)

    assert.lines([[
CASE
case
Case]])
  end)
end)
