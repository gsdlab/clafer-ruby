namespace :clafer do
  desc "Print Clafer model"
  task(:print) { Tasks.print }
end

task clafer: 'clafer:print'
