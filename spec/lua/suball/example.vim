nnoremap <expr> S ':%' .. luaeval('require("suball").map(vim.fn.expand("<cword>"), "")')

" Type S on `test_case` and input `case_test<Enter>`.
" Then, the following all patterns are substituted.

" TEST_CASE -> CASE_TEST
" test_case -> case_test
" test-case -> case-test
" TestCase  -> CaseTest
" testCase  -> caseTest
