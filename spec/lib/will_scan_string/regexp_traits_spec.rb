require 'spec_helper.rb'

describe WillScanString::RegexpTraits do
	it "should match regular capture groups" do
		/(a)/.capture_groups.should eql [ 1 ]
	end

	it "should not match escaped capture groups" do
		/\(\)/.capture_groups.should eql []
	end

	it "should match named capture groups with less-than & greater-than characters" do
		/(?<a>a)/.capture_groups.should eql [ :a ]
	end

	it "should match named capture groups with single quotes" do
		/(?'a'a)/.capture_groups.should eql [ :a ]
	end

	it "should match nested regular capture groups" do
		/(a(b))/.capture_groups.should eql [ 1, 2 ]
	end

	it "should ignore non-capture groups" do
		/(?:a)/.capture_groups.should eql []
	end

	it "should ignore look-aheads and look-behinds" do
		/(?=)/.capture_groups.should eql []
		/(?!)/.capture_groups.should eql []
		/(?<=)/.capture_groups.should eql []
		/(?<!)/.capture_groups.should eql []
	end

	it "should match the capture groups in my bbcode gem's regular expressions" do
		/\[(\/?)([a-z0-9_-]*)(\s*=?(?:(?:\s*(?:(?:[a-z0-9_-]+)|(?<=\=))\s*[:=]\s*)?(?:"[^"\\]*(?:\\[\s\S][^"\\]*)*"|'[^'\\]*(?:\\[\s\S][^'\\]*)*'|[^\]\s,]+|(?<=,)(?=\s*,))\s*,?\s*)*)\]/i.capture_groups.should \
			eql [ 1, 2, 3 ]
		/(?:\s*(?:([a-z0-9_-]+)|^)\s*[:=]\s*)?("[^"\\]*(?:\\[\s\S][^"\\]*)*"|'[^'\\]*(?:\\[\s\S][^'\\]*)*'|[^\]\s,]+|(?<=,)(?=\s*,))\s*,?/i.capture_groups.should \
			eql [ 1, 2 ]
	end

	it "should handle a regexp matching newlines" do
		/(?:\r\n|\r|\n)/.capture_groups.should eql []
	end
end