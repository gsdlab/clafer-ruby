require 'rails'
class ClaferRailtie < Rails::Railtie
  rake_tasks do
    require 'clafer.rake'
  end
end
