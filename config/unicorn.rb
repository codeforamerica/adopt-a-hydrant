worker_processes 4
timeout 30
preload_app true

before_fork do |_server, _worker|
  Signal.trap 'TERM' do
    Process.kill 'QUIT', Process.pid
  end
  ActiveRecord::Base.connection.disconnect!
end

after_fork do |_server, _worker|
  Signal.trap 'TERM' do
  end
  ActiveRecord::Base.establish_connection
end
