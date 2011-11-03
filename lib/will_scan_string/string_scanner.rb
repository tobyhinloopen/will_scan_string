module WillScanString
	class StringScanner
		def register_replacement( *args, &block )
			args.push block if block.present?
			@replacements = [] if @replacements.nil?
			@replacements << args
			@replacements_regexp = nil
		end

		def replace( string )
			string.gsub(replacement_regexp) do
				m = $~.to_a.tap{ |m| m.shift }
				i = m.find_index{ |v| v.present? }
				m = m[i]
				r = @replacements[i].last
				case r
				when Proc
					r.call m
				else
					r.to_s
				end
			end
		end

		protected
		def replacement_regexp
			@replacements_regexp ||= reconstruct_replacement_regexp
		end

		private
		def reconstruct_replacement_regexp
			c = -1
			pattern = @replacements.map(&:first).map{ |pat|
				"(#{ pat.is_a?(Regexp) ? pat.source : Regexp.escape(pat.to_s) })"
			}.join "|"
			Regexp.new "(?:#{pattern})"
		end
	end
end