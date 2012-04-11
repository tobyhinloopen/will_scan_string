require 'spec_helper.rb'

describe WillScanString::StringScanner do
	it "should perform a regular replacement" do
		ss = WillScanString::StringScanner.new
		ss.register_replacement ":)", "HAPPY"
		ss.replace(":)").should eql "HAPPY"
	end

	it "should perform a regexp replacement with a capture group" do
		ss = WillScanString::StringScanner.new
		ss.register_replacement %r{<([a-z]+)>.*?</\1>}, ->(_, tagname){ "#{tagname}" }
		ss.replace("<strong>hi!</strong>").should eql("strong")
	end

	it "should not replace replaced strings" do
		ss = WillScanString::StringScanner.new
		ss.register_replacement ":)", %{<img src="happy.png" alt=":)" title=":)">}
		ss.register_replacement "<", "&lt;"
		ss.register_replacement ">", "&gt;"
		ss.register_replacement "\"", "&quot;"
		ss.register_replacement "&", "&amp;"
		ss.replace("& :) <").should eql %{&amp; <img src="happy.png" alt=":)" title=":)"> &lt;}
	end

	it "should be able to use multiple regular expressions to replace with" do
		ss = WillScanString::StringScanner.new
		ss.register_replacement /(a)(b)/, "AB"
		ss.register_replacement /(c)(d)/, "CD"
		ss.replace("abcd").should eql "ABCD"
	end

	it "should match newlines" do
		ss = WillScanString::StringScanner.new
		ss.register_replacement /(?:\r\n)/, "<br>"
		ss.replace("\r\n").should eql("<br>")
	end

	it "should return match as first argument" do
		ss = WillScanString::StringScanner.new
		ss.register_replacement /(a)(b)/, ->(match, a, b) { a*3 + b*3 + match.class.to_s }
		ss.replace("ab").should eql("aaabbbMatchData")
	end
end