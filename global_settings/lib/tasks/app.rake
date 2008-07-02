namespace :app do
  task :install => ['db:migrate', 'db:fixtures:load'] do
    puts '>> Installed!'
  end
end