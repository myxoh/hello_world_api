class HomeController < ApplicationController
  def index
	render.json{{object: "Hello world"}}
  end
end
