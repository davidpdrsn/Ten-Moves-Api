worker_processes 4

working_directory "/home/deployer/apps/ten_moves_web/current"

listen "/tmp/unicorn.ten_moves_web.sock", :backlog => 64
listen 8080, :tcp_nopush => true

timeout 30

# feel free to point this anywhere accessible on the filesystem
pid "/home/deployer/apps/ten_moves_web/shared/tmp/pids/unicorn.pid"

stderr_path "/home/deployer/apps/ten_moves_web/shared/log/unicorn.stderr.log"
stdout_path "/home/deployer/apps/ten_moves_web/shared/log/unicorn.stdout.log"

preload_app true
GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

check_client_connection false

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection

  system "/etc/init.d/memcached restart"
end
