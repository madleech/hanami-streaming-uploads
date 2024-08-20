#!/usr/bin/env -S falcon host

load :rack

service "upload.test" do
  include Falcon::Environment::Rack

  count ENV.fetch("HANAMI_WEB_CONCURRENCY", 1).to_i

  endpoint Async::HTTP::Endpoint.parse("http://[::]:#{ENV.fetch("HANAMI_PORT", 2300)}")
end
