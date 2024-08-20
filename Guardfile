# frozen_string_literal: true

# modifying this file requires restarting the server otherwise code
# reloading will not work

require "guard/falcon"

group :server do
  guard "falcon", count: 1, url: "http://[::]:#{ENV.fetch("HANAMI_PORT", 2300)}" do
    watch(%r{^(app|config|lib|slices)([\/][^\/]+)*.(rb|erb|haml|slim)$}i)
  end
end
