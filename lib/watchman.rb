require_relative './redis_config'
require 'redis'

class Watchman
  def initialize(logger: logger)
    @redis = Redis.new(RedisConfig.get)
    @logger = logger
  end

  def run_experiment
    @logger.info "Running experiement"
    while true do
      begin
        @redis.set("watch", "man")
        @logger.info "Connection established. Storing key/value"
      rescue Redis::CannotConnectError => err
        report(err)
      end
      sleep 5
    end
  end

  def report(error)
    @logger.warn "Downtime detected at #{Time.now}\n"
    @logger.warn error.message
  end
end
