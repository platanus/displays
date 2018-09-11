redis_config = Rails.application.config_for(:redis)
Redis::Client::DEFAULTS[:port] = redis_config['port'] if redis_config
