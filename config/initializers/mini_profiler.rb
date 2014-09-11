Rails.application.middleware.delete(Rack::MiniProfiler)
Rails.application.middleware.insert_after(ActionDispatch::Static, Rack::MiniProfiler)

Rack::MiniProfiler.config.storage = Rack::MiniProfiler::MemcacheStore
