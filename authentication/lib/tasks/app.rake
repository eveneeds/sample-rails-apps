namespace :app do
  desc 'Migrate the database and load some data into it.'
  task :install => ['db:migrate', 'db:fixtures:load'] do
    puts '>> Installed!'
  end
end