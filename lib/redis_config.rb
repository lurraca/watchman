require 'json'

class RedisConfig
  def self.get
    vcap_services ||= JSON.parse(ENV['VCAP_SERVICES'])
    redis_service_name = vcap_services.keys.find { |svc| svc =~ /redis/i }
    redis_service = vcap_services[redis_service_name].first

    redis_config = {
      :host => redis_service['credentials']['host'],
      :port => redis_service['credentials']['port'],
      :password => redis_service['credentials']['password']
    }
  end
end
