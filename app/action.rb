# auto_register: false
# frozen_string_literal: true

require "hanami/action"

module Upload
  class Action < Hanami::Action
    def verify_csrf_token?(req, res)
      false
    end  
  end
end
