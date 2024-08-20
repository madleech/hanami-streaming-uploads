# frozen_string_literal: true

module Upload
  class Routes < Hanami::Routes
    # Add your routes here. See https://guides.hanamirb.org/routing/overview/ for details.
    post "/create", to: "create"
  end
end
