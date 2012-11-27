class CronicGenerator < Rails::Generators::Base
  source_root File.expand_path("../../../templates", __FILE__)

  desc "Creates the script/cronic daemon control script and sets up job samples in config/cronic.d"

  def create_scheduler_script
    copy_file "script/cronic"
    chmod 'script/cronic', 0755
  end

  def create_jobs_dir
    directory "config/cronic.d"
  end
end
