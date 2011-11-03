require 'spec_helper.rb'

describe WillScanString::StringScanner do
	it "dunno" do
		ss = WillScanString::StringScanner.new
		ss.register_replacement ":)", %{HAPPY}
		ss.register_replacement ":(", %{SAD}
		ss.replace(":) or :(").should eql("HAPPY or SAD")
	end
end