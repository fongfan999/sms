class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  # before_action :navigating_page!
  def index
  end
end
