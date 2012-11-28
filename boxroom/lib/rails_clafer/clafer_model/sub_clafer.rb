module ClaferModel
	class SubClafer
    class << self
      def from_assoc(assoc, clafer)
        new clafer, Card.from_assoc(assoc)
      end
    end
		attr_accessor :name, :clafer, :card, :gcard
		def initialize(clafer, card)
			@name = clafer.name
			@clafer = clafer
      @card = card
      @gcard = GCard.new
    end

    def method_missing(name, *args)
      if @clafer.respond_to?(name)
        @clafer.send(name, *args)
      else
        super
      end
    end

    #def respond_to?(name)
    #  !!(@clafer.respond_to?(name) || super)
    #end

		def subclafers
			@clafer.subclafers			
		end
	end
end
