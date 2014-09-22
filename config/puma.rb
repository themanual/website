port Integer(ENV['PORT'])

environment ENV['RACK_ENV']

threads Integer(ENV['PUMA_MIN_THREADS'] || 4), Integer(ENV['PUMA_MAX_THREADS'] || 16)

if ENV['PUMA_WORKERS'] && Integer(ENV['PUMA_WORKERS'])>1
  workers Integer(ENV['PUMA_WORKERS'])
  # preload_app!
  #
  # on_worker_boot do
  #   ActiveSupport.on_load(:active_record) do
  #     ActiveRecord::Base.establish_connection
  #   end
  # end
end
