class HomeController < ApplicationController
  def index
  	 @initial_text = params["session"]
    	@test = "sadfk"
  end
end
