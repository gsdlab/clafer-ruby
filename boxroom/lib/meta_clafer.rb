module Clafer


	class MetaClafer 
		attr_reader :subclafers
        attr_reader :top

		def initialize(klass, top)
			@klass = klass
            @top = top
			@subclafers = {}
		end

		def add_subclafer(clafer_name, options)
			@subclafers[clafer_name] = {
				:name => clafer_name,
				:type => :subclafer,
				:options => options
			}
		end
		def add_ref_clafer(ref_name, clafer_name)
			@subclafers[ref_name] = {
				:name => ref_name,
				:clafer_type => clafer_name,
				:type => :clafer_ref
			}
		end
	end
end
