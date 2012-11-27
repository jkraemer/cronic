require 'rufus/scheduler'

begin
  require 'airbrake'
rescue LoadError
  # ignore
end

module Cronic
  class Scheduler

    def initialize
      @rufus_scheduler = Rufus::Scheduler.start_new
      setup_exception_handler
    end

    def load_jobs(file)
      @rufus_scheduler.instance_eval IO.read file
    end

    # blocks until the scheduler exits for some reason
    def join
      @rufus_scheduler.join
    end

    private

    def setup_exception_handler
      @rufus_scheduler.class_eval do
        define_method :handle_exception do |job, exception|
          puts "job #{job.job_id} caught exception '#{exception}'"
          if defined?(Airbrake)
            Airbrake.notify exception
          else
            puts exception.backtrace.join("\n")
          end
        end
      end
    end

  end
end
