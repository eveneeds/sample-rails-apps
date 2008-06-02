namespace :app do
  desc 'Runs initialization tasks.'
  task :install => ['db:migrate', 'db:fixtures:load'] do
    puts '>> Installed!'
  end
end