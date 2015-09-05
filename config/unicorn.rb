worker_processes 3
timeout 30
preload_app true

before_fork do
  Signal.trap 'TERM' do
    Process.kill 'QUIT', Process.pid
  end
  ActiveRecord::Base.connection.disconnect!
end

after_fork do
  Signal.trap 'TERM' do
  end
  ActiveRecord::Base.establish_connection
end
