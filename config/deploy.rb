#require "bundler/capistrano"
require 'railsless-deploy'

set :deploy_via, :remote_cache
set :application, "sidways"
server "cancer", :web, :app, :db, primary: true
set :repository,  "git://github.com/gxbsst/sidways.git"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"

set :scm, :git
set :use_sudo, false

set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

namespace :deploy do

  task :setup_config, roles: :app do
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/uploads"
    # put File.read("wp-config-sample.php"), "#{shared_path}/config/wp-config.php"
    puts "Now edit the config files in #{shared_path}."
  end

  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    # run "ln -nfs #{shared_path}/config/wp-config.php #{release_path}/wp-config.php"
    # run "ln -nfs #{shared_path}/uploads #{release_path}/wp-content/uploads"
    #run("chmod -R 777 #{current_path}/wp-content/uploads")
  end
  after "deploy:finalize_update", "deploy:symlink_config"

end




# require "bundler/capistrano"

# set :rvm_type, :user  # Don't use system-wide RVM

# set :deploy_via, :remote_cache

# set :application, "sidways"

# if ENV['RAILS_ENV'] =='production'
#   set :application, "sidways"
#   set :default_environment, {
#       'PATH' => "/home/deployer/.rbenv/versions/1.9.3-p448/bin/:$PATH"
#   }
#   server "cancer", :web, :app, :db, primary: true
#   set :repository,  "git://github.com/gxbsst/sidways.git"
#   set :user, "deployer"
#   set :deploy_to, "/home/#{user}/apps/#{application}"
# else
#   server "rails", :web, :app, :db, primary: true
#   set :repository,  "git://github.com/gxbsst/sidways.git"
#   # set :deploy_to, "/srv/rails/coopertire_deploy"
#   set :deploy_to, "/srv/rails/test"
#   set :user, "rails"
# end

# set :scm, :git
# # Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# # role :web, "aries.sidways.lab"                          # Your HTTP server, Apache/etc
# # role :app, "aries.sidways.lab"                          # This may be the same as your `Web` server
# # role :db,  "aries.sidways.lab", :primary => true # This is where Rails migrations will run
# # role :db,  "your slave db-server here"

# #set :user, "rails"
# # set :user, "root"

# set :use_sudo, false

# set :branch, "master"

# default_run_options[:pty] = true
# ssh_options[:forward_agent] = true

# #after "deploy", "deploy:cleanup" # keep only the last 5 releases


# # if you're still using the script/reaper helper you will need
# # these http://github.com/rails/irs_process_scripts

# # If you are using Passenger mod_rails uncomment this:
# namespace :deploy do

#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end

#   task :setup_config, roles: :app do
#     run "mkdir -p #{shared_path}/config"
#     # put File.read("config/database.yml.mysql"), "#{shared_path}/config/database.yml"
#     puts "Now edit the config files in #{shared_path}."
#   end

#   after "deploy:setup", "deploy:setup_config"

#   task :symlink_config, roles: :app do
#     # run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
#   end
#   after "deploy:finalize_update", "deploy:symlink_config"

#   task :bundle_install do
#     run("cd #{deploy_to}/current; bundle install --path=vendor/gems")
#   end

#   #task :migration do
#     #run("cd #{deploy_to}/current; rake db:migrate ")
#   #end

#   task :change_tmp do
#     run("chmod -R 777 #{current_path}/tmp")
#   end
#   #after "deploy:finalize_update", "deploy:change_tmp"

# end

