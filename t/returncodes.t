#!/bin/sh

test_description='Makes sure basic return codes are correct'
. ./sharness.sh

test_expect_success '-h exits normally' '
  txtcmp -h
'

test_expect_success '-v exits normally' '
  txtcmp -v
'

test_expect_success 'garbage flags exit abnormally' '
  test_must_fail txtcmp -k
'

test_expect_success 'zero positional args fails' '
  test_must_fail txtcmp
'

test_expect_success 'one positional arg fails' '
  test_must_fail txtcmp foo
'

test_expect_success 'nonexistent file failure' '
  echo "txtcmp: notexist1: No such file or directory" >expected &&
  test_must_fail txtcmp notexist1 notexist2 2>actual &&
  test_cmp expected actual
'

test_expect_success 'opening a directory fails' '
  echo "txtcmp: mydir: Is a directory" >expected &&
  mkdir mydir &&
  touch myfile &&
  test_must_fail txtcmp mydir myfile 2>actual &&
  test_cmp expected actual
'

test_done
