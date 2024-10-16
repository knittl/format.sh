#!/bin/sh
. ./format.sh

assert() {
	actual=$2
	expected=$1

	if test "$actual" = "$expected"; then
		echo "OK:  $expected"
	else
		echo "FAIL: $expected != $actual"
	fi
}

assert "$(printf '\033[;31mxxx\033[;0m\n')" "$(fmt red xxx)"
assert "$(printf '\033[;31;1mxxx\033[;0m\n')" "$(fmt red,bold xxx)"
assert "$(printf '\033[;1;31mxxx\033[;0m\n')" "$(fmt bold,red xxx)"
assert "$(printf '\033[;41mxxx\033[;0m\n')" "$(fmt bg,red xxx)"
assert "$(printf '\033[;21mxxx\033[;0m\n')" "$(fmt not,bold xxx)"
assert "$(printf '\033[;21;31mxxx\033[;0m\n')" "$(fmt not,bold,red xxx)"
assert "$(printf '\033[;23;4mxxx\033[;0m\n')" "$(fmt not,em,u xxx)"
assert "$(printf '\033[;23;4mxxx\033[;0m\n')" "$(fmt not-em,u xxx)"
assert "$(printf '\033[;41mxxx\033[;0m\n')" "$(fmt bg-red xxx)"
assert "$(printf '\033[;31mxxx\033[;0m\n')" "$(fmt fg-red xxx)"
