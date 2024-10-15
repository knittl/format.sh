#shellcheck shell=sh
# no shebang, must be sourced

# a bunch of functions which should simplify working with ANSI SGR escape sequences
# it's not efficient, but simple to use

_sgr_color() { printf ';%s%s' "$_sgr_bgfg" "$1"; }
_sgr_attr() { # _sgr_attr attribute
	case "$1" in
		# disable next SGR:
		not) _sgr_not=2 ;; # 2X
		# select foreground/background:
		fg|foreground) _sgr_bgfg=3 ;;
		bg|background) _sgr_bgfg=4 ;;
		# raw SGR codes:
		[0-9]|[0-9][0-9]) printf ';%s%s' "$_sgr_not" "$1" ;;
		# formats:
		reset)                        _sgr_attr 0 ;;
		strong|b|bold|bright|intense) _sgr_attr 1 ;;
		faint|dim)                    _sgr_attr 2 ;;
		em|i|italic)                  _sgr_attr 3 ;;
		u|underline)                  _sgr_attr 4 ;;
		blink)                        _sgr_attr 5 ;;
		blink-rapid,rapid)            _sgr_attr 6 ;;
		reverse)                      _sgr_attr 7 ;;
		conceal|hide)                 _sgr_attr 8 ;;
		s|strike|crossed-out)         _sgr_attr 9 ;;
		# colors:
		black)   _sgr_color 0 ;;
		red)     _sgr_color 1 ;;
		green)   _sgr_color 2 ;;
		yellow)  _sgr_color 3 ;;
		blue)    _sgr_color 4 ;;
		magenta) _sgr_color 5 ;;
		cyan)    _sgr_color 6 ;;
		white)   _sgr_color 7 ;;
		default) _sgr_color 9 ;;
	esac
}

_sgr() { printf '\033[%sm' "$(for attr in fg "$@"; do _sgr_attr "$attr"; done)"; }
_sgr_reset="$(_sgr reset)" # cache frequently-used, constant value
_spread() ( set -f && IFS=', ' && "$1" ${2+$2} )

fmt() { # fmt attr1,attr2,attrN text...
	attrs="$1"; shift
	printf "%s%s%s\n" "$(_spread _sgr "$attrs")" "$*" "$_sgr_reset"
}

bold() { fmt bold "$@"; }
underlined() { fmt underline "$@"; }
