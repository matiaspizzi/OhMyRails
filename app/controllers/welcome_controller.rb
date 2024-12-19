class WelcomeController < ApplicationController
  allow_unauthenticated_access only: %i[  ]

  def index
  end
end