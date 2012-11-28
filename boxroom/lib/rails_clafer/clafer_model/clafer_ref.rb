module ClaferModel

	class ClaferRef
		attr_accessor :ref_name, :clafer
    attr_accessor :card, :gcard
		def initialize(ref_name, clafer)
			@ref_name, @clafer= ref_name, clafer
      @card = Card.new
      @gcard = GCard.new
		end
		def clafer_name
			@clafer.name	
		end
	end
end
