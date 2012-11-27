# Sample job definitions
#
# All *.rb files found in this directory will be instance_eval'd in the context
# of a Rufus::Scheduler instance, see
# https://github.com/jmettraux/rufus-scheduler for more methods and options.
#
# Jobs will be run with the full Rails application loaded. Consider placing
# your more complex job logic into separate worker classes to keep job
# definitions readable.


# output the current time every 5 minutes
every 5.minutes do
  puts "The current time is: #{Time.now}"
end

# run at noon from monday to friday
cron '0 12 * * 1-5' do
  puts "Go to lunch now."
end

