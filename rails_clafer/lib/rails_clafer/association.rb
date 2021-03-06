module RailsClafer
  class Association
    class << self
      def from_ar_assoc(src_class, ar_assoc)
        card = Card.from_ar_assoc ar_assoc
        assoc = new ClaferModel.claferize_name(src_class.name),
          ClaferModel.claferize_name(ar_assoc.klass.name), card
        assoc.ref_name = ClaferModel.claferize_name ar_assoc.name if ar_assoc.name
        assoc
      end
    end
    attr_accessor :src, :dst, :dst_card, :ref_name
    def initialize(src, dst, dst_card)
      @src, @dst, @dst_card = src, dst, dst_card
    end
  end
end
