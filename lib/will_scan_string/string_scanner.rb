module WillScanString
	class StringScanner
		def register_replacement( pattern, replacement )
			@replacements = [] if @replacements.nil?
			@replacements << [ pattern, replacement, @replacements.last.present? ? @replacements.last[2] + (@replacements.last[0].is_a?(Regexp) ? @replacements.last[0].capture_groups.length : 0) + 1 : 0 ]
			@replacements_regexp = nil
		end

		def replace( string )
			string.gsub(replacement_regexp) do
				m, r = *get_match_and_replacement( $~ )
				execute_replacement_with_match r, m
			end
		end

		protected
		def get_match_and_replacement( m )
			matchArray = m[1..-1]
			i = matchArray.find_index{ |v| !v.nil? }
			r = find_replacement_by_index(i)
			cps = [0] + (r[0].is_a?(Regexp) ? r[0].capture_groups : [])
			[[m]+matchArray[i+1, cps.length], r[1]]
		end

		def execute_replacement_with_match( r, m )
			r.is_a?(Proc) ? r.call(*m) : r.to_s
		end

		def find_replacement_by_index( i )
			@replacements.find{ |r| r[2] == i }
		end

		def replacement_regexp
			@replacements_regexp ||= reconstruct_replacement_regexp
		end

		private
		def reconstruct_replacement_regexp
			additional_offset = 1
			pattern = @replacements.map(&:first).map{ |pat|
				cpsc = pat.is_a?(Regexp) ? pat.capture_groups.length : 0
				pat = pat.is_a?(Regexp) ? pat.source : Regexp.escape(pat.to_s)
				pat.gsub!(/(?<!\\\\)(?<=\\)(\d+)/){ $1.to_i + additional_offset }
				additional_offset += 1 + cpsc
				"(#{pat})"
			}.join "|"
			/(?:#{pattern})/
		end
	end
end