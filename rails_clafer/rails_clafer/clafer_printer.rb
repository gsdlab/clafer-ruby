module ClaferPrinter
	class << self 
		def print_clafers(list)
			list.each do |clafer|
				print_clafer(clafer, 0)
			end
		end

		def print_clafer(clafer, indent_level)
			whitespace = ' ' * indent_level * 4
			if clafer.respond_to?(:ref_name)
				puts "#{whitespace}#{clafer.ref_name} -> #{clafer.clafer_name}"
			elsif clafer.respond_to?(:name)
				puts "#{whitespace}#{clafer.name}"
			end
			if clafer.respond_to?(:subclafers)
				subclafers = clafer.subclafers
				subclafers.each do |subclafer|
				   	print_clafer(subclafer, indent_level + 1)
				end
			end

		end
	end

end
