#!/bin/bash

sanity() {
  msg=""
  which xmllint &>/dev/null || msg="You must install xmllint for this script to work"
  which jq &>/dev/null || msg="$msg\nYou must install jq for this script to work"
  if [[ ! "${#msg}" -eq 0 ]]
  then
    echo -e "Error: $msg"
    exit 1
  fi
}


fail() {
    echo FAIL: $1
    exit 1
}
sanity
END_POINT='http://localhost:8080/v1'
GET='lwp-request -m GET'
HEAD='lwp-request -m HEAD'

echo 'Fetching xml for all...'
$GET "${END_POINT}?format=xml" | xmllint - &> /dev/null || fail "invalid xml for all"
echo Pass!

echo 'Fetching xml for substitute_id=4...'
$GET "${END_POINT}?format=xml&substitute_id=4" | xmllint - &> /dev/null || fail "invalid xml for substitute_id=4"
number_of_assignments=$($GET "${END_POINT}?format=xml&substitute_id=4" | xmllint - | grep Nahid | wc -l)
if [ $number_of_assignments -ne 1 ]
then
    fail "Expected 1 element with Nahid for subst.id. 4, got:  $number_of_assignments"
fi
echo Pass!

echo 'Fetching xml for substitute_id=1&day=2018-01-15...'
$GET "${END_POINT}?format=xml&substitute_id=1&day=2018-01-15" | xmllint - &> /dev/null || fail "invalid xml for substitute_id=1"
number_of_assignments=$($GET "${END_POINT}?format=xml&substitute_id=1&day=2018-01-15" | xmllint - | grep Yrgo | wc -l)
if [ $number_of_assignments -ne 1 ]
then
    fail "Expected 1 element with Yrgo for subst.id. 1 at 2018-01-15, got:  $number_of_assignments"
fi
echo Pass!

echo 'Fetching xml for substitute_id=666...'
$GET "${END_POINT}?format=xml&substitute_id=666" | xmllint - &> /dev/null || fail "invalid xml for substitute_id=666"
$GET "${END_POINT}?format=xml&substitute_id=666" | xmllint - | egrep '<schedules></schedules>|<schedules/>' &> /dev/null || fail 'Expected <schedules></schedules> without finding it$'
echo Pass!

echo 'Fetching json for all...'
$GET "${END_POINT}?format=json" | jq '.' &> /dev/null || fail "invalid json for all"
echo Pass!

echo 'Fetching json for substitute_id=4...'
$GET "${END_POINT}?format=json&substitute_id=4" | jq '.' &> /dev/null || fail "invalid json for substitute_id=4"
number_of_assignments=$($GET "${END_POINT}?format=json&substitute_id=4" | jq '.' | grep Nahid | wc -l)
if [ $number_of_assignments -ne 1 ]
then
    fail "Expected 1 element with Nahid for subst.id. 4, got:  $number_of_assignments"
fi
echo Pass!

echo 'Fetching json for substitute_id=1&day=2018-01-15...'
$GET "${END_POINT}?format=json&substitute_id=1&day=2018-01-15" | jq '.' &> /dev/null || fail "invalid json for substitute_id=1&day=2018-01-15"
number_of_assignments=$($GET "${END_POINT}?format=json&substitute_id=1&day=2018-01-15" | jq '.' | grep Yrgo | wc -l)
if [ $number_of_assignments -ne 1 ]
then
    fail "Expected 1 element with Yrgo for subst.id. 1 at 2018-01-15, got:  $number_of_assignments"
fi
echo Pass!

echo 'Fetching json for substitute_id=666...'
$GET "${END_POINT}?format=json&substitute_id=666" | jq '.' &> /dev/null || fail "invalid json for substitute_id=666"
$GET "${END_POINT}?format=json&substitute_id=666" | jq '.' | egrep '\[\]' &> /dev/null || fail 'Expected [] without finding it'
echo Pass!

echo Grade is at least G

echo "If all test below pass, the grade is VG, otherwise see the documentation for how the API handles bad input."

echo
echo "The requirements for VG is to:"
echo '* handle incorrect input like missing parameters in a documented way'
echo '** Example: for a date or substitute_id which cannot be found in the database, the web API could respond with "404 Not Found"'
echo '* responds with the correct content-type header (e.g. application/json)'
echo

# Content-Type checks:
echo "Checking content-type for json..."
$HEAD "${END_POINT}?format=json" | grep -i content-type | grep 'application/json' || fail 'Content-Type: application/json not found'
echo Pass!

echo "Checking content-type for xml..."
$HEAD "${END_POINT}?format=xml" | grep -i content-type | grep 'application/xml' || fail 'Content-Type: application/xml not found'
echo Pass!

# 404 Not found checks:
echo "Checking not found (json)..."
$HEAD "${END_POINT}?format=json&day=apa" | grep '^404' &> /dev/null || fail '404 not sent'
echo Pass!

echo "Checking Not Found (xml)..."
$HEAD "${END_POINT}?format=xml&day=apa" | grep '^404' &> /dev/null || fail '404 not sent'
echo Pass!

# Bad format - Bad Request checks
echo "Checking Bad Request"
$HEAD "${END_POINT}?format=apa" | grep '^400' &> /dev/null || fail '400 not sent for bad format'
echo Pass!
