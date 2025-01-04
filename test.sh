#!/bin/sh
. ./format.sh

assert() {
	expected=$1
	actual=$2

	if test "$actual" = "$expected"; then
		echo "OK:  $expected"
	else
		echo "FAIL: $expected != $actual"
	fi
}

assert_fmt() {
	assert "$(printf "$1" "$3")" "$(fmt "$2" "$3")"
}

assert_fmt '\033[;31m%s\033[;0m\n' red xxx
assert_fmt '\033[;31;1m%s\033[;0m\n' red,bold xxx
assert_fmt '\033[;1;31m%s\033[;0m\n' bold,red xxx
assert_fmt '\033[;41m%s\033[;0m\n' bg,red xxx
assert_fmt '\033[;21m%s\033[;0m\n' not,bold xxx
assert_fmt '\033[;21;31m%s\033[;0m\n' not,bold,red xxx
assert_fmt '\033[;23;4m%s\033[;0m\n' not,em,u xxx
assert_fmt '\033[;23;4m%s\033[;0m\n' not-em,u xxx
assert_fmt '\033[;41m%s\033[;0m\n' bg-red xxx
assert_fmt '\033[;31m%s\033[;0m\n' fg-red xxx
