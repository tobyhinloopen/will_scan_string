module WillScanString
	class StringScanner
		def register_replacement( pattern, replacement )
			@replacements = [] if @replacements.nil?
			@replacements << [ pattern, replacement, @replacements.last.present? ? @replacements.last[2] + (@replacements.last[0].is_a?(Regexp) ? @replacements.last[0].capture_groups.length : 0) + 1 : 0 ]
			@replacements_regexp = nil
		end

		def replace( string )
			result = string.dup
			result_offset = 0
			string.scan replacement_regexp do
				match = $~
				r = *execute_replacement_with_match(*get_match_and_replacement(match).reverse)
				replacement = r.last
				is_global = r.first == 1
				return replacement if is_global
				result[(result_offset+match.begin(0))...(result_offset+match.end(0))] = replacement
				result_offset += replacement.length - (match.end(0)-match.begin(0))
			end
			result
		end

		protected
		def get_match_and_replacement( m )
			matchArray = m[1..-1]
			i = matchArray.find_index{ |v| !v.nil? }
			r = find_replacement_by_index(i)
			cps = [0] + (r[0].is_a?(Regexp) ? r[0].capture_groups : [])
			[[m]+matchArray[i+1, cps.length-1], r[1]]
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