class HomeController < ApplicationController
  def index
    redirect_to leads_path if user_signed_in?
  end
end
