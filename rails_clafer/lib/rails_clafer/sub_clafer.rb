module RailsClafer
  class SubClafer
    class << self
      def from_assoc(assoc, clafer)
        new clafer, assoc.dst_card
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

    def children
      @clafer.children			
    end
  end
end
