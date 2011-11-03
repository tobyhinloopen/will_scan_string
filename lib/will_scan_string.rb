require "will_scan_string/version"
require "will_scan_string/string_scanner"
require "will_scan_string/regexp_traits"

module WillScanString
	Regexp.send( :include, RegexpTraits )
end
