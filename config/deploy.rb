lock '3.2.1'

set :rbenv_ruby, '2.1.2'

set :application, 'ten_moves_web'
set :repo_url, 'https://github.com/davidpdrsn/Ten-Moves-Api.git'
set :user, "deployer"

set :deploy_to, "/home/#{fetch :user}/apps/#{fetch :application}"

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_files, %w{config/database.yml config/application.yml}

namespace :deploy do
  desc "tag current revision as production"
  task :tag_ref do
    tag_name = "production"
    system "git tag -d #{tag_name}"
    system "git tag #{tag_name}"
  end

  desc "Clear cache"
  task :clear_cache do
    on roles(:all) do
      execute "cd /home/deployer/apps/ten_moves_web/current; bin/rake cache:clear RAILS_ENV=production"
    end
  end
end

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

after :deploy, 'deploy:tag_ref'
after :deploy, 'deploy:tag_ref'
after 'deploy:publishing', 'deploy:restart'
