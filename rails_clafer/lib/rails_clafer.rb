require "rails_clafer/version"
require "rails_clafer/railtie" if defined? Rails

module RailsClafer
  class << self
    def print
      init
      claferCode = ClaferPrinter.print_clafers ClaferModel.abstract_clafers
      puts claferCode
      claferCode
    end

    def init
      Rails.application.eager_load!
    end
  end
end
