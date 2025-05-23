# Ensure that bundle is used for rake tasks
SSHKit.config.command_map[:rake] = "bundle exec rake"

# config valid only for Capistrano 3.1
lock '3.19.2'

set :application, 'bladesdb'
set :repo_url, 'git@github.com:dantarian/bladesdb'
set :branch, :main

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :stages, ["production"]

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/bladesdb'
#set :deploy_via, :remote_cache
#set :copy_exclude, ['.git']

set :rvm_type, :system
set :rvm_ruby_version, '3.1.6@blades'

set :bundle_path, nil
set :bundle_binstubs, nil
set :bundle_flags, '--system'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{db/production.sqlite3}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on primary(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, :fix_sqlite_booleans
        end
      end
    end
  end

  # Run 'cap production deploy:seed' to seed your database
  desc 'Runs rake db:seed'
  task :seed => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:seed"
        end
      end
    end
  end

end
