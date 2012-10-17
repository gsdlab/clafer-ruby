module Clafer
	def load_clafer(&block)
		ClaferScope.load_clafer(&block)
	end

	class BaseClafer

	end

	class ClaferScope
		class<<self
			def load_clafer(&block)
				main_scope = ClaferScope.new('').instance_eval(&block) if block
				main_scope
			end
			def desugarize(clafer_code)
				def get_tabs(line)
					/(\t*).*/.match(line) do |m|
						return m[1].count("\t")
					end
					return 0
				end
				lines = clafer_code.split("\n")
				output = lines.dup
				offset = 0
				prev_tabs = nil
				lines.each_with_index do |line, idx|
					if (not line.strip.empty?)
						prev_tabs = get_tabs line if prev_tabs == nil
						tabs = get_tabs line
						next_tabs = get_tabs lines[idx+1] if (lines.length>idx)
						output[idx] = line + " {" if (next_tabs > tabs)
						diff = prev_tabs - tabs
						if diff > 0
							diff.downto(1) do |n|
								output.insert(idx+diff-n+offset,"#{"\t" * (diff)} }") 
								offset += 1
							end
						end
						if lines.length<=idx+1
							diff = tabs - next_tabs
							if diff > 0
								diff.downto(1) do |n|
									output.insert(idx+diff-n+offset,"#{"\t" * (diff-1)} }") 
									offset += 1
								end
							end
						end
							prev_tabs = tabs
					end
				end
				output
			end
			def load_clafer_from_string()
			end
		end

		attr_reader :items
		def initialize(currentPath)
			@items = []
			@path = currentPath		
		end
		def doClafer(name, &block)
			current_item = MetaClafer.new(name, @path)
			scope = ClaferScope.new(@path+name.to_s+'/')
			scope.instance_eval(&block) if block
			scope.items.each do |subitem|
				current_item.addSubclafer(subitem)
			end
			current_item.init
			@items << current_item
		end
		def method_missing(name, &block)
			doClafer(name, &block)
		end

	end

	class MetaClafer
		attr_reader :name
		def initialize(name, path)
			#class_name = path.chop.split('/').collect(&:capitalize).join('::')
			#class_name = class_name  + "::" if not class_name.empty?
			#class_name = class_name + name.to_s.capitalize
			@name = name
			@subclafers =[]
		end

		def ruby_class()
			@ruby_class
		end
		def addSubclafer(subclafer)
			@subclafers << subclafer
		end
		def init()
			class_name = @name.to_s.capitalize
			subclafers = @subclafers
			@ruby_class = Object.const_set(class_name, Class.new(BaseClafer){
				subclafers.each do |subcfr|
				define_method(subcfr.name) do
					self.instance_eval("@" + subcfr.name.to_s);
				end
				end

			define_method(:initialize) do
				subclafers.each do |subcfr|
					instance_variable_set("@"+subcfr.name.to_s, subcfr.ruby_class.new)
				end
			end
			})
			@ruby_class.class_eval do
				#attr_accessor name
			end
		end
		def to_s
			"{ \"clafer\" : \"#{@name}\", \n\t \"subclafers\" : #{@subclafers.to_s} } "  
		end

	end
end


include Clafer

cfr = load_clafer {
	house {
	door
	Address(){
		city
	}
}
}

clafer_string = <<CLAFER
A
	B
	C
		D
			F
	E
CLAFER



#cfr2 = ClaferScope.load_clafer_from_string clafer_string

#puts ClaferScope.desugarize(clafer_string)

#puts House
house = House.new
puts "house: #{house.to_s}"
puts "house.Address.city: #{house.Address.city}"

puts cfr.to_s

=begin
output:
house: #<House:0x00000002295a98>
house.Address.city: #<City:0x00000002295890>
[{ clafer='house', 
	 subclafers=[{ clafer='door', 
	 subclafers=[] } , { clafer='Address', 
	 subclafers=[{ clafer='city', 
	 subclafers=[] } ] } ] } ]

=end


