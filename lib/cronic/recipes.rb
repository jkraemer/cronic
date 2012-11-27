# Capistrano Recipes for managing the cronic daemon
#
# Add these callbacks to have the cronic process restart when the server
# is restarted:
#
#   after "deploy:stop",    "cronic:stop"
#   after "deploy:start",   "cronic:start"
#   after "deploy:restart", "cronic:restart"
#
# To only spawn the cronic daemon on a specific server specify the
# cronic_server_role:
#
#   set :cronic_server_role, :cron
#
# You may change the log and pid file locations by defining :cronic_log and
# :cronic_pid. The RAILS_ENV defaults to production and may be changed by
# setting :rails_env.
#

Capistrano::Configuration.instance.load do
  namespace :cronic do
    def rails_env
      "RAILS_ENV=#{fetch(:rails_env, 'production')}"
    end

    def roles
      fetch(:cronic_server_role, :app)
    end

    def cronic_log
      fetch :cronic_log, 'log/cronic.log'
    end

    def cronic_pid
      fetch :cronic_pid, 'tmp/pids/cronic.pid'
    end

    def cronic_command
      fetch(:cronic_command, "script/cronic")
    end

    desc "Stop the cronic process"
    task :stop, :roles => lambda { roles } do
      run "cd #{current_path};#{rails_env} #{cronic_command} -k -P #{cronic_pid}"
    end

    desc "Start the cronic process"
    task :start, :roles => lambda { roles } do
      run "cd #{current_path};#{rails_env} #{cronic_command} -d -l #{cronic_log} -P #{cronic_pid}"
    end

    desc "Restart the cronic process"
    task :restart, :roles => lambda { roles } do
      stop
      start
    end
  end
end
