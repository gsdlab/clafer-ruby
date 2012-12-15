require "rails_clafer/version"
require "rails_clafer/railtie" if defined? Rails

module RailsClafer
  class << self
    def print
      init
      require 'rails_clafer/clafer_printer'
      require 'rails_clafer/clafer_model'
      claferCode = ClaferPrinter.print_clafers ClaferModel.abstract_clafers
      puts claferCode
      claferCode
    end

    def init
      Rake::Task[:environment].invoke
      Rails.application.eager_load!
    end
  end
end
