module ClaferModel
  class Card
    class << self
      def from_assoc(assoc)
        if assoc.collection?
          new 0, "*"
        else
          new 1, 1
        end
      end
    end
    attr_accessor :min, :max
    def initialize(min=1,max=1)
      @min, @max = min, max
    end
  end
end
