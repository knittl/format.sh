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
	assert "$(printf "$1")" "$2"
}

assert_fmt '\033[;31mxxx\033[;0m\n' "$(fmt red xxx)"
assert_fmt '\033[;31;1mxxx\033[;0m\n' "$(fmt red,bold xxx)"
assert_fmt '\033[;1;31mxxx\033[;0m\n' "$(fmt bold,red xxx)"
assert_fmt '\033[;41mxxx\033[;0m\n' "$(fmt bg,red xxx)"
assert_fmt '\033[;21mxxx\033[;0m\n' "$(fmt not,bold xxx)"
assert_fmt '\033[;21;31mxxx\033[;0m\n' "$(fmt not,bold,red xxx)"
assert_fmt '\033[;23;4mxxx\033[;0m\n' "$(fmt not,em,u xxx)"
assert_fmt '\033[;23;4mxxx\033[;0m\n' "$(fmt not-em,u xxx)"
assert_fmt '\033[;41mxxx\033[;0m\n' "$(fmt bg-red xxx)"
assert_fmt '\033[;31mxxx\033[;0m\n' "$(fmt fg-red xxx)"
