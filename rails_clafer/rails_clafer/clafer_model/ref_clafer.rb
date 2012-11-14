module ClaferModel

	class RefClafer
		attr_accessor :ref_name, :clafer
		def initialize(ref_name, clafer)
			@ref_name, @clafer= ref_name, clafer
		end
		def clafer_name
			@clafer.name	
		end
	end
end
