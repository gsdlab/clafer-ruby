module RailsClafer
  class ClaferRailtie < Rails::Railtie
    rake_tasks do
      require 'rails_clafer/clafer.rake'
    end
  end
end
