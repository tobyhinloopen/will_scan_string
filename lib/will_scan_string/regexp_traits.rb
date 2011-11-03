module WillScanString
	module RegexpTraits
		CAPTURE_GROUP_PATTERN = /(?<!\\)\((?:\?(?:<([a-z]+)\>|'([a-z]+)')|(?!\?))/i

		def capture_groups
			c = 0
			r = []
			source.scan(CAPTURE_GROUP_PATTERN) { r.push $+.present? ? $+.to_sym : c+=1 }
			r
		end
	end
end