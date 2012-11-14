module ClaferModel
	class SubClafer
		attr_accessor :name, :clafer
		def initialize(clafer)
			@name = clafer.name
			@clafer = clafer
		end
		def subclafers
			@clafer.subclafers			
		end
	end
end
