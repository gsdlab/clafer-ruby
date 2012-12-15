module RailsClafer
  class GCard
    attr_accessor :min, :max
    def initialize(min=0,max="*")
      @min = min
      @max = max
    end
  end
end
