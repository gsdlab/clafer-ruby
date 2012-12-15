module RailsClafer
  class RefClafer
    class << self
      def from_assoc(assoc, type_clafer)
        new assoc.ref_name, type_clafer, assoc.dst_card 
      end
    end
    attr_accessor :ref_name, :clafer, :card, :gcard, :constraint
    def initialize(ref_name, type_clafer, card)
      @ref_name, @clafer= ref_name, type_clafer
      @card = card
      @gcard = GCard.new
    end
    def clafer_name
      @clafer.name	
    end
  end
end
