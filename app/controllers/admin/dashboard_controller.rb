class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with :name => ENV['user'], :password => ENV['password']
  def show
  end
end
