module ClaferModel

	class RefClafer
    class << self
      def from_assoc(assoc, clafer)
        card = Card.from_assoc assoc
        new assoc.name, clafer, card 
      end
    end
		attr_accessor :ref_name, :clafer, :card, :gcard, :constraint
		def initialize(ref_name, clafer, card)
			@ref_name, @clafer= ref_name, clafer
      @card = card
      @gcard = GCard.new
		end
		def clafer_name
			@clafer.name	
		end
	end
end
