Cronic
======

Motivation
----------

While nothing is wrong with Unix cron, it is not the best choice for
regular jobs that require to be run in the context of your Rails
application. Spinning up an instance of the application every 10 minutes
for a job that needs to run this frequently is just a waste of CPU cycles, let
alone the increased memory usage in case different jobs are running in
parallel.

Building blocks
---------------

Cronic itself is only a tiny bit of glue code and a Rails generator.

The scheduling itself is done by [Rufus
Scheduler](https://github.com/jmettraux/rufus-scheduler) . I like this
particular library because it allows you fine grained control over which
jobs may be run in parallel and which have to be run in sequence via
mutexes. It also can avoid overlapping with long running jobs. These are
things that you have to take care of yourself when using Unix cron.
The daemonizing part is provided by
[Dante](https://github.com/bazaarlabs/dante), which is amazingly easy
to use and 'just works'.
Optional Airbrake integration is also included.


Usage
-----

Three easy steps:

**Add Cronic to your Gemfile and run Bundler**

    echo "gem 'cronic'" >> Gemfile
    bundle install

**Run the Rails generator and create job definitions**

    rails g cronic

This will set up `script/cronic`, which you will use to start / stop the
daemon. It also creates the `config/cronic.d` directory where you will
store your job definitions. Have a look at `config/cronic.d/sample.rb`
to get an idea of how to define your jobs. For more information, be sure
to visit the Rufus-Scheduler documentation. Every method that is
available on a Rufus::Scheduler instance can be called in the job
definition files located in `config/cronic.d`.

**Run it**

    script/cronic -d -l log/cronic.log -P tmp/pids/cronic.pid

This will run cronic daemonized, logging to log/cronic.log, with a pid
file located in tmp/pids. To run in the forground for testing purposes,
just run the script without any parameters.

In order to stop the daemon, run

    script/cronic -k -P tmp/pids/cronic.pid


Error handling
--------------

Any exception thrown during job execution will be caught and logged to
STDOUT (which goes into the log file specified on the command line).  If
you have [Airbrake](https://github.com/airbrake/airbrake) set up for
your application, exceptions will also be reported via
`Airbrake.notify`.


Monitoring
----------

The [Dante docs](https://github.com/bazaarlabs/dante) have an example
god script that you can use as a starting point for ensuring your
cronic daemon stays up and running.


Copyright
---------

Copyright 2012 Jens Krämer, jk@jkraemer.net
See [LICENSE](https://github.com/jkraemer/cronic/blob/master/LICENSE)
for details.





