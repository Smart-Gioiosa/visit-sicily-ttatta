class HomeController < ApplicationController
  def index
    @points = Point.all
  end
end
