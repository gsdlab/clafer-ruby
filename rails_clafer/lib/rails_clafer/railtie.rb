module RailsClafer
  class ClaferRailtie < Rails::Railtie
    rake_tasks do
      load 'rails_clafer/clafer.rake'
    end
  end
end
