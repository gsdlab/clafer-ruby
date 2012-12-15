namespace :clafer do
  desc "Print Clafer model"
  require 'rails_clafer'
  task(:print) { RailsClafer.print }
end

task clafer: 'clafer:print'
